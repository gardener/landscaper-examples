#!/bin/bash

repo_root_dir="$(dirname $0)/.."
source ${repo_root_dir}/settings


echo "Pipeline, acting as 1d admin for the core shoot cluster"
export KUBECONFIG="${repo_root_dir}/secret-store/core-kubeconfig-admin.yaml"


echo "Create secret containing admin kubeconfig of resourcecluster project"
mako-render "${repo_root_dir}/resources/secret.yaml.tpl" \
  --var "namespace=${laas_namespace}" \
  --var "name=resourcecluster-project-kubeconfig" \
  --var "key=kubeconfig" \
  --var "value=$(base64 < ${repo_root_dir}/secret-store/resourcecluster-project-kubeconfig-admin.yaml)" \
  | kubectl apply -f -
