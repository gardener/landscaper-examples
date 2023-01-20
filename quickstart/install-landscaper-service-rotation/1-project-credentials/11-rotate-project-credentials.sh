#!/bin/bash

repo_root_dir="$(dirname $0)/.."
source ${repo_root_dir}/settings


echo "Set sam kubeconfig for laas project: ${laas_project_kubeconfig_sam}"
export KUBECONFIG="${laas_project_kubeconfig_sam}"


echo "Assume that an admin service account for the laas project already exists"
echo "Call token request api to obtain a 90d kubeconfig for admin serviceaccount of laas project"
# --duration=7776000s are 90 days

token=$(kubectl create token -n ${laas_project} ${laas_project_serviceaccount_admin} --duration=7776000s)

# Alternative:
# kubectl create \
#   --raw "/api/v1/namespaces/${laas_project}/serviceaccounts/${laas_project_admin_service_account}/token" \
#   -f <(echo '{"spec":{"expirationSeconds": 7776000}}') \
#   | jq -r .status.token


echo "Reading server from sam kubeconfig"
server=$(yq '.clusters.0.cluster.server' < "${laas_project_kubeconfig_sam}")


echo "Write kubeconfig of admin serviceaccount for the laas project to the secret store"
mako-render "${repo_root_dir}/resources/kubeconfig.yaml.tpl" \
  --var "cluster=${laas_project}" \
  --var "namespace=${laas_project}" \
  --var "server=${server}" \
  --var "username=${laas_project_serviceaccount_admin}" \
  --var "token=${token}" \
  > "${repo_root_dir}/secret-store/laas-project-kubeconfig-admin.yaml"


echo "Set sam kubeconfig for resourcecluster project"
export KUBECONFIG="${resourcecluster_project_kubeconfig_sam}"


echo "Assume that an admin service account for the resourcecluster project already exists"
echo "Call token request api to obtain a 90d kubeconfig for admin serviceaccount of resourcecluster project"
# --duration=7776000s are 90 days

token=$(kubectl create token -n ${resourcecluster_project} ${resourcecluster_project_serviceaccount_admin} --duration=7776000s)

# Alternative:
# kubectl create \
#   --raw "/api/v1/namespaces/${laas_project}/serviceaccounts/${laas_project_admin_service_account}/token" \
#   -f <(echo '{"spec":{"expirationSeconds": 7776000}}') \
#   | jq -r .status.token


echo "Reading server from sam kubeconfig"
server=$(yq '.clusters.0.cluster.server' < "${resourcecluster_project_kubeconfig_sam}")


echo "Write kubeconfig of admin serviceaccount for the laas project to the secret store"
mako-render "${repo_root_dir}/resources/kubeconfig.yaml.tpl" \
  --var "cluster=${resourcecluster_project}" \
  --var "namespace=${resourcecluster_project}" \
  --var "server=${server}" \
  --var "username=${resourcecluster_project_serviceaccount_admin}" \
  --var "token=${token}" \
  > "${repo_root_dir}/secret-store/resourcecluster-project-kubeconfig-admin.yaml"
