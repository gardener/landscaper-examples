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

export LS_NAMESPACE=ls-system

# Set path to kubeconfig of the landscaper host cluster (where the landscaper pods shall run)
export LS_KUBECONFIG=<kubeconfig path>

# Set landscaper version, for example: v0.38.0 or v0.39.0-dev-dd245ea9633dd717563536ad586061a97cfc725e
export LS_VERSION=<landscaper version>

export LS_HELM_VALUES_PATH=${COMPONENT_DIR}/values-host.yaml

# Set path to helm chart directory of the landscaper host .../github.com/gardener/landscaper/charts/landscaper/charts/landscaper
export LS_HELM_CHART_DIR=<path to helm chart directory of the landscaper host>

helm upgrade --install \
  landscaper "${LS_HELM_CHART_DIR}" \
  --namespace "${LS_NAMESPACE}" \
  --create-namespace \
  --kubeconfig "${LS_KUBECONFIG}" \
  -f "${LS_HELM_VALUES_PATH}"
