#!/bin/bash

repo_root_dir="$(dirname $0)/.."
source ${repo_root_dir}/settings


echo "Pipeline, acting as 1d admin for the core shoot cluster"
export KUBECONFIG="${repo_root_dir}/secret-store/core-kubeconfig-admin.yaml"

echo "Deploy landscaper helm chart"
helm upgrade --install \
  landscaper "${landscaper_helm_chart_dir}" \
  --namespace "${landscaper_namespace}" \
  --create-namespace \
  -f "${repo_root_dir}/2-core-landscaper/core-landscaper-values.yaml" \
  --set "landscaper.image.tag=${landscaper_image_version}"
