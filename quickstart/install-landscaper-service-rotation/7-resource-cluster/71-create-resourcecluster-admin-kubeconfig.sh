#!/bin/bash

repo_root_dir="$(dirname $0)/.."
source ${repo_root_dir}/settings


echo "Pipeline, acting as resourcecluster project admin"
export KUBECONFIG="${repo_root_dir}/secret-store/resourcecluster-project-kubeconfig-admin.yaml"


echo "Call garden api to obtain a 1d admin kubeconfig for the resource shoot cluster"
# expirationSeconds: 86400 is 1 day
kubectl create \
  --raw "/apis/core.gardener.cloud/v1beta1/namespaces/${resourcecluster_project}/shoots/${resourcecluster_shoot}/adminkubeconfig" \
  -f <(echo '{"apiVersion": "authentication.gardener.cloud/v1alpha1", "kind": "AdminKubeconfigRequest", "spec": {"expirationSeconds": 86400}}') \
  | jq -r ".status.kubeconfig" | base64 -d > "${repo_root_dir}/secret-store/resourcecluster-kubeconfig-admin.yaml"
