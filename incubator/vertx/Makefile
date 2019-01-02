init-image:
	docker build -f Dockerfile.init -t oscardovao/vertx-init:1.8 .

runtime-image:
	docker build -f Dockerfile -t oscardovao/vertx:1.8 .

push-init:
	docker push oscardovao/vertx-init:1.8

push-runtime:
	docker push oscardovao/vertx:1.8

build-all: init-image runtime-image
push-all: push-init push-runtime

# Testing jobs
deploy: get-java-vertx post-java-vertx get-java-deps-vertx
test: get-java-vertx-verify post-java-vertx-verify get-java-deps-vertx-verify

get-java-vertx:
	kubeless function deploy get-java-vertx --runtime vertx1.8 --handler Foo.foo --from-file examples/HelloGet.java

get-java-vertx-verify:
	kubectl rollout status deployment/get-java-vertx && sleep 2
	kubeless function call get-java-vertx |egrep Hello.world

post-java-vertx:
	kubeless function deploy post-java-vertx --runtime vertx1.8  --handler Foo.foo --from-file examples/HelloWithData.java

post-java-vertx-verify:
	kubectl rollout status deployment/post-java-vertx && sleep 2
	kubeless function call post-java-vertx --data '{"its": "alive"}'| egrep "its.*alive"

get-java-deps-vertx:
	kubeless function deploy get-java-deps-vertx --runtime vertx1.8 --handler Hello.sayHello --from-file examples/HelloWithDeps.java --dependencies examples/pom.xml

get-java-deps-vertx-verify:
	kubectl rollout status deployment/get-java-deps-vertx && sleep 2
	kubeless function call get-java-deps-vertx --data '{"hello": "world"}'
	kubectl logs --tail=1000 -l function=get-java-deps-vertx | grep -q '.*Hello.*world! Current local time is:'
