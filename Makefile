kubectl:
	@if ! which kubectl >/dev/null; then \
	KUBECTL_VERSION=$$(wget -qO- https://storage.googleapis.com/kubernetes-release/release/stable.txt); \
	sudo wget -q -O /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/$$KUBECTL_VERSION/bin/$$(go env GOOS)/$$(go env GOARCH)/kubectl; \
	sudo chmod +x /usr/local/bin/kubectl; \
	fi

kubeless:
	mkdir -p $$GOPATH/src/github.com/kubeless/; \
	cd $$GOPATH/src/github.com/kubeless/; \
	git clone https://github.com/kubeless/kubeless; \
	cd kubeless/; \
	make bootstrap; \
	make all-yaml; \
	make binary; \
	sudo mv $$GOPATH/bin/kubeless /usr/local/bin/

bootstrap: kubectl kubeless

test:
	./script/integration-tests
