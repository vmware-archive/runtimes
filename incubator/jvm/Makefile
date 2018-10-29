.PHONY: build-all
init-image:
	docker build -f Dockerfile.init -t kubeless/jvm-init:1.8 .

runtime-image:
	docker build -f Dockerfile -t kubeless/jvm:1.8 .

push-init:
	docker push kubeless/jvm-init:1.8

push-runtime:
	docker push kubeless/jvm:1.8

build-all: init-image runtime-image
push-all: push-init push-runtime

# Testing jobs
deploy: get-jvm-java
test: get-jvm-java-verify

get-jvm-java:
	kubeless function deploy get-jvm-java --runtime jvm1.8 --from-file examples/java/test-java-jvm.jar --handler io_ino_Handler.sayHello

get-jvm-java-verify:
	kubectl rollout status deployment/get-jvm-java && sleep 2
	kubeless function call get-jvm-java | grep "Hello world"
