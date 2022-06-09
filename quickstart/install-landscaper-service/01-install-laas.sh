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
echo "LAAS_NAMESPACE:                 ${LAAS_NAMESPACE}"
echo "LAAS_KUBECONFIG_PATH:           ${LAAS_KUBECONFIG_PATH}"
echo "LAAS_VERSION:                   ${LAAS_VERSION}"
echo "GCP_JSON_KEY_PATH:"             ${GCP_JSON_KEY_PATH}

echo -e "\n--- creating laas namespace ${LAAS_NAMESPACE}"
LAAS_NAMESPACE_PATH="${COMPONENT_DIR}/laas-namespace.yaml"
mako-render ${COMPONENT_DIR}/resources/namespace.yaml.tpl \
  --var namespace="${LAAS_NAMESPACE}" \
  --output-file="${LAAS_NAMESPACE_PATH}"
kubectl apply -f "${LAAS_NAMESPACE_PATH}"


echo -e "\n--- creating laas target"
LAAS_TARGET_PATH="${COMPONENT_DIR}/laas-target.yaml"
landscaper-cli targets create kubernetes-cluster \
  --name laas-target-cluster \
  --namespace "${LAAS_NAMESPACE}" \
  --target-kubeconfig "${LAAS_KUBECONFIG_PATH}" \
  > "${LAAS_TARGET_PATH}"
kubectl apply -f "${LAAS_TARGET_PATH}"


echo -e "\n--- creating laas pull secret"
kubectl create secret docker-registry landscaper-service-pullsecret \
  -n ${LAAS_NAMESPACE} \
  --docker-server=eu.gcr.io \
  --docker-username=_json_key \
  --docker-password="$(cat ${GCP_JSON_KEY_PATH})" \
  --docker-email=any@valid.email


echo -e "\n--- creating laas context"
LAAS_CONTEXT_PATH="${COMPONENT_DIR}/laas-context.yaml"
mako-render ${COMPONENT_DIR}/resources/laas-context.yaml.tpl \
  --var namespace="${LAAS_NAMESPACE}" \
  --output-file="${LAAS_CONTEXT_PATH}"
kubectl apply -f "${LAAS_CONTEXT_PATH}"


echo -e "\n--- creating laas installation"
LAAS_INSTALLATION_PATH="${COMPONENT_DIR}/laas-installation.yaml"
mako-render ${COMPONENT_DIR}/resources/laas-installation.yaml.tpl \
  --var namespace="${LAAS_NAMESPACE}" \
  --var version="${LAAS_VERSION}" \
  --output-file="${LAAS_INSTALLATION_PATH}"
kubectl apply -f "${LAAS_INSTALLATION_PATH}"
