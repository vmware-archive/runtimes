init-image:
	docker build --no-cache -f Dockerfile.init -t kubeless/java-init:1.8 .

runtime-image:
	docker build --no-cache -f Dockerfile -t kubeless/java:1.8 .

init-image-1.11:
	docker build --no-cache -f Dockerfile.11.init -t kubeless/java-init:11 .

runtime-image-1.11:
	docker build --no-cache -f Dockerfile.11 -t kubeless/java:11 .

push-init:
	docker push kubeless/java-init:1.8

push-runtime:
	docker push kubeless/java:1.8

push-init-1.11:
	docker push kubeless/java-init:11

push-runtime-1.11:
	docker push kubeless/java:11

build-all: init-image runtime-image init-image-1.11 runtime-image-1.11
push-all: push-init push-runtime push-init-1.11 push-runtime-1.11

# Testing jobs
deploy: get-java post-java get-java-deps get-java-11
test: get-java-verify post-java-verify get-java-deps-verify get-java-11-verify

get-java:
	kubeless function deploy get-java --runtime java1.8 --handler Foo.foo --from-file examples/HelloGet.java

get-java-verify:
	kubectl rollout status deployment/get-java && sleep 2
	kubeless function call get-java |egrep Hello.world

get-java-11:
	kubeless function deploy get-java-11 --runtime java11 --handler Foo.foo --from-file examples/HelloGet.java

get-java-11-verify:
	kubectl rollout status deployment/get-java-11 && sleep 2
	kubeless function call get-java-11 |egrep Hello.world

post-java:
	kubeless function deploy post-java --runtime java1.8  --handler Foo.foo --from-file examples/HelloWithData.java

post-java-verify:
	kubectl rollout status deployment/post-java && sleep 2
	kubeless function call post-java --data '{"its": "alive"}'| egrep "its.*alive"

get-java-deps:
	kubeless function deploy get-java-deps --runtime java1.8 --handler Hello.sayHello --from-file examples/HelloWithDeps.java --dependencies examples/pom.xml

get-java-deps-verify:
	kubectl rollout status deployment/get-java-deps && sleep 2
	kubeless function call get-java-deps --data '{"hello": "world"}'
	kubectl logs --tail=1000 -l function=get-java-deps | grep -q '.*Hello.*world! Current local time is:'
