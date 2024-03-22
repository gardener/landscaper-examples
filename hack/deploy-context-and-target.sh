#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

set -o errexit

hack_dir="$(dirname $0)/."
cd "${hack_dir}"
hack_dir="$(pwd)"
echo "hack directory: ${hack_dir}"

source "${hack_dir}/settings"

temp_dir=$(mktemp -d)
echo "temporary directory: ${temp_dir}"

echo "creating context"
outputFile="${temp_dir}/context.yaml"
mako-render "${hack_dir}/resources/context.yaml.tpl" \
  --var namespace="${NAMESPACE}" \
  --var repoBaseUrl="${REPO_BASE_URL}" \
  --output-file=${outputFile}
kubectl apply -f ${outputFile}

echo "creating target"
echo "target cluster kubeconfig: $TARGET_CLUSTER_KUBECONFIG_PATH"
outputFile="${temp_dir}/target.yaml"
mako-render "${hack_dir}/resources/target.yaml.tpl" \
  --var namespace="${NAMESPACE}" \
  --var kubeconfig_path="${TARGET_CLUSTER_KUBECONFIG_PATH}" \
  --output-file=${outputFile}
kubectl apply -f ${outputFile}
