#!/bin/bash

# Test file

set -e

funcName=${1:?}
context=$(kubectl config current-context)
cluster=$(kubectl config view -o jsonpath="{.contexts[?(@.name == '${context}')].context.cluster}")
server=$(kubectl config view -o jsonpath="{.clusters[?(@.name == '${cluster}')].cluster.server}")
token=$(kubectl get -n default secret $(kubectl get -n default serviceaccount default -o jsonpath='{.secrets[].name}') -o jsonpath='{.data.token}' | base64 --decode)

# Avoid to call the service with the default account
kubectl create clusterrolebinding nodejs_ce_verify-admin --clusterrole=cluster-admin --serviceaccount default:default

call=`curl -k -H "Authorization: Bearer $token" \
  -H "CE-EventID: 123" \
  -X POST -d "foo" \
  "${server}/api/v1/namespaces/default/services/${funcName}:http-function-port/proxy/"`

kubectl delete clusterrolebinding nodejs_ce_verify-admin

echo $call | grep foo
kubectl logs -l function=${funcName} | grep "eventID: '123'" 
