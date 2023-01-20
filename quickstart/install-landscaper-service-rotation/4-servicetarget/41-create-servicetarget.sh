#!/bin/bash

repo_root_dir="$(dirname $0)/.."
source ${repo_root_dir}/settings


echo "Pipeline, acting as 1d admin for the core shoot cluster"
export KUBECONFIG="${repo_root_dir}/secret-store/core-kubeconfig-admin.yaml"


servicetarget_name="default"
secret_name="${servicetarget_name}-servicetarget"


# TODO: create serviceaccount on the target cluster.
# Its role must allow to install landscapers on the target cluster.
# Create a token for the serviceaccount, build a kubeconfig, and store it in the secret below.


echo "Creating servicetarget secret"
mako-render ${repo_root_dir}/resources/secret.yaml.tpl \
  --var "namespace=${laas_namespace}" \
  --var "name=${secret_name}" \
  --var "key=kubeconfig" \
  --var "value=$(base64 < ${repo_root_dir}/secret-store/target-kubeconfig-admin.yaml)" \
  | kubectl apply -f -


echo "Creating servicetarget"
mako-render ${repo_root_dir}/resources/servicetarget.yaml.tpl \
  --var namespace="${laas_namespace}" \
  --var name="${servicetarget_name}" \
  --var secret_name="${secret_name}" \
  | kubectl apply -f -
