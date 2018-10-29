# Testing jobs
deploy: get-nodejs-distroless get-nodejs-distroless-deps
test: get-nodejs-distroless-verify get-nodejs-distroless-deps-verify

get-nodejs-distroless:
	kubeless function deploy get-nodejs-distroless --runtime nodejs_distroless8 --handler helloget.foo --from-file nodejs/helloget.js

get-nodejs-distroless-verify:
	kubeless function call get-nodejs-distroless |egrep hello.world

get-nodejs-distroless-deps:
	kubeless function deploy get-nodejs-distroless-deps --runtime nodejs_distroless8 --handler helloget.handler --from-file nodejs/hellowithdeps.js --dependencies nodejs/package.json

get-nodejs-distroless-deps-verify:
	kubeless function call get-nodejs-distroless-deps --data '{"hello": "world"}' | grep -q 'hello.*world.*date.*UTC'
