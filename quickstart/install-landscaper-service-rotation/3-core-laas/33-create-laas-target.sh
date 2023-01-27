#!/bin/bash

repo_root_dir="$(dirname $0)/.."
source ${repo_root_dir}/settings


echo "Pipeline, acting as 1d admin for the core cluster"
export KUBECONFIG="${repo_root_dir}/secret-store/core-kubeconfig-admin.yaml"


echo "Create serviceaccount laas-installer"
mako-render "${repo_root_dir}/resources/serviceaccount.yaml.tpl" \
  --var "namespace=${laas_namespace}" \
  --var "name=${laas_installer_serviceaccount}" \
  | kubectl apply -f -


echo "Create token for core cluster, service account: laas-installer"
token=$(kubectl create token -n ${laas_namespace} ${laas_installer_serviceaccount} --duration=7776000s)


echo "Reading server and ca data from admin kubeconfig"
current_context=$(yq ".current-context" < "${KUBECONFIG}")
cluster_name=$(yq ".contexts[] | select(.name == \"${current_context}\").context.cluster" < "${KUBECONFIG}")
cluster=$(yq ".clusters[] | select(.name == \"${cluster_name}\").cluster" < "${KUBECONFIG}")
server=$(echo "${cluster}" | yq .server)
ca_data=$(echo "${cluster}" | yq .certificate-authority-data)


echo "Write kubeconfig for core cluster, service account: laas-installer"
laas_installer_kubeconfig_path="${repo_root_dir}/secret-store/core-kubeconfig-laas-installer.yaml"
mako-render "${repo_root_dir}/resources/kubeconfig.yaml.tpl" \
  --var "cluster=${laas_project}--${core_shoot}" \
  --var "server=${server}" \
  --var "ca_data=${ca_data}" \
  --var "username=${laas_installer_serviceaccount}" \
  --var "token=${token}" \
  > "${laas_installer_kubeconfig_path}"


echo "Creating laas target"
landscaper-cli targets create kubernetes-cluster \
  --name laas-target-cluster \
  --namespace laas-system \
  --target-kubeconfig "${laas_installer_kubeconfig_path}" \
  | kubectl apply -f -
