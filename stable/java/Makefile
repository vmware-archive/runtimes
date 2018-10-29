init-image:
	docker build -f Dockerfile.init -t kubeless/java-init:1.8 .

runtime-image:
	docker build -f Dockerfile -t kubeless/java:1.8 .

push-init:
	docker push kubeless/java-init:1.8

push-runtime:
	docker push kubeless/java:1.8

build-all: init-image runtime-image
push-all: push-init push-runtime

# Testing jobs
deploy: get-java post-java get-java-deps
test: get-java-verify post-java-verify get-java-deps-verify

get-java:
	kubeless function deploy get-java --runtime java1.8 --handler Foo.foo --from-file java/HelloGet.java

get-java-verify:
	kubectl rollout status deployment/get-java && sleep 2
	kubeless function call get-java |egrep Hello.world

post-java:
	kubeless function deploy post-java --runtime java1.8  --handler Foo.foo --from-file java/HelloWithData.java

post-java-verify:
	kubectl rollout status deployment/post-java && sleep 2
	kubeless function call post-java --data '{"its": "alive"}'| egrep "its.*alive"

get-java-deps:
	kubeless function deploy get-java-deps --runtime java1.8 --handler Hello.sayHello --from-file java/HelloWithDeps.java --dependencies java/pom.xml

get-java-deps-verify:
	kubectl rollout status deployment/get-java-deps && sleep 2
	kubeless function call get-java-deps --data '{"hello": "world"}'
	kubectl logs -l function=get-java-deps | grep -q '.*Hello.*world! Current local time is:'
