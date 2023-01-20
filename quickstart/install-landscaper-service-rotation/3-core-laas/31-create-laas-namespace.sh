#!/bin/bash

repo_root_dir="$(dirname $0)/.."
source ${repo_root_dir}/settings


echo "Pipeline, acting as 1d admin for the core shoot cluster"
export KUBECONFIG="${repo_root_dir}/secret-store/core-kubeconfig-admin.yaml"


echo "Creating namespace ${laas_namespace}"
mako-render "${repo_root_dir}/resources/namespace.yaml.tpl" \
  --var "namespace=${laas_namespace}" \
  | kubectl apply -f -
