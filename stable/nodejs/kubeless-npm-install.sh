#!/bin/bash

set -e

export HOME="/tmp"
registry=${NPM_REGISTRY:-"https://registry.npmjs.org"}
scope="${NPM_SCOPE:-""}"

if [[ -n ${scope} ]]; then
  scope=${scope}:
fi

cd $KUBELESS_INSTALL_VOLUME
pnpm config set ${scope}registry ${registry}

if [[ -n ${NPM_CONFIG_EXTRA} ]]; then
  pnpm config set ${NPM_CONFIG_EXTRA}
fi

pnpm install --prod --dir $KUBELESS_INSTALL_VOLUME
