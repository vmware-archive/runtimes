# Testing jobs
deploy: get-dotnetcore get-dotnetcore-dependency
test: get-dotnetcore-verify get-dotnetcore-dependency-verify

get-dotnetcore:
	kubeless function deploy get-dotnetcore --runtime dotnetcore2.0 --handler module.handler --from-file dotnetcore/helloget.cs

get-dotnetcore-verify:
	kubeless function call get-dotnetcore |egrep hello.world
	kubeless function top --function get-dotnetcore --out yaml |egrep "Function does not expose metrics" 

get-dotnetcore-dependency:
	kubeless function deploy get-dotnetcore-dependency --runtime dotnetcore2.0 --handler module.handler --from-file dotnetcore/dependency-yaml.cs --dependencies dotnetcore/dependency-yaml.csproj

get-dotnetcore-dependency-verify:
	kubeless function call get-dotnetcore-dependency |egrep Name:\ Michael

post-dotnetcore:
	kubeless function deploy post-dotnetcore --runtime dotnetcore2.0 --handler module.handler --from-file dotnetcore/hellowithdata.cs

post-dotnetcore-verify:
	kubeless function call post-dotnetcore --data '{"it-s": "alive"}'|egrep "it.*alive"
