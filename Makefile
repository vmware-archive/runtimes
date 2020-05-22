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
	export LATEST_RELEASE=`curl -s https://api.github.com/repos/kubeless/kubeless/releases | jq -r '.[0].tag_name'`; \
	curl -LO https://github.com/kubeless/kubeless/releases/download/$$LATEST_RELEASE/kubeless_linux-amd64.zip; \
	unzip -p kubeless_linux-amd64.zip bundles/kubeless_linux-amd64/kubeless > kubeless
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
