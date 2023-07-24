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

dir="$(dirname $0)"

if [[ -z "${LS_KUBECONFIG}" ]]; then
  echo "Variable LS_KUBECONFIG must contain the path to the kubeconfig of the landscaper cluster"
  exit 1
fi

if [[ -z "${LS_VERSION}" ]]; then
  echo "Variable LS_VERSION must contain the landscaper version, e.g. v0.20.0 or v0.21.0-dev-13142baeae12aabbb79f34afc3174a982b1832bb"
  exit 1
fi

if [[ -z "${LS_NAMESPACE}" ]]; then
  LS_NAMESPACE="ls-system"
fi

if [[ -z "${LS_HELM_VALUES_PATH}" ]]; then
  LS_HELM_VALUES_PATH="${dir}/values.yaml"
fi

echo "LS_KUBECONFIG:      " "${LS_KUBECONFIG}"
echo "LS_VERSION:         " "${LS_VERSION}"
echo "LS_NAMESPACE:       " "${LS_NAMESPACE}"
echo "LS_HELM_VALUES_PATH:" "${LS_HELM_VALUES_PATH}"

echo "Installing landscaper"

landscaper-cli quickstart install \
  --kubeconfig="${LS_KUBECONFIG}" \
  --landscaper-chart-version="${LS_VERSION}" \
  --namespace="${LS_NAMESPACE}" \
  --landscaper-values="${LS_HELM_VALUES_PATH}"
