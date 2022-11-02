#!/bin/bash
#
# Copyright (c) 2022 SAP SE or an SAP affiliate company. All rights reserved. This file is licensed under the Apache Software License, v. 2 except as noted otherwise in the LICENSE file
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

COMPONENT_DIR="$(dirname $0)"

source ${COMPONENT_DIR}/settings
echo -e "\n--- settings"
echo "TARGET_SYNC_NAMESPACE:              ${TARGET_SYNC_NAMESPACE}"
echo "TARGET_SYNC_NAME:                   ${TARGET_SYNC_NAME}"
echo "TARGET_SYNC_SECRET_KUBECONFIG_PATH: ${TARGET_SYNC_SECRET_KUBECONFIG_PATH}"
echo "TARGET_SYNC_SERVICE_ACCOUNT_NAME:   ${TARGET_SYNC_SERVICE_ACCOUNT_NAME}"
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
  --var serviceAccountName="${TARGET_SYNC_SERVICE_ACCOUNT_NAME}" \
  --output-file="${TARGET_SYNC_PATH}"
kubectl apply -f "${TARGET_SYNC_PATH}" --kubeconfig="${TARGET_SYNC_HOST_KUBECONFIG_PATH}"