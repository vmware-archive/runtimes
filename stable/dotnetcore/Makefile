# Testing jobs
deploy: get-dotnetcore get-dotnetcore-dependency post-dotnetcore get-dotnetcore20 get-dotnetcore-dependency20
test: get-dotnetcore-verify get-dotnetcore-dependency-verify post-dotnetcore-verify get-dotnetcore-verify20 get-dotnetcore-dependency-verify20

# .NET Core 2.1

get-dotnetcore:
	kubeless function deploy get-dotnetcore --runtime dotnetcore2.1 --handler module.handler --from-file examples/helloget.cs

get-dotnetcore-verify:
	kubectl rollout status deployment/get-dotnetcore && sleep 2
	kubeless function call get-dotnetcore |egrep hello.world
	kubeless function top --function get-dotnetcore --out yaml |egrep "Function does not expose metrics" 

get-dotnetcore-dependency:
	kubeless function deploy get-dotnetcore-dependency --runtime dotnetcore2.1 --handler module.handler --from-file examples/dependency-yaml.cs --dependencies examples/dependency-yaml.csproj

get-dotnetcore-dependency-verify:
	kubectl rollout status deployment/get-dotnetcore-dependency && sleep 2
	kubeless function call get-dotnetcore-dependency |egrep Name:\ Michael

post-dotnetcore:
	kubeless function deploy post-dotnetcore --runtime dotnetcore2.1 --handler module.handler --from-file examples/hellowithdata.cs

post-dotnetcore-verify:
	kubectl rollout status deployment/post-dotnetcore && sleep 2
	kubeless function call post-dotnetcore --data '{"it-s": "alive"}'|egrep "it.*alive"

# NET Core 2.0

get-dotnetcore20:
	kubeless function deploy get-dotnetcore20 --runtime dotnetcore2.0 --handler module.handler --from-file examples/helloget.cs

get-dotnetcore-verify20:
	kubectl rollout status deployment/get-dotnetcore20 && sleep 2
	kubeless function call get-dotnetcore20 |egrep hello.world
	kubeless function top --function get-dotnetcore20 --out yaml |egrep "Function does not expose metrics" 

get-dotnetcore-dependency20:
	kubeless function deploy get-dotnetcore-dependency20 --runtime dotnetcore2.0 --handler module.handler --from-file examples/dependency-yaml.cs --dependencies examples/dependency-yaml.csproj

get-dotnetcore-dependency-verify20:
	kubectl rollout status deployment/get-dotnetcore-dependency20 && sleep 2
	kubeless function call get-dotnetcore-dependency20 |egrep Name:\ Michael