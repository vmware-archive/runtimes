kubectl:
	@if ! which kubectl >/dev/null; then \
	KUBECTL_VERSION=$$(wget -qO- https://storage.googleapis.com/kubernetes-release/release/stable.txt); \
	sudo wget -q -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$$KUBECTL_VERSION/bin/$$(go env GOOS)/$$(go env GOARCH)/kubectl; \
	sudo chmod +x /usr/local/bin/kubectl; \
	fi

kubecfg:
	@if ! which kubecfg >/dev/null; then \
	sudo wget -q -O /usr/local/bin/kubecfg https://github.com/ksonnet/kubecfg/releases/download/v0.9.0/kubecfg-$$(go env GOOS)-$$(go env GOARCH); \
	sudo chmod +x /usr/local/bin/kubecfg; \
	fi

kubeless: kubecfg
	export BUILD_NUM=`curl -s https://circleci.com/api/v1.1/project/github/kubeless/kubeless/tree/master\?limit\=20\&offset\=5\&filter\=completed | jq '.[] | select(.workflows.job_name == "build") | .build_num' | head -n 1`; \
	export KUBELESS_BIN_URL=`curl -s https://circleci.com/api/v1.1/project/github/kubeless/kubeless/$$BUILD_NUM/artifacts | jq -r '.[] | select(.path == "home/circleci/.go_workspace/bin/kubeless") | .url'`; \
	curl -LO $$KUBELESS_BIN_URL; \
	chmod +x kubeless; \
	sudo mv kubeless /usr/local/bin; \
	mkdir -p $$GOPATH/src/github.com/kubeless/; \
	cd $$GOPATH/src/github.com/kubeless/; \
	git clone https://github.com/kubeless/kubeless; \
	cd kubeless/; \
	git clone --depth=1 https://github.com/ksonnet/ksonnet-lib.git; \
	export KUBECFG_JPATH=$$GOPATH/src/github.com/kubeless/kubeless/ksonnet-lib; \
	kubecfg show -J $$HOME/project -o yaml kubeless.jsonnet > $$HOME/project/kubeless.yaml;

bootstrap: kubectl kubeless
 
test:
	./script/integration-tests
