#!/bin/bash

repo_root_dir="$(dirname $0)/.."
source ${repo_root_dir}/settings


echo "Acting as resourcecluster admin"
export KUBECONFIG="${repo_root_dir}/secret-store/resourcecluster-kubeconfig-admin.yaml"


echo "Creating namespace registration"
mako-render ${repo_root_dir}/resources/namespaceregistration.yaml.tpl \
  --var "namespace=${customer_namespace}" \
  | kubectl apply -f -
