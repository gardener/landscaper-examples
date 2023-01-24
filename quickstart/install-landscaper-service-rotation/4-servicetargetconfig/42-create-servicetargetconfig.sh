#!/bin/bash

repo_root_dir="$(dirname $0)/.."
source ${repo_root_dir}/settings


echo "Pipeline, acting as 1d admin for the core shoot cluster"
export KUBECONFIG="${repo_root_dir}/secret-store/core-kubeconfig-admin.yaml"


servicetargetconfig_name="target-01"


echo "Creating servicetargetconfig secret"
mako-render ${repo_root_dir}/resources/secret.yaml.tpl \
  --var "namespace=${laas_namespace}" \
  --var "name=${servicetargetconfig_name}" \
  --var "key=kubeconfig" \
  --var "value=$(base64 < ${repo_root_dir}/secret-store/target-kubeconfig-ls-installer.yaml)" \
  | kubectl apply -f -


echo "Creating servicetargetconfig"
mako-render ${repo_root_dir}/resources/servicetargetconfig.yaml.tpl \
  --var "namespace=${laas_namespace}" \
  --var "name=${servicetargetconfig_name}" \
  --var "key=kubeconfig" \
  --var "ingress_domain=${target_ingress_domain}" \
  | kubectl apply -f -
