#!/bin/bash

repo_root_dir="$(dirname $0)/.."
source ${repo_root_dir}/settings


echo "Pipeline, acting as 1d admin for the target cluster"
export KUBECONFIG="${repo_root_dir}/secret-store/target-kubeconfig-admin.yaml"


echo "Creating namespace ${laas_namespace}"
mako-render "${repo_root_dir}/resources/namespace.yaml.tpl" \
  --var "namespace=${laas_namespace}" \
  | kubectl apply -f -


echo "Create serviceaccount ls-installer"
mako-render "${repo_root_dir}/4-servicetargetconfig/serviceaccount.yaml.tpl" \
  --var "namespace=${laas_namespace}" \
  --var "name=${ls_installer_serviceaccount}" \
  | kubectl apply -f -


echo "Create token for target cluster, service account: ls-installer"
token=$(kubectl create token -n ${laas_namespace} ${ls_installer_serviceaccount} --duration=7776000s)


echo "Reading server and ca data from admin kubeconfig"
current_context=$(yq ".current-context" < "${KUBECONFIG}")
cluster_name=$(yq ".contexts[] | select(.name == \"${current_context}\").context.cluster" < "${KUBECONFIG}")
cluster=$(yq ".clusters[] | select(.name == \"${cluster_name}\").cluster" < "${KUBECONFIG}")
server=$(echo "${cluster}" | yq .server)
ca_data=$(echo "${cluster}" | yq .certificate-authority-data)


echo "Write kubeconfig for target cluster, service account: ls-installer"
ls_installer_kubeconfig_path="${repo_root_dir}/secret-store/target-kubeconfig-ls-installer.yaml"
mako-render "${repo_root_dir}/resources/kubeconfig.yaml.tpl" \
  --var "cluster=${laas_project}--${target_shoot}" \
  --var "server=${server}" \
  --var "ca_data=${ca_data}" \
  --var "username=${ls_installer_serviceaccount}" \
  --var "token=${token}" \
  > "${ls_installer_kubeconfig_path}"
