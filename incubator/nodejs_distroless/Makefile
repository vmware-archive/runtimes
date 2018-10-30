build8:
	cp ../../stable/nodejs/kubeless.js .
	cp ../../stable/nodejs/package.json .
	cp -r ../../stable/nodejs/lib .
	docker build -t kubeless/nodejs-distroless:8$$RUNTIME_TAG_MODIFIER -f Dockerfile.8.opt .

push8:
	docker push kubeless/nodejs-distroless:8$$RUNTIME_TAG_MODIFIER

# Mandatory jobs
build-all: build8
push-all: push8

# Testing jobs
deploy: get-nodejs-distroless get-nodejs-distroless-deps
test: get-nodejs-distroless-verify get-nodejs-distroless-deps-verify

get-nodejs-distroless:
	kubeless function deploy get-nodejs-distroless --runtime nodejs_distroless8 --handler helloget.foo --from-file ../../stable/nodejs/examples/helloget.js

get-nodejs-distroless-verify:
	kubectl rollout status deployment/get-nodejs-distroless && sleep 2
	kubeless function call get-nodejs-distroless |egrep hello.world

get-nodejs-distroless-deps:
	kubeless function deploy get-nodejs-distroless-deps --runtime nodejs_distroless8 --handler helloget.handler --from-file ../../stable/nodejs/examples/hellowithdeps.js --dependencies ../../stable/nodejs/examples/package.json

get-nodejs-distroless-deps-verify:
	kubectl rollout status deployment/get-nodejs-distroless-deps && sleep 2
	kubeless function call get-nodejs-distroless-deps --data '{"hello": "world"}' | grep -q 'hello.*world.*date.*UTC'
