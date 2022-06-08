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
echo "LANDSCAPER_DEPLOYMENT_NAMESPACE: ${LANDSCAPER_DEPLOYMENT_NAMESPACE}"
echo "LANDSCAPER_DEPLOYMENT_NAME:      ${LANDSCAPER_DEPLOYMENT_NAME}"
echo "LANDSCAPER_DEPLOYMENT_TENANT:    ${LANDSCAPER_DEPLOYMENT_TENANT}"


echo -e "\n--- creating namespace for landscaper deployment"
LANDSCAPER_DEPLOYMENT_NAMESPACE_PATH="${COMPONENT_DIR}/landscaper-deployment-namespace.yaml"
mako-render ${COMPONENT_DIR}/resources/namespace.yaml.tpl \
  --var namespace="${LANDSCAPER_DEPLOYMENT_NAMESPACE}" \
  --output-file="${LANDSCAPER_DEPLOYMENT_NAMESPACE_PATH}"
kubectl apply -f "${LANDSCAPER_DEPLOYMENT_NAMESPACE_PATH}"


echo -e "\n--- creating landscaper deployment"
DEPLOYMENT_PATH="${COMPONENT_DIR}/landscaper-deployment.yaml"
mako-render ${COMPONENT_DIR}/resources/landscaper-deployment.yaml.tpl \
  --var namespace="${LANDSCAPER_DEPLOYMENT_NAMESPACE}" \
  --var name="${LANDSCAPER_DEPLOYMENT_NAME}" \
  --var tenant="${LANDSCAPER_DEPLOYMENT_TENANT}" \
  --output-file="${DEPLOYMENT_PATH}"
kubectl apply -f "${DEPLOYMENT_PATH}"
