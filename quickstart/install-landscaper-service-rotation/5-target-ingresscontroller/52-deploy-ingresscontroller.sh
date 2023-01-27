#!/bin/bash

repo_root_dir="$(dirname $0)/.."
source ${repo_root_dir}/settings


echo "Pipeline, acting as 1d admin for the target cluster"
export KUBECONFIG="${repo_root_dir}/secret-store/core-kubeconfig-admin.yaml"


echo "Creating namespace ${ingress_controller_namespace}"
mako-render "${repo_root_dir}/resources/namespace.yaml.tpl" \
  --var "namespace=${ingress_controller_namespace}" \
  | kubectl apply -f -


echo "Creating ingress controller target"
target_name="ingress-controller-target-cluster"
landscaper-cli targets create kubernetes-cluster \
  --name "${target_name}" \
  --namespace ${ingress_controller_namespace} \
  --target-kubeconfig "${repo_root_dir}/secret-store/target-kubeconfig-ingress-controller-installer.yaml" \
  | kubectl apply -f -


echo "Creating ingress controller pull secret"
pullsecret="repository-auth"
kubectl create secret docker-registry "${pullsecret}" \
  -n ${ingress_controller_namespace} \
  --docker-server=eu.gcr.io \
  --docker-username=_json_key \
  --docker-password="$(cat ${registry_json_key_path})" \
  --docker-email=any@valid.email


echo "Creating ingress controller context"
context_name="ingress-controller"
mako-render ${repo_root_dir}/resources/context.yaml.tpl \
  --var "namespace=${ingress_controller_namespace}" \
  --var "name=${context_name}" \
  --var "base_url=${registry_base_url}" \
  --var "pullsecret=${pullsecret}" \
  | kubectl apply -f -


echo "Creating ingress controller installation"
mako-render ${repo_root_dir}/5-target-ingresscontroller/installation.yaml.tpl \
  --var "namespace=${ingress_controller_namespace}" \
  --var "name=ingress-controller-target-01" \
  --var "context_name=${context_name}" \
  --var "target_name=${target_name}" \
  | kubectl apply -f -
