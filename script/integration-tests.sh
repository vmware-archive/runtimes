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
kubectl create -f ${ROOT_DIR}/kubeless.yaml
kubectl rollout status -n kubeless deployment/kubeless-controller-manager

make -C ${ROOT_DIR}/${target} deploy
make -C ${ROOT_DIR}/${target} test

exit_code=$?

# Just showing remaining k8s objects
kubectl get all --all-namespaces

if [ ${exit_code} -ne 0 -o -n "${TRAVIS_DUMP_LOGS}" ]; then
    echo "INFO: Build ERRORed, dumping logs: ##"
    for ns in kubeless default; do
        echo "### LOGs: namespace: ${ns} ###"
        kubectl get pod -n ${ns} -oname|xargs -I@ sh -xc "kubectl logs -n ${ns} @|sed 's|^|@: |'"
    done
    echo "INFO: Description"
    kubectl describe pod -l created-by=kubeless
fi
[ ${exit_code} -eq 0 ] && echo "INFO: $0: SUCCESS" || echo "ERROR: $0: FAILED"
exit ${exit_code}
