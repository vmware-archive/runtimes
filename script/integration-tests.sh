#!/usr/bin/env bash

# Copyright (c) 2016-2017 Bitnami
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
set -e

target=${1:?}

ROOT_DIR=`cd "$( dirname "${BASH_SOURCE[0]}" )/.." >/dev/null && pwd`

# Check for some needed tools, install (some) if missing
which bats > /dev/null || {
   echo "ERROR: 'bats' is required to run these tests," \
        "install it from https://github.com/sstephenson/bats"
   exit 255
}

# Start a k8s cluster (minikube, dind) if not running
kubectl get nodes || {
    cluster_up=./script/cluster-up-minikube.sh
    ${cluster_up}
}

# Both RBAC'd dind and minikube seem to be missing rules to make kube-dns work properly
# add some (granted) broad ones:
kubectl get clusterrolebinding kube-dns-admin >& /dev/null || \
    kubectl create clusterrolebinding kube-dns-admin --serviceaccount=kube-system:default --clusterrole=cluster-admin

kubectl create namespace kubeless
kubectl create -f ${GOPATH}/src/github.com/kubeless/kubeless/kubeless.yaml
kubectl rollout status -n kubeless deployment/kubeless-controller-manager

make -C ${ROOT_DIR}/${target} deploy
make -C ${ROOT_DIR}/${target} test
