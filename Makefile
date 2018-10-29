kubectl:
	@if ! which kubectl >/dev/null; then \
	KUBECTL_VERSION=$$(wget -qO- https://storage.googleapis.com/kubernetes-release/release/stable.txt); \
	sudo wget -q -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$$KUBECTL_VERSION/bin/$$(go env GOOS)/$$(go env GOARCH)/kubectl; \
	sudo chmod +x /usr/local/bin/kubectl; \
	fi

kubeless:
	@if ! which kubeless >/dev/null; then \
	wget https://github.com/kubeless/kubeless/releases/download/$$KUBELESS_VERSION/kubeless_linux-amd64.zip; \
	unzip kubeless_linux-amd64.zip; \
	sudo mv bundles/kubeless_linux-amd64/kubeless /usr/local/bin/kubeless; \
	fi

bootstrap: kubectl kubeless

test:
	./script/integration-tests
