

build72:
	env GOOS=linux GOARCH=amd64 go build $$GOPATH/src/github.com/kubeless/kubeless/pkg/function-proxy/proxy.go
	docker build -t kubeless/php:7.2$$RUNTIME_TAG_MODIFIER -f Dockerfile.7.2 .

push72:
	docker push kubeless/php:7.2$$RUNTIME_TAG_MODIFIER

build73:
	env GOOS=linux GOARCH=amd64 go build $$GOPATH/src/github.com/kubeless/kubeless/pkg/function-proxy/proxy.go
	docker build -t kubeless/php:7.3$$RUNTIME_TAG_MODIFIER -f Dockerfile.7.3 .

push73:
	docker push kubeless/php:7.3$$RUNTIME_TAG_MODIFIER

php-cs-fixer:
	docker run -it --rm -v $${PWD}:/wd -w /wd shouldbee/php-cs-fixer fix Controller.php || true

# Mandatory jobs
build-all: build72 build73
push-all: push72 push73

# Testing jobs
deploy: get-php get-php-deps post-php timeout-php get-php-73
test: get-php-verify get-php-deps-verify post-php-verify timeout-php-verify get-php-73-verify

get-php:
	kubeless function deploy get-php --runtime php7.2 --handler helloget.foo --from-file examples/helloget.php

get-php-verify:
	kubectl rollout status deployment/get-php && sleep 2
	kubeless function call get-php | egrep "hello world"

get-php-73:
	kubeless function deploy get-php-73 --runtime php7.3 --handler helloget.foo --from-file examples/helloget.php

get-php-73-verify:
	kubectl rollout status deployment/get-php-73 && sleep 2
	kubeless function call get-php-73 | egrep "hello world"

get-php-deps:
	kubeless function deploy get-php-deps --runtime php7.2 --handler hellowithdeps.foo --from-file examples/hellowithdeps.php --dependencies examples/composer.json

get-php-deps-verify:
	kubectl rollout status deployment/get-php-deps && sleep 2
	kubeless function call get-php-deps &> /dev/null
	kubectl logs --tail=1000 -l function=get-php-deps | egrep "Hello"

post-php:
	kubeless function deploy post-php --runtime php7.2 --handler hellowithdata.foo --from-file examples/hellowithdata.php

post-php-verify:
	kubectl rollout status deployment/post-php && sleep 2
	kubeless function call post-php --data '{"it-s": "alive"}'| egrep "it.*alive"

timeout-php:
	$(eval TMPDIR := $(shell mktemp -d))
	printf '<?php\n function foo() { while(1) {} } \n' > $(TMPDIR)/hello-loop.php
	kubeless function deploy timeout-php --runtime php7.2 --handler helloget.foo  --from-file $(TMPDIR)/hello-loop.php --timeout 4
	rm -rf $(TMPDIR)

timeout-php-verify:
	kubectl rollout status deployment/timeout-php && sleep 2
	$(eval MSG := $(shell kubeless function call timeout-php 2>&1 || true))
	echo $(MSG) | egrep Request.timeout.exceeded
