

build:
	env GOOS=linux GOARCH=amd64 go build $$GOPATH/src/github.com/kubeless/kubeless/pkg/function-proxy/proxy.go
	docker build -t kubeless/php:7.2$$RUNTIME_TAG_MODIFIER .

push:
	docker push kubeless/php:7.2$$RUNTIME_TAG_MODIFIER

php-cs-fixer:
	docker run -it --rm -v $${PWD}:/wd -w /wd shouldbee/php-cs-fixer fix Controller.php || true

# Mandatory jobs
build-all: build
push-all: push

# Testing jobs
deploy: get-php get-php-deps post-php timeout-php
test: get-php-verify get-php-deps-verify post-php-verify timeout-php-verify
update: get-php-update get-php-deps-update
update-verify: get-php-update-verify get-php-deps-update-verify

get-php:
	kubeless function deploy get-php --runtime php7.2 --handler helloget.foo --from-file examples/helloget.php

get-php-update:
	$(eval TMPDIR := $(shell mktemp -d))
	printf '<?php\n function foo() { return "hello world updated"; } \n' > $(TMPDIR)/hello-updated.php
	kubeless function update get-php --from-file $(TMPDIR)/hello-updated.php
	rm -rf $(TMPDIR)

get-php-update-verify:
	kubectl rollout status deployment/get-php && sleep 2
	kubeless function call get-php | egrep "hello.world.updated"

get-php-verify:
	kubectl rollout status deployment/get-php && sleep 2
	kubeless function call get-php | egrep "hello world"

get-php-deps:
	kubeless function deploy get-php-deps --runtime php7.2 --handler hellowithdeps.foo --from-file examples/hellowithdeps.php --dependencies examples/composer.json

get-php-deps-verify:
	kubectl rollout status deployment/get-php-deps && sleep 2
	kubeless function call get-php-deps &> /dev/null
	kubectl logs -l function=get-php-deps | egrep "Hello"

get-php-deps-update:
	$(eval TMPDIR := $(shell mktemp -d))
	sed "s/1\.23/1\.20/" examples/composer.json > $(TMPDIR)/composer.json
	kubeless function update get-php-deps --dependencies $(TMPDIR)/composer.json

get-php-deps-update-verify:
	kubectl rollout status deployment/get-php-deps && sleep 2
	$(eval pod := $(shell kubectl get pod -l function=get-php-deps -o go-template -o custom-columns=:metadata.name --no-headers=true))
	kubectl exec -it $(pod) cat /kubeless/composer.json | egrep "1.20"

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
