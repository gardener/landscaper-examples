#!/bin/bash

repo_root_dir="$(dirname $0)/.."
source ${repo_root_dir}/settings


echo "Pipeline, acting as 1d admin for the target cluster"
export KUBECONFIG="${repo_root_dir}/secret-store/core-kubeconfig-admin.yaml"

tenant_id="tenant01"
tenant_namespace="tenant-0001"
instance_name="test"


echo "Creating tenant namespace ${tenant_namespace}"
mako-render "${repo_root_dir}/resources/namespace.yaml.tpl" \
  --var "namespace=${tenant_namespace}" \
  | kubectl apply -f -


echo "Creating landscaper deployment ${instance_name} in tenant namespace ${tenant_namespace}"
mako-render ${repo_root_dir}/6-landscaper-deployment/landscaper-deployment.yaml.tpl \
  --var "namespace=${tenant_namespace}" \
  --var "name=${instance_name}" \
  --var "tenant_id=${tenant_id}" \
  | kubectl apply -f -
