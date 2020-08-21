#!/bin/bash
GO_VERSION="1.14"

set -e

# Copy function
if [[ -e "/kubeless/go.mod" && ! -s "/kubeless/go.mod" ]]; then
  # Remove empty go.mod
  rm /kubeless/go.mod
fi
cp /kubeless/* /server/function/

# Replace FUNCTION placeholder
sed "s/<<FUNCTION>>/${KUBELESS_FUNC_NAME}/g" /server/kubeless.go.tpl > /server/kubeless.go
# Build command
cd /server
GOOS=linux GOARCH=amd64 go build -o $KUBELESS_INSTALL_VOLUME/server .
