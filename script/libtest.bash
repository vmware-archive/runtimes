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

# k8s and kubeless helpers, specially "wait"-ers on pod ready/deleted/etc

KUBECTL_BIN=$(which kubectl)
: ${KUBECTL_BIN:?ERROR: missing binary: kubectl}

export TEST_MAX_WAIT_SEC=300

# Workaround 'bats' lack of forced output support, dup() stderr fd
exec 9>&2
echo_info() {
    test -z "$TEST_DEBUG" && return 0
    echo "INFO: $*" >&9
}
export -f echo_info

kubectl() {
    ${KUBECTL_BIN:?} --context=${TEST_CONTEXT:?} "$@"
}

## k8s specific Helper functions
k8s_wait_for_pod_ready() {
    echo_info "Waiting for pod '${@}' to be ready ... "
    local -i cnt=${TEST_MAX_WAIT_SEC:?}

    # Retries just in case it is not stable
    local -i successCount=0
    while [ "$successCount" -lt "3" ]; do
        if kubectl get pod "${@}" | grep -q Running; then
            ((successCount=successCount+1))
        fi
        ((cnt=cnt-1)) || return 1
        sleep 1
    done
}
k8s_wait_for_pod_count() {
    local pod_cnt=${1:?}; shift
    echo_info "Waiting for pod '${@}' to have count==${pod_cnt} running ... "
    local -i cnt=${TEST_MAX_WAIT_SEC:?}
    # Retries just in case it is not stable
    local -i successCount=0
    while [ "$successCount" -lt "3" ]; do
        if [[ $(kubectl get pod "${@}" -ogo-template='{{.items|len}}') == ${pod_cnt} ]]; then
            ((successCount=successCount+1))
        fi
        ((cnt=cnt-1)) || return 1
        sleep 1
    done
    k8s_wait_for_pod_ready "${@}"
    echo "Finished waiting"
}
k8s_wait_for_uniq_pod() {
    k8s_wait_for_pod_count 1 "$@"
}
k8s_wait_for_pod_gone() {
    echo_info "Waiting for pod '${@}' to be gone ... "
    local -i cnt=${TEST_MAX_WAIT_SEC:?}
    until kubectl get pod "${@}" | grep -q No.resources.found; do
        ((cnt=cnt-1)) || return 1
        sleep 1
    done
}
k8s_wait_for_pod_logline() {
    local string="${1:?}"; shift
    local -i cnt=${TEST_MAX_WAIT_SEC:?}
    echo_info "Waiting for '${@}' to show logline '${string}' ..."
    until kubectl logs "${@}"| grep -q "${string}"; do
        ((cnt=cnt-1)) || return 1
        sleep 1
    done
}
k8s_wait_for_cluster_ready() {
    echo_info "Waiting for k8s cluster to be ready (context=${TEST_CONTEXT}) ..."
    _wait_for_cmd_ok kubectl get po 2>/dev/null && \
    k8s_wait_for_pod_ready -n kube-system -l component=kube-addon-manager && \
    k8s_wait_for_pod_ready -n kube-system -l k8s-app=kube-dns && \
        return 0
    return 1
}
k8s_log_all_pods() {
    local namespaces=${*:?} ns
    for ns in ${*}; do
        echo "### namespace: ${ns} ###"
        kubectl get pod -n ${ns} -oname|xargs -I@ sh -xc "kubectl logs -n ${ns} @|sed 's|^|@: |'"
    done
}
k8s_context_save() {
    TEST_CONTEXT_SAVED=$(${KUBECTL_BIN} config current-context)
    # Kubeless doesn't support contexts yet, save+restore it
    # Don't save current_context if it's the same already
    [[ $TEST_CONTEXT_SAVED == $TEST_CONTEXT ]] && TEST_CONTEXT_SAVED=""

    # Save current_context
    [[ $TEST_CONTEXT_SAVED != "" ]] && \
        echo_info "Saved context: '${TEST_CONTEXT_SAVED}'" && \
        ${KUBECTL_BIN} config use-context ${TEST_CONTEXT}
}
k8s_context_restore() {
    # Restore saved context
    [[ $TEST_CONTEXT_SAVED != "" ]] && \
        echo_info "Restoring context: '${TEST_CONTEXT_SAVED}'" && \
        ${KUBECTL_BIN} config use-context ${TEST_CONTEXT_SAVED}
}
_wait_for_cmd_ok() {
    local cmd="${*:?}"; shift
    local -i cnt=${TEST_MAX_WAIT_SEC:?}
    echo_info "Waiting for '${*}' to successfully exit ..."
    until env ${cmd}; do
        ((cnt=cnt-1)) || return 1
        sleep 1
    done
}

wait_for_ingress() {
    echo_info "Waiting until Nginx pod is ready ..."
    local -i cnt=${TEST_MAX_WAIT_SEC:?}
    until kubectl get pods -l name=nginx-ingress-controller -n kube-system>& /dev/null; do
        ((cnt=cnt-1)) || exit 1
        sleep 1
    done
}

verify_k8s_tools() {
    local tools="kubectl kubeless"
    for exe in $tools; do
        which ${exe} >/dev/null && continue
        echo "ERROR: '${exe}' needs to be installed"
        return 1
    done
}

## Specific for kubeless
kubeless_function_delete() {
    local func=${1:?}; shift
    echo_info "Deleting function "${func}" in case still present ... "
    kubeless function ls |grep -w "${func}" && kubeless function delete "${func}" >& /dev/null || true
    echo_info "Wait for function "${func}" to be deleted "
    local -i cnt=${TEST_MAX_WAIT_SEC:?}
    while kubectl get functions "${func}" >& /dev/null; do
        ((cnt=cnt-1)) || return 1
        sleep 1
    done
}

## Entry points used by 'bats' tests:
deploy_function() {
    local func=${1:?} func_topic
    echo_info "TEST: $func"
    kubeless_function_delete ${func}
    make -s ${func}
}

verify_function() {
    local func=${1:?}
    local make_task=${2:-${func}-verify}
    echo_info "Init logs: $(kubectl logs -l function=${func} -c prepare)"
    k8s_wait_for_pod_ready -l function=${func}
    case "${func}" in
        *pubsub*)
            func_topic=$(kubectl get kafkatrigger "${func}" -o yaml|sed -n 's/topic: //p')
            echo_info "FUNC TOPIC: $func_topic"
    esac
    local -i counter=0
    until make -s ${make_task}; do
        echo_info "FUNC ${func} failed. Retrying..."
        ((counter=counter+1))
        if [ "$counter" -ge 3 ]; then
            echo_info "FUNC ${func} failed ${counter} times. Exiting"
            return 1;
        fi
        sleep `expr 10 \* $counter`
    done
}
test_kubeless_function() {
    local func=${1:?}
    deploy_function $func
    verify_function $func
}
update_function() {
    local func=${1:?} func_topic
    echo_info "UPDATE: $func"
    make -s ${func}-update
    sleep 10
    k8s_wait_for_uniq_pod -l function=${func}
}
test_kubeless_function_update() {
    local func=${1:?}
    update_function $func
    verify_function $func ${func}-update-verify
}
