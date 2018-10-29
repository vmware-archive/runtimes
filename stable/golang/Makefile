init-image:
	docker build -f Dockerfile.init -t kubeless/go-init:1.10 ../../../

runtime-image:
	docker build -f Dockerfile -t kubeless/go:1.10 .

push-init:
	docker push kubeless/go-init:1.10

push-runtime:
	docker push kubeless/go:1.10

# Mandatory jobs
build-all: init-image runtime-image
push-all: push-init push-runtime

# Testing jobs
deploy: get-go get-go-custom-port timeout-go get-go-deps post-go
test: get-go-verify get-go-custom-port-verify timeout-go-verify get-go-deps-verify post-go-verify

get-go:
	kubeless function deploy get-go --runtime go1.10 --handler handler.Foo --from-file examples/helloget.go

get-go-verify:
	kubectl rollout status deployment/get-go && sleep 2
	kubeless function call get-go |egrep Hello.world

get-go-custom-port:
	kubeless function deploy get-go-custom-port --runtime go1.10 --handler helloget.Foo --from-file examples/helloget.go --port 8083

get-go-custom-port-verify:
	kubectl rollout status deployment/get-go-custom-port && sleep 2
	kubectl get svc get-go-custom-port -o yaml | grep 'targetPort: 8083'
	kubeless function call get-go-custom-port |egrep Hello.world

timeout-go:
	$(eval TMPDIR := $(shell mktemp -d))
	printf 'package kubeless\nimport "github.com/kubeless/kubeless/pkg/functions"\nfunc Foo(event functions.Event, context functions.Context) (string, error) {\nfor{\n}\nreturn "", nil\n}' > $(TMPDIR)/hello-loop.js
	kubeless function deploy timeout-go --runtime go1.10 --handler helloget.Foo  --from-file $(TMPDIR)/hello-loop.js --timeout 4
	rm -rf $(TMPDIR)

timeout-go-verify:
	kubectl rollout status deployment/timeout-go && sleep 2
	$(eval MSG := $(shell kubeless function call timeout-go 2>&1 || true))
	echo $(MSG) | egrep Request.timeout.exceeded

get-go-deps:
	kubeless function deploy get-go-deps --runtime go1.10 --handler helloget.Hello --from-file examples/hellowithdeps.go --dependencies examples/Gopkg.toml

get-go-deps-verify:
	kubectl rollout status deployment/get-go-deps && sleep 2
	kubeless function call get-go-deps --data '{"hello": "world"}'
	kubectl logs -l function=get-go-deps | grep -q 'level=info msg=.*hello.*world'

post-go:
	kubeless function deploy post-go --runtime go1.10 --handler hellowithdata.Handler --from-file examples/hellowithdata.go

post-go-verify:
	kubectl rollout status deployment/post-go && sleep 2
	kubeless function call post-go --data '{"it-s": "alive"}'| egrep "it.*alive"
	# Verify event context
	logs=`kubectl logs -l function=post-go`; \
	echo $$logs | grep -q "it.*alive" && \
	echo $$logs | grep -q "UTC" && \
	echo $$logs | grep -q "application/json" && \
	echo $$logs | grep -q "cli.kubeless.io"
