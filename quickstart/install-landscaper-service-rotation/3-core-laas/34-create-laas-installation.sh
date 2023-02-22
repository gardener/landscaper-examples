#!/bin/bash

repo_root_dir="$(dirname $0)/.."
source ${repo_root_dir}/settings


echo "Pipeline, acting as 1d admin for the core shoot cluster"
export KUBECONFIG="${repo_root_dir}/secret-store/core-kubeconfig-admin.yaml"


echo "Creating laas pull secret"
pullsecret="laas-pullsecret"
kubectl create secret docker-registry "${pullsecret}" \
  -n laas-system \
  --docker-server=eu.gcr.io \
  --docker-username=_json_key \
  --docker-password="$(cat ${registry_json_key_path})" \
  --docker-email=any@valid.email


echo "Creating laas context"
mako-render ${repo_root_dir}/resources/context.yaml.tpl \
  --var "namespace=${laas_namespace}" \
  --var "name=landscaper-service" \
  --var "base_url=${registry_base_url}" \
  --var "pullsecret=${pullsecret}" \
  | kubectl apply -f -


# remove prefix "garden-"
project=${resourcecluster_project:7}

echo "Creating laas installation"
mako-render ${repo_root_dir}/3-core-laas/installation.yaml.tpl \
  --var "namespace=${laas_namespace}" \
  --var "name=landscaper-service" \
  --var "context_name=landscaper-service" \
  --var "pullsecret=${pullsecret}" \
  --var "project=${project}" \
  --var "version=${laas_version}" \
  --var "cp_secret=${resourcecluster_project_cp_secret}" \
  | kubectl apply -f -
