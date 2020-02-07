
build2.7:
	docker build -t kubeless/python:2.7$$RUNTIME_TAG_MODIFIER -f Dockerfile.2.7 .

build3.4:
	docker build -t kubeless/python:3.4$$RUNTIME_TAG_MODIFIER -f Dockerfile.3.4 .

build3.6:
	docker build -t kubeless/python:3.6$$RUNTIME_TAG_MODIFIER -f Dockerfile.3.6 .

build3.7:
	docker build -t kubeless/python:3.7$$RUNTIME_TAG_MODIFIER -f Dockerfile.3.7 .

build3.7gdal:
	docker build -t kubeless/python:3.7gdal$$RUNTIME_TAG_MODIFIER -f Dockerfile.3.7gdal .

push2.7:
	docker push kubeless/python:2.7$$RUNTIME_TAG_MODIFIER

push3.4:
	docker push kubeless/python:3.4$$RUNTIME_TAG_MODIFIER

push3.6:
	docker push kubeless/python:3.6$$RUNTIME_TAG_MODIFIER

push3.7:
	docker push kubeless/python:3.7$$RUNTIME_TAG_MODIFIER

# Mandatory jobs
build-all: build2.7 build3.4 build3.6 build3.7
push-all: push2.7 push3.4 push3.6 push3.7

# Testing jobs
deploy: get-python get-python-deps get-python-custom-port get-python-34 get-python-36 get-python-37 get-python-url-deps scheduled-get-python timeout-python get-python-secrets post-python post-python-custom-port custom-get-python
test: get-python-verify get-python-deps-verify get-python-custom-port-verify get-python-34-verify get-python-36-verify get-python-37-verify get-python-url-deps-verify scheduled-get-python-verify timeout-python-verify get-python-secrets-verify custom-get-python-verify post-python-verify post-python-custom-port-verify

get-python:
	kubeless function deploy get-python --runtime python2.7 --handler helloget.foo --from-file examples/helloget.py

get-python-verify:
	kubectl rollout status deployment/get-python && sleep 2
	kubeless function call get-python |egrep hello.world
	kubeless function top --function get-python --out yaml |egrep total_calls.*[1-100000]

get-python-deps:
	cd examples && zip hellowithdeps.zip hellowithdeps.py  hellowithdepshelper.py && cd ..
	kubeless function deploy get-python-deps --runtime python2.7 --handler hellowithdeps.foo --from-file examples/hellowithdeps.zip --dependencies examples/requirements.txt

get-python-deps-verify:
	kubectl rollout status deployment/get-python-deps && sleep 2
	kubeless function call get-python-deps |egrep Google

get-python-custom-port:
	kubeless function deploy get-python-custom-port --runtime python2.7 --handler helloget.foo --from-file examples/helloget.py --port 8081

get-python-custom-port-verify:
	kubectl rollout status deployment/get-python-custom-port && sleep 2
	kubectl get svc get-python-custom-port -o yaml | grep 'targetPort: 8081'
	kubeless function call get-python-custom-port |egrep hello.world

get-python-34:
	kubeless function deploy get-python-34 --runtime python3.4 --handler helloget.foo --from-file examples/helloget.py

get-python-34-verify:
	kubectl rollout status deployment/get-python-34 && sleep 2
	kubeless function call get-python-34 |egrep hello.world

get-python-36:
	kubeless function deploy get-python-36 --runtime python3.6 --handler helloget.foo --from-file examples/helloget.py

get-python-36-verify:
	kubectl rollout status deployment/get-python-36 && sleep 2
	kubeless function call get-python-36 |egrep hello.world

get-python-37:
	kubeless function deploy get-python-37 --runtime python3.7 --handler helloget.foo --from-file examples/helloget.py

get-python-37-verify:
	kubectl rollout status deployment/get-python-37 && sleep 2
	kubeless function call get-python-37 |egrep hello.world

get-python-url-deps:
	kubeless function deploy get-python-url-deps --runtime python2.7 --handler helloget.foo --from-file https://raw.githubusercontent.com/kubeless/kubeless/v1.0.0-alpha.1/examples/python/hellowithdeps.py --dependencies https://raw.githubusercontent.com/kubeless/kubeless/v1.0.0-alpha.1/examples/python/requirements.txt

get-python-url-deps-verify:
	kubectl rollout status deployment/get-python-url-deps && sleep 2
	kubeless function call get-python-url-deps |egrep Google

scheduled-get-python:
	kubeless function deploy scheduled-get-python --schedule "* * * * *" --runtime python2.7 --handler helloget.foo --from-file examples/helloget.py

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
	kubeless function deploy timeout-python --runtime python2.7 --handler helloget.foo  --from-file $(TMPDIR)/hello-loop.py --timeout 3
	rm -rf $(TMPDIR)

timeout-python-verify:
	kubectl rollout status deployment/timeout-python && sleep 2
	$(eval MSG := $(shell kubeless function call timeout-python 2>&1 || true))
	echo $(MSG) | egrep Request.timeout.exceeded

get-python-secrets:
	kubectl create secret generic test-secret --from-literal=key=MY_KEY || true
	kubeless function deploy get-python-secrets --runtime python2.7 --handler helloget.foo --from-file examples/helloget.py --secrets test-secret

get-python-secrets-verify:
	kubectl rollout status deployment/get-python-secrets && sleep 2
	$(eval pod := $(shell kubectl get pod -l function=get-python-secrets -o go-template -o custom-columns=:metadata.name --no-headers=true))
	kubectl exec -it $(pod) cat /test-secret/key | egrep "MY_KEY"

custom-get-python:
	kubeless function deploy --runtime-image kubeless/get-python-example@sha256:6a14400f14e26d46a971445b7a850af533fe40cb75a67297283bdf536e09ca5e custom-get-python

custom-get-python-verify:
	kubectl rollout status deployment/custom-get-python && sleep 2
	kubeless function call custom-get-python |egrep hello.world

post-python:
	kubeless function deploy post-python --runtime python2.7 --handler hellowithdata.handler --from-file examples/hellowithdata.py

post-python-verify:
	kubectl rollout status deployment/post-python && sleep 2
	kubeless function call post-python --data '{"it-s": "alive"}'|egrep "it.*alive"
	# Verify event context
	logs=`kubectl logs --tail=1000 -l function=post-python`; \
	echo $$logs | grep -q "it.*alive" && \
	echo $$logs | grep -q "event-time.*Z" && \
	echo $$logs | grep -q "event-type.*application/json" && \
	echo $$logs | grep -q "event-namespace.*cli.kubeless.io" && \
	echo $$logs | grep -q "event-id.*"

post-python-custom-port:
	kubeless function deploy post-python-custom-port --runtime python2.7 --handler hellowithdata.handler --from-file examples/hellowithdata.py --port 8081

post-python-custom-port-verify:
	kubectl rollout status deployment/post-python-custom-port && sleep 2
	kubectl get svc post-python-custom-port -o yaml | grep 'targetPort: 8081'
	kubeless function call post-python-custom-port --data '{"it-s": "alive"}'|egrep "it.*alive"
