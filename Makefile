kubectl:
	@if ! which kubectl >/dev/null; then \
	KUBECTL_VERSION=$$(wget -qO- https://storage.googleapis.com/kubernetes-release/release/stable.txt); \
	sudo wget -q -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$$KUBECTL_VERSION/bin/$$(go env GOOS)/$$(go env GOARCH)/kubectl; \
	sudo chmod +x /usr/local/bin/kubectl; \
	fi

kubeless:
	export BUILD_NUM=`curl -s https://circleci.com/api/v1.1/project/github/kubeless/kubeless/tree/master\?limit\=20\&offset\=5\&filter\=completed | jq '.[] | select(.workflows.job_name == "build") | .build_num' | head -n 1`; \
	export KUBELESS_BIN_URL=`curl -s https://circleci.com/api/v1.1/project/github/kubeless/kubeless/$$BUILD_NUM/artifacts | jq -r '.[] | select(.path == "home/circleci/.go_workspace/bin/kubeless") | .url'`; \
	curl -LO $$KUBELESS_BIN_URL; \
	chmod +x kubeless; \
	sudo mv kubeless /usr/local/bin; \
	export KUBELESS_YML_URL=`curl -s https://circleci.com/api/v1.1/project/github/kubeless/kubeless/$$BUILD_NUM/artifacts | jq -r '.[] | select(.path == "home/circleci/.go_workspace/src/github.com/kubeless/kubeless/build-manifests/kubeless.yaml") | .url'`; \
	curl -LO $$KUBELESS_YML_URL

bootstrap: kubectl kubeless
 
test:
	./script/integration-tests
