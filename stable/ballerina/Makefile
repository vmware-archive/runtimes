init-image:
	docker build -f Dockerfile.init -t ballerina/kubeless-ballerina-init:0.981.0 .

runtime-image:
	env GOOS=linux GOARCH=amd64 go build $$GOPATH/src/github.com/kubeless/kubeless/pkg/function-proxy/proxy.go
	docker build -f Dockerfile -t ballerina/kubeless-ballerina:0.981.0 .

push-init:
	docker push ballerina/kubeless-ballerina-init:0.981.0

push-runtime:
	docker push ballerina/kubeless-ballerina:0.981.0

# Mandatory jobs
build-all: init-image runtime-image
push-all: push-init push-runtime

# Testing jobs
deploy: get-ballerina get-ballerina-custom-port get-ballerina-data get-ballerina-conf
test: get-ballerina-verify get-ballerina-custom-port-verify get-ballerina-data-verify get-ballerina-conf-verify

get-ballerina:
	kubeless function deploy get-ballerina --runtime ballerina0.981.0 --from-file ballerina/helloget.bal --handler helloget.foo

get-ballerina-verify:
	kubeless function call get-ballerina |egrep Hello.World.Ballerina

get-ballerina-custom-port:
	kubeless function deploy get-ballerina-custom-port --runtime ballerina0.981.0 --handler helloget.foo --from-file ballerina/helloget.bal --port 8083

get-ballerina-custom-port-verify:
	kubectl get svc get-ballerina-custom-port -o yaml | grep 'targetPort: 8083'
	kubeless function call get-ballerina-custom-port |egrep Hello.World.Ballerina

get-ballerina-data:
	kubeless function deploy get-ballerina-data --runtime ballerina0.981.0 --from-file ballerina/hellowithdata.bal --handler hellowithdata.foo

get-ballerina-data-verify:
	kubeless function call get-ballerina-data --data '{"hello":"world"}' |egrep hello

get-ballerina-conf:
	zip -r -j ballerina/bar.zip ballerina/hello_with_conf/
	kubeless function deploy get-ballerina-conf --runtime ballerina0.981.0 --from-file ballerina/bar.zip --handler hello_with_conf.bar
	rm ballerina/bar.zip

get-ballerina-conf-verify:
	kubeless function call get-ballerina-conf | egrep john
