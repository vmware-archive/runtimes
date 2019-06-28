
build2.4:
	env GOOS=linux GOARCH=amd64 go build $$GOPATH/src/github.com/kubeless/kubeless/pkg/function-proxy/proxy.go
	docker build -t kubeless/ruby:2.4$$RUNTIME_TAG_MODIFIER -f Dockerfile.2.4 .

build2.5:
	env GOOS=linux GOARCH=amd64 go build $$GOPATH/src/github.com/kubeless/kubeless/pkg/function-proxy/proxy.go
	docker build -t kubeless/ruby:2.5$$RUNTIME_TAG_MODIFIER -f Dockerfile.2.5 .

build2.6:
	env GOOS=linux GOARCH=amd64 go build $$GOPATH/src/github.com/kubeless/kubeless/pkg/function-proxy/proxy.go
	docker build -t kubeless/ruby:2.6$$RUNTIME_TAG_MODIFIER -f Dockerfile.2.6 .

push2.4:
	docker push kubeless/ruby:2.4$$RUNTIME_TAG_MODIFIER

push2.5:
	docker push kubeless/ruby:2.5$$RUNTIME_TAG_MODIFIER

push2.6:
	docker push kubeless/ruby:2.6$$RUNTIME_TAG_MODIFIER

# Mandatory jobs
build-all: build2.4 build2.5 build2.6
push-all: push2.4 push2.5 push2.6

# Testing jobs
deploy: get-ruby get-ruby-deps get-ruby-custom-port timeout-ruby post-ruby get-ruby26
test: get-ruby-verify get-ruby-deps-verify get-ruby-custom-port-verify timeout-ruby-verify post-ruby-verify get-ruby26-verify

get-ruby:
	kubeless function deploy get-ruby --runtime ruby2.4 --handler helloget.foo --from-file examples/helloget.rb

get-ruby-verify:
	kubectl rollout status deployment/get-ruby && sleep 2
	kubeless function call get-ruby |egrep hello.world

get-ruby26:
	kubeless function deploy get-ruby26 --runtime ruby2.6 --handler helloget.foo --from-file examples/helloget.rb

get-ruby26-verify:
	kubectl rollout status deployment/get-ruby26 && sleep 2
	kubeless function call get-ruby26 |egrep hello.world

get-ruby-deps:
	kubeless function deploy get-ruby-deps --runtime ruby2.4 --handler hellowithdeps.foo --from-file examples/hellowithdeps.rb --dependencies examples/Gemfile

get-ruby-deps-verify:
	kubectl rollout status deployment/get-ruby-deps && sleep 2
	kubeless function call get-ruby-deps |egrep hello.world

get-ruby-custom-port:
	kubeless function deploy get-ruby-custom-port --runtime ruby2.4 --handler helloget.foo --from-file examples/helloget.rb --port 8082

get-ruby-custom-port-verify:
	kubectl rollout status deployment/get-ruby-custom-port && sleep 2
	kubectl get svc get-ruby-custom-port -o yaml | grep 'targetPort: 8082'
	kubeless function call get-ruby-custom-port |egrep hello.world

timeout-ruby:
	$(eval TMPDIR := $(shell mktemp -d))
	printf 'def foo(event, context)\n%4swhile true do;sleep(1);end\n%4s"hello world"\nend' > $(TMPDIR)/hello-loop.rb
	kubeless function deploy timeout-ruby --runtime ruby2.4 --handler helloget.foo  --from-file $(TMPDIR)/hello-loop.rb --timeout 4
	rm -rf $(TMPDIR)

timeout-ruby-verify:
	kubectl rollout status deployment/timeout-ruby && sleep 2
	$(eval MSG := $(shell kubeless function call timeout-ruby 2>&1 || true))
	echo $(MSG) | egrep Request.timeout.exceeded

post-ruby:
	kubeless function deploy post-ruby --runtime ruby2.4 --handler hellowithdata.handler --from-file examples/hellowithdata.rb

post-ruby-verify:
	kubectl rollout status deployment/post-ruby && sleep 2
	kubeless function call post-ruby --data '{"it-s": "alive"}'|egrep "it.*alive"
	# Verify event context
	logs=`kubectl logs --tail=1000 -l function=post-ruby`; \
	echo $$logs | grep -q "it.*alive" && \
	echo $$logs | grep -q "event-time.*Z" && \
	echo $$logs | grep -q "event-type.*application/json" && \
	echo $$logs | grep -q "event-namespace.*cli.kubeless.io" && \
	echo $$logs | grep -q "event-id.*"
