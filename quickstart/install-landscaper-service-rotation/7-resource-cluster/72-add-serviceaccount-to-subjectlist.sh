#!/bin/bash

repo_root_dir="$(dirname $0)/.."
source ${repo_root_dir}/settings


echo "Acting as resourcecluster admin"
export KUBECONFIG="${repo_root_dir}/secret-store/resourcecluster-kubeconfig-admin.yaml"


echo "Creating service account"
kubectl create serviceaccount ${customer_serviceaccount} -n ls-user


echo "Adding serviceaccount to subjectlist"
mako-render ${repo_root_dir}/resources/subjectlist.yaml.tpl \
  --var "customer_serviceaccount=${customer_serviceaccount}" \
  | kubectl apply -f -

#kubectl patch subjectlist subjects -n ls-user --type=json \
#  -p='[{"op":"add", "path":"/spec/subjects", "value":[{"kind":"ServiceAccount", "name":"cu-account", "namespace":"cu-example"}]}]'


echo "Create token for resource cluster, service account: ${customer_serviceaccount}"
token=$(kubectl create token -n ls-user ${customer_serviceaccount} --duration=7776000s)


echo "Reading server and ca data from admin kubeconfig"
current_context=$(yq ".current-context" < "${KUBECONFIG}")
cluster_name=$(yq ".contexts[] | select(.name == \"${current_context}\").context.cluster" < "${KUBECONFIG}")
cluster=$(yq ".clusters[] | select(.name == \"${cluster_name}\").cluster" < "${KUBECONFIG}")
server=$(echo "${cluster}" | yq .server)
ca_data=$(echo "${cluster}" | yq .certificate-authority-data)


echo "Write kubeconfig for resource cluster, service account: ${customer_serviceaccount}"
resourcecluster_kubeconfig_path="${repo_root_dir}/secret-store/resourcecluster-kubeconfig-token.yaml"
mako-render "${repo_root_dir}/resources/kubeconfig.yaml.tpl" \
  --var "cluster=${resourcecluster_project}--${resourcecluster_shoot}" \
  --var "server=${server}" \
  --var "ca_data=${ca_data}" \
  --var "username=${customer_serviceaccount}" \
  --var "token=${token}" \
  > "${resourcecluster_kubeconfig_path}"
