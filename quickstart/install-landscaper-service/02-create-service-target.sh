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
echo "SERVICE_TARGET_NAME:            ${SERVICE_TARGET_NAME}"
echo "SERVICE_TARGET_KUBECONFIG_PATH: ${SERVICE_TARGET_KUBECONFIG_PATH}"


echo -e "\n--- creating service target secret"
SECRET_PATH="${COMPONENT_DIR}/service-target-secret.yaml"
mako-render ${COMPONENT_DIR}/resources/service-target-secret.yaml.tpl \
  --var namespace="${LAAS_NAMESPACE}" \
  --var name="${SERVICE_TARGET_NAME}" \
  --var kubeconfig_path="${SERVICE_TARGET_KUBECONFIG_PATH}" \
  --output-file="${SECRET_PATH}"
kubectl apply -f "${SECRET_PATH}"


echo -e "\n--- creating service target config"
CONFIG_PATH="${COMPONENT_DIR}/service-target-config.yaml"
mako-render ${COMPONENT_DIR}/resources/service-target-config.yaml.tpl \
  --var namespace="${LAAS_NAMESPACE}" \
  --var name="${SERVICE_TARGET_NAME}" \
  --output-file="${CONFIG_PATH}"
kubectl apply -f "${CONFIG_PATH}"
