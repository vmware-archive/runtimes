#!/bin/bash

set -e

export HOME="/tmp"
registry=${NPM_REGISTRY:-"https://registry.npmjs.org"}
scope="${NPM_SCOPE:-""}"

if [[ -n ${scope} ]]; then
  scope=${scope}:
fi

cd $KUBELESS_INSTALL_VOLUME
npm config set ${scope}registry ${registry}
npm install --production --prefix=$KUBELESS_INSTALL_VOLUME
