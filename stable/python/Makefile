GIT_SHA1 ?= master
BASE_URL := https://raw.githubusercontent.com/kubeless/runtimes/$(GIT_SHA1)

# Wait until the Pod is in ready state. Without a readinessProbe it is not possible to
# tell exactly when the Pod is ready to accept requests. So, adding additional sleep
# (default = 2 seconds).
define rollout-status
  kubectl rollout status deployment/$(patsubst %-verify,%,$1) && sleep $(if $2,$2,2)
endef

build3.6:
	docker build --pull --no-cache -t kubeless/python:3.6$$RUNTIME_TAG_MODIFIER -f Dockerfile.3.6 .

build3.7:
	docker build --pull --no-cache -t kubeless/python:3.7$$RUNTIME_TAG_MODIFIER -f Dockerfile.3.7 .

build3.8:
	docker build --pull --no-cache -t kubeless/python:3.8$$RUNTIME_TAG_MODIFIER -f Dockerfile.3.8 .

push3.6:
	docker push kubeless/python:3.6$$RUNTIME_TAG_MODIFIER

push3.7:
	docker push kubeless/python:3.7$$RUNTIME_TAG_MODIFIER

push3.8:
	docker push kubeless/python:3.8$$RUNTIME_TAG_MODIFIER

# Mandatory jobs
build-all: build3.6 build3.7 build3.8
push-all: push3.6 push3.7 push3.8

# Testing jobs
deploy: get-python-deps get-python-custom-port get-python-36 get-python-37 get-python-38 get-python-url-deps scheduled-get-python timeout-python get-python-secrets post-python post-python-custom-port custom-get-python python-preload
test: get-python-deps-verify get-python-custom-port-verify get-python-36-verify get-python-37-verify get-python-38-verify get-python-url-deps-verify scheduled-get-python-verify timeout-python-verify get-python-secrets-verify custom-get-python-verify post-python-verify post-python-custom-port-verify python-preload-verify

get-python-deps:
	cd examples && zip hellowithdeps.zip hellowithdeps.py hellowithdepshelper.py
	kubeless function deploy get-python-deps --runtime python3.6 --handler hellowithdeps.foo --from-file examples/hellowithdeps.zip --dependencies examples/requirements.txt

get-python-deps-verify:
	$(call rollout-status,$@,5)
	kubeless function call get-python-deps |egrep Google

get-python-custom-port:
	kubeless function deploy get-python-custom-port --runtime python3.6 --handler helloget.foo --from-file examples/helloget.py --port 8081

get-python-custom-port-verify:
	$(call rollout-status,$@)
	kubectl get svc get-python-custom-port -o yaml | grep 'targetPort: 8081'
	kubeless function call get-python-custom-port |egrep hello.world

get-python-36:
	kubeless function deploy get-python-36 --runtime python3.6 --handler helloget.foo --from-file examples/helloget.py

get-python-36-verify:
	$(call rollout-status,$@)
	kubeless function call get-python-36 |egrep hello.world

get-python-37:
	kubeless function deploy get-python-37 --runtime python3.7 --handler helloget.foo --from-file examples/helloget.py

get-python-37-verify:
	$(call rollout-status,$@)
	kubeless function call get-python-37 |egrep hello.world

get-python-38:
	kubeless function deploy get-python-38 --runtime python3.8 --handler helloget.foo --from-file examples/helloget.py

get-python-38-verify:
	$(call rollout-status,$@)
	kubeless function call get-python-38 |egrep hello.world

get-python-url-deps:
	cd examples && zip hellowithdeps.zip hellowithdeps.py hellowithdepshelper.py
	kubeless function deploy get-python-url-deps --runtime python3.6 --handler hellowithdeps.foo --from-file examples/hellowithdeps.zip --dependencies $(BASE_URL)/stable/python/examples/requirements.txt

get-python-url-deps-verify:
	$(call rollout-status,$@)
	kubeless function call get-python-url-deps |egrep Google

scheduled-get-python:
	kubeless function deploy scheduled-get-python --schedule "* * * * *" --runtime python3.6 --handler helloget.foo --from-file examples/helloget.py

scheduled-get-python-verify:
	number="1"; \
	timeout="70"; \
	found=false; \
	while [ $$number -le $$timeout ] ; do \
		pod=`kubectl get po -oname -l function=scheduled-get-python`; \
		logs=`kubectl logs $$pod | grep "GET / HTTP/1.1\" 200 11 \"\""`; \
    	if [ "$$logs" != "" ]; then \
			found=true; \
			break; \
		fi; \
		sleep 1; \
		number=`expr $$number + 1`; \
	done; \
	$$found

timeout-python:
	$(eval TMPDIR := $(shell mktemp -d))
	printf 'def foo(event, context):\n%4swhile 1: pass\n%4sreturn "hello world"\n' > $(TMPDIR)/hello-loop.py
	kubeless function deploy timeout-python --runtime python3.6 --handler helloget.foo  --from-file $(TMPDIR)/hello-loop.py --timeout 3
	rm -rf $(TMPDIR)

timeout-python-verify:
	$(call rollout-status,$@)
	$(eval MSG := $(shell kubeless function call timeout-python 2>&1 || true))
	echo $(MSG) | egrep Request.timeout.exceeded

get-python-secrets:
	kubectl create secret generic test-secret --from-literal=key=MY_KEY || true
	kubeless function deploy get-python-secrets --runtime python3.6 --handler helloget.foo --from-file examples/helloget.py --secrets test-secret

get-python-secrets-verify:
	$(call rollout-status,$@)
	$(eval pod := $(shell kubectl get pod -l function=get-python-secrets -o go-template -o custom-columns=:metadata.name --no-headers=true))
	kubectl exec -it $(pod) cat /test-secret/key | egrep "MY_KEY"

custom-get-python:
	kubeless function deploy --runtime-image kubeless/get-python-example@sha256:6a14400f14e26d46a971445b7a850af533fe40cb75a67297283bdf536e09ca5e custom-get-python

custom-get-python-verify:
	$(call rollout-status,$@)
	kubeless function call custom-get-python |egrep hello.world

post-python:
	kubeless function deploy post-python --runtime python3.6 --handler hellowithdata.handler --from-file examples/hellowithdata.py

post-python-verify:
	$(call rollout-status,$@)
	kubeless function call post-python --data '{"it-s": "alive"}'|egrep "it.*alive"
	# Verify event context
	logs=`kubectl logs --tail=1000 -l function=post-python`; \
	echo $$logs | grep -q "it.*alive" && \
	echo $$logs | grep -q "event-time.*Z" && \
	echo $$logs | grep -q "event-type.*application/json" && \
	echo $$logs | grep -q "event-namespace.*cli.kubeless.io" && \
	echo $$logs | grep -q "event-id.*"

post-python-custom-port:
	kubeless function deploy post-python-custom-port --runtime python3.6 --handler hellowithdata.handler --from-file examples/hellowithdata.py --port 8081

post-python-custom-port-verify:
	$(call rollout-status,$@)
	kubectl get svc post-python-custom-port -o yaml | grep 'targetPort: 8081'
	kubeless function call post-python-custom-port --data '{"it-s": "alive"}'|egrep "it.*alive"

python-preload:
	cd examples && zip preload.zip preload.py preloadhelper.py
	kubeless function deploy python-preload --runtime python3.6 --handler preload.handler --from-file examples/preload.zip --timeout 3

python-preload-verify:
	$(call rollout-status,$@,10)
	kubeless function call python-preload |egrep hello.world
