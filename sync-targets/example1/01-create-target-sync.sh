#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

COMPONENT_DIR="$(dirname $0)"

source ${COMPONENT_DIR}/settings
echo -e "\n--- settings"
echo "TARGET_SYNC_NAMESPACE:              ${TARGET_SYNC_NAMESPACE}"
echo "TARGET_SYNC_NAME:                   ${TARGET_SYNC_NAME}"
echo "TARGET_SYNC_SECRET_KUBECONFIG_PATH: ${TARGET_SYNC_SECRET_KUBECONFIG_PATH}"
echo "TARGET_SYNC_HOST_KUBECONFIG_PATH:   ${TARGET_SYNC_HOST_KUBECONFIG_PATH}"
echo "SOURCE_NAMESPACE:                   ${SOURCE_NAMESPACE}"


echo -e "\n--- creating temp dir"
TMP_DIR=`mktemp -d`
echo "TMP_DIR: ${TMP_DIR}"

echo -e "\n--- creating target sync secret"
SECRET_PATH="${TMP_DIR}/target-sync-secret.yaml"
mako-render ${COMPONENT_DIR}/resources/target-sync-secret.yaml.tpl \
  --var namespace="${TARGET_SYNC_NAMESPACE}" \
  --var name="${TARGET_SYNC_NAME}" \
  --var kubeconfig_path="${TARGET_SYNC_SECRET_KUBECONFIG_PATH}" \
  --output-file="${SECRET_PATH}"
kubectl apply -f "${SECRET_PATH}" --kubeconfig="${TARGET_SYNC_HOST_KUBECONFIG_PATH}"

echo -e "\n--- creating target sync object"
TARGET_SYNC_PATH="${TMP_DIR}/target-sync.yaml"
mako-render ${COMPONENT_DIR}/resources/target-sync.yaml.tpl \
  --var namespace="${TARGET_SYNC_NAMESPACE}" \
  --var name="${TARGET_SYNC_NAME}" \
  --var sourceNamespace="${SOURCE_NAMESPACE}" \
  --output-file="${TARGET_SYNC_PATH}"
kubectl apply -f "${TARGET_SYNC_PATH}" --kubeconfig="${TARGET_SYNC_HOST_KUBECONFIG_PATH}"