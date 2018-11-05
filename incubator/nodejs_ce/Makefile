build8:
	cp -r ../../stable/nodejs/lib .
	docker build -t andresmgot/nodejs-ce:8$$RUNTIME_TAG_MODIFIER -f Dockerfile.8.opt .

push8:
	docker push andresmgot/nodejs-ce:8$$RUNTIME_TAG_MODIFIER

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
