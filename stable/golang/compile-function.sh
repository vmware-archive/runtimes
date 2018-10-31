#!/bin/bash

set -e

# Replace FUNCTION placeholder
sed "s/<<FUNCTION>>/${KUBELESS_FUNC_NAME}/g" $GOPATH/src/controller/kubeless.tpl.go > $GOPATH/src/controller/kubeless.go 
# Remove vendored version of kubeless if exists
rm -rf $GOPATH/src/kubeless/vendor/github.com/kubeless/kubeless
# Build command
go build -o $KUBELESS_INSTALL_VOLUME/server $GOPATH/src/controller/kubeless.go > /dev/termination-log 2>&1
