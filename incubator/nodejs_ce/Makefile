build8:
	cp -r ../../stable/nodejs/lib .
	cp -r ../../stable/nodejs/kubeless-npm-install.sh .
	docker build -t andresmgot/nodejs-ce:8$$RUNTIME_TAG_MODIFIER -f Dockerfile.8 .

push8:
	docker push andresmgot/nodejs-ce:8$$RUNTIME_TAG_MODIFIER

# Mandatory jobs
build-all: build8
push-all: push8

# Testing jobs
deploy: post-nodejs-ce
test: post-nodejs-ce-verify

post-nodejs-ce:
	kubeless function deploy post-nodejs-ce --runtime nodejsCE8 --handler helloget.handler --from-file ../../stable/nodejs/examples/hellowithdata.js

post-nodejs-ce-verify:
	sleep 2
	kubectl rollout status deployment/post-nodejs-ce && sleep 2
	./verify.sh post-nodejs-ce
