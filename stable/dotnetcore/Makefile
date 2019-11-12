# Testing jobs
deploy: deploy22 deploy21 deploy20

deploy22: get-dotnetcore get-dotnetcore-dependency post-dotnetcore get-dotnetcore-namespaced 
deploy21: get-dotnetcore21 get-dotnetcore-dependency21 post-dotnetcore21 get-dotnetcore-namespaced21  
deploy20: get-dotnetcore20 get-dotnetcore-dependency20

test: test22 test21 test20

test22: get-dotnetcore-verify get-dotnetcore-dependency-verify post-dotnetcore-verify get-dotnetcore-namespaced-verify 
test21: get-dotnetcore-verify21 get-dotnetcore-dependency-verify21 post-dotnetcore-verify21 get-dotnetcore-namespaced-verify21 
test20: get-dotnetcore-verify20 get-dotnetcore-dependency-verify20

clean: clean22 clean21 clean20

clean22: get-dotnetcore-clean get-dotnetcore-dependency-clean post-dotnetcore-clean get-dotnetcore-namespaced-clean
clean21: get-dotnetcore-clean21 get-dotnetcore-dependency-clean21 post-dotnetcore-clean21 get-dotnetcore-namespaced-clean21
clean20: get-dotnetcore-clean20 get-dotnetcore-dependency-clean20


# .NET Core 2.2

get-dotnetcore:
	kubeless function deploy get-dotnetcore --runtime dotnetcore2.2 --handler module.handler --from-file examples/helloget.cs

get-dotnetcore-verify:
	kubectl rollout status deployment/get-dotnetcore && sleep 2
	kubeless function call get-dotnetcore |egrep hello.world
	kubeless function top --function get-dotnetcore --out yaml |egrep "function: get-dotnetcore" 

get-dotnetcore-clean:
	kubeless function delete get-dotnetcore
	
get-dotnetcore-dependency:
	kubeless function deploy get-dotnetcore-dependency --runtime dotnetcore2.2 --handler module.handler --from-file examples/dependency-yaml.cs --dependencies examples/dependency-yaml.csproj

get-dotnetcore-dependency-verify:
	kubectl rollout status deployment/get-dotnetcore-dependency && sleep 2
	kubeless function call get-dotnetcore-dependency |egrep Name:\ Michael

get-dotnetcore-dependency-clean:
	kubeless function delete get-dotnetcore-dependency

post-dotnetcore:
	kubeless function deploy post-dotnetcore --runtime dotnetcore2.2 --handler module.handler --from-file examples/hellowithdata.cs

post-dotnetcore-verify:
	kubectl rollout status deployment/post-dotnetcore && sleep 2
	kubeless function call post-dotnetcore --data '{"it-s": "alive"}'|egrep "it.*alive"
	
post-dotnetcore-clean:
	kubeless function delete post-dotnetcore

get-dotnetcore-namespaced:
	kubeless function deploy get-dotnetcore-namespaced --runtime dotnetcore2.2 --handler module.handler --from-file examples/namespaced-helloget.cs

get-dotnetcore-namespaced-verify:
	kubectl rollout status deployment/get-dotnetcore-namespaced && sleep 2
	kubeless function call get-dotnetcore-namespaced |egrep hello.world

get-dotnetcore-namespaced-clean:
	kubeless function delete get-dotnetcore-namespaced

# .NET Core 2.1

get-dotnetcore21:
	kubeless function deploy get-dotnetcore21 --runtime dotnetcore2.1 --handler module.handler --from-file examples/helloget.cs

get-dotnetcore-verify21:
	kubectl rollout status deployment/get-dotnetcore21 && sleep 2
	kubeless function call get-dotnetcore21 |egrep hello.world
	kubeless function top --function get-dotnetcore21 --out yaml |egrep "Function does not expose metrics" 

get-dotnetcore-clean21:
	kubeless function delete get-dotnetcore21

get-dotnetcore-dependency21:
	kubeless function deploy get-dotnetcore-dependency21 --runtime dotnetcore2.1 --handler module.handler --from-file examples/dependency-yaml.cs --dependencies examples/dependency-yaml.csproj

get-dotnetcore-dependency-verify21:
	kubectl rollout status deployment/get-dotnetcore-dependency21 && sleep 2
	kubeless function call get-dotnetcore-dependency21 |egrep Name:\ Michael

get-dotnetcore-dependency-clean21:
	kubeless function delete get-dotnetcore-dependency21

post-dotnetcore21:
	kubeless function deploy post-dotnetcore21 --runtime dotnetcore2.1 --handler module.handler --from-file examples/hellowithdata.cs

post-dotnetcore-verify21:
	kubectl rollout status deployment/post-dotnetcore21 && sleep 2
	kubeless function call post-dotnetcore21 --data '{"it-s": "alive"}'|egrep "it.*alive"
	
post-dotnetcore-clean21:
	kubeless function delete post-dotnetcore21
	
get-dotnetcore-namespaced21:
	kubeless function deploy get-dotnetcore-namespaced21 --runtime dotnetcore2.1 --handler module.handler --from-file examples/namespaced-helloget.cs

get-dotnetcore-namespaced-verify21:
	kubectl rollout status deployment/get-dotnetcore-namespaced21 && sleep 2
	kubeless function call get-dotnetcore-namespaced21 |egrep hello.world
	
get-dotnetcore-namespaced-clean21:
	kubeless function delete get-dotnetcore-namespaced21

# NET Core 2.0

get-dotnetcore20:
	kubeless function deploy get-dotnetcore20 --runtime dotnetcore2.0 --handler module.handler --from-file examples/helloget.cs

get-dotnetcore-verify20:
	kubectl rollout status deployment/get-dotnetcore20 && sleep 2
	kubeless function call get-dotnetcore20 |egrep hello.world
	kubeless function top --function get-dotnetcore20 --out yaml |egrep "Function does not expose metrics" 
	
get-dotnetcore-clean20:
	kubeless function delete get-dotnetcore20
	
get-dotnetcore-dependency20:
	kubeless function deploy get-dotnetcore-dependency20 --runtime dotnetcore2.0 --handler module.handler --from-file examples/dependency-yaml.cs --dependencies examples/dependency-yaml.csproj

get-dotnetcore-dependency-verify20:
	kubectl rollout status deployment/get-dotnetcore-dependency20 && sleep 2
	kubeless function call get-dotnetcore-dependency20 |egrep Name:\ Michael
	
get-dotnetcore-dependency-clean20:
	kubeless function delete get-dotnetcore-dependency20
	
	
# build docker
# please set TARGET_REPOSITORY and RUNTIME_TAG_MODIFIER as env variables before using the docker build commands

REPOSITORY		:= ${TARGET_REPOSITORY}
RUNTIME_NAME	:= ${REPOSITORY}/kubless_runtime_dotnetcore22
COMPILE_NAME	:= ${REPOSITORY}/kubless_compile_dotnetcore22
TAG				:= ${RUNTIME_TAG_MODIFIER}
RUNTIME_IMG		:= ${RUNTIME_NAME}
COMPILE_IMG		:= ${COMPILE_NAME}

build-runtime:
	docker build -f Dockerfile.2.2 -t ${RUNTIME_IMG}:${TAG} .

push-runtime:
	docker push ${RUNTIME_IMG}:${TAG}

build-compile:
	docker build -f Dockerfile.init.2.2 -t ${COMPILE_IMG}:$(TAG) .
	
push-compile:
	docker push ${COMPILE_IMG}:${TAG}