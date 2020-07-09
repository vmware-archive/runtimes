
build10:
	docker build --pull --no-cache -t kubeless/nodejs:10$$RUNTIME_TAG_MODIFIER -f Dockerfile.10 .

build12:
	docker build --pull --no-cache -t kubeless/nodejs:12$$RUNTIME_TAG_MODIFIER -f Dockerfile.12 .

build14:
	docker build --pull --no-cache -t kubeless/nodejs:14$$RUNTIME_TAG_MODIFIER -f Dockerfile.14 .

push6:
	docker push kubeless/nodejs:6$$RUNTIME_TAG_MODIFIER

push8:
	docker push kubeless/nodejs:8$$RUNTIME_TAG_MODIFIER

push10:
	docker push kubeless/nodejs:10$$RUNTIME_TAG_MODIFIER

push12:
	docker push kubeless/nodejs:12$$RUNTIME_TAG_MODIFIER

push14:
	docker push kubeless/nodejs:14$$RUNTIME_TAG_MODIFIER

# Mandatory jobs
build-all: build10 build12 build14
push-all: push10 push12 push14

# Testing jobs
deploy: get-nodejs get-nodejs14 get-node-url-zip get-nodejs-custom-port get-nodejs-stream timeout-nodejs get-nodejs-deps get-nodejs-multi post-nodejs get-nodejs-extra-conf nodejs-multipart
test: get-nodejs-verify get-nodejs14-verify get-node-url-zip-verify get-nodejs-custom-port-verify get-nodejs-stream-verify timeout-nodejs-verify get-nodejs-deps-verify get-nodejs-multi-verify post-nodejs-verify get-nodejs-extra-conf-verify nodejs-multipart-verify

get-node-url-zip:
	kubeless function deploy get-node-url-zip --runtime nodejs12 --handler index.helloGet --from-file https://github.com/kubeless/kubeless/blob/master/examples/nodejs/helloFunctions.zip?raw=true

get-node-url-zip-verify:
	kubectl rollout status deployment/get-node-url-zip && sleep 2
	kubeless function call get-node-url-zip |egrep hello.world

get-nodejs:
	kubeless function deploy get-nodejs --runtime nodejs12 --handler helloget.foo --from-file examples/helloget.js

get-nodejs-verify:
	kubectl rollout status deployment/get-nodejs && sleep 2
	kubeless function call get-nodejs |egrep hello.world

get-nodejs14:
	kubeless function deploy get-nodejs14 --runtime nodejs14 --handler helloget.foo --from-file examples/helloget.js

get-nodejs14-verify:
	kubectl rollout status deployment/get-nodejs14 && sleep 2
	kubeless function call get-nodejs14 |egrep hello.world

get-nodejs-custom-port:
	kubeless function deploy get-nodejs-custom-port --runtime nodejs12 --handler helloget.foo --from-file examples/helloget.js --port 8083

get-nodejs-custom-port-verify:
	kubectl rollout status deployment/get-nodejs-custom-port && sleep 2
	kubectl get svc get-nodejs-custom-port -o yaml | grep 'targetPort: 8083'
	kubeless function call get-nodejs-custom-port |egrep hello.world

get-nodejs-stream:
	kubeless function deploy get-nodejs-stream --runtime nodejs12 --handler hellostream.foo --from-file examples/hellostream.js --dependencies examples/package.json

get-nodejs-stream-verify:
	kubectl rollout status deployment/get-nodejs-stream && sleep 2
	kubeless function call get-nodejs-stream |egrep hello.world

timeout-nodejs:
	$(eval TMPDIR := $(shell mktemp -d))
	printf 'module.exports = { foo: function (event, context) { while(true) {} } }\n' > $(TMPDIR)/hello-loop.js
	kubeless function deploy timeout-nodejs --runtime nodejs12 --handler helloget.foo  --from-file $(TMPDIR)/hello-loop.js --timeout 4
	rm -rf $(TMPDIR)

timeout-nodejs-verify:
	kubectl rollout status deployment/timeout-nodejs && sleep 2
	$(eval MSG := $(shell kubeless function call timeout-nodejs 2>&1 || true))
	echo $(MSG) | egrep Request.timeout.exceeded

get-nodejs-deps:
	kubeless function deploy get-nodejs-deps --runtime nodejs12 --handler helloget.handler --from-file examples/hellowithdeps.js --dependencies examples/package.json

get-nodejs-deps-verify:
	kubectl rollout status deployment/get-nodejs-deps && sleep 2
	kubeless function call get-nodejs-deps --data '{"hello": "world"}' | grep -q 'hello.*world.*date'

get-nodejs-multi:
	cd examples; zip helloFunctions.zip *js
	kubeless function deploy get-nodejs-multi --runtime nodejs12 --handler index.helloGet --from-file examples/helloFunctions.zip
	rm examples/helloFunctions.zip

get-nodejs-multi-verify:
	kubectl rollout status deployment/get-nodejs-multi && sleep 2
	kubeless function call get-nodejs-multi |egrep hello.world

post-nodejs:
	kubeless function deploy post-nodejs --runtime nodejs12 --handler hellowithdata.handler --from-file examples/hellowithdata.js

post-nodejs-verify:
	kubectl rollout status deployment/post-nodejs && sleep 2
	kubeless function call post-nodejs --data '{"it-s": "alive"}'|egrep "it.*alive"
	# Verify event context
	logs=`kubectl logs --tail=1000 -l function=post-nodejs`; \
	echo $$logs | grep -q "it.*alive" && \
	echo $$logs | grep -q "event-time.*Z" && \
	echo $$logs | grep -q "event-type.*application/json" && \
	echo $$logs | grep -q "event-namespace.*cli.kubeless.io" && \
	echo $$logs | grep -q "event-id.*"

get-nodejs-extra-conf:
	kubeless function deploy nodejs-extra-conf --env NPM_CONFIG_EXTRA='foo:bar' --runtime nodejs12 --handler helloget.foo --from-file examples/helloget.js

get-nodejs-extra-conf-verify:
	kubectl rollout status deployment/nodejs-extra-conf && sleep 2
	$(eval POD := $(shell kubectl get po -l function=nodejs-extra-conf -o jsonpath="{.items[0].metadata.name}" 2>&1 || true))
	kubectl exec $(POD) -- npm config list | grep foo:bar

nodejs-multipart:
	kubeless function deploy hello-multipart --runtime nodejs12 --handler hello-multipart.handler --from-file examples/hello-multipart.js --dependencies examples/multipart-package.json

start-proxy:
	kubectl proxy & sleep 2

nodejs-multipart-verify: start-proxy
	kubectl rollout status deployment/hello-multipart && sleep 2
	curl \
		--header "Content-Type:multipart/form-data" \
		-F "prop=This is a normal prop" \
		-F "file=@examples/resources/input.txt" \
		127.0.0.1:8001/api/v1/namespaces/default/services/hello-multipart:http-function-port/proxy/ | egrep "hello world"
