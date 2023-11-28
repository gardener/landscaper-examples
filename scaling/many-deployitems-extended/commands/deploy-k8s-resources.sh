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

set -o errexit


COMPONENT_DIR="$(dirname $0)/.."
cd "${COMPONENT_DIR}"
COMPONENT_DIR="$(pwd)"
echo compdir ${COMPONENT_DIR}

source ${COMPONENT_DIR}/commands/settings
echo -e "\n--- settings"
echo "TARGET_CLUSTER_KUBECONFIG_PATH:   ${TARGET_CLUSTER_KUBECONFIG_PATH}"
echo "NAMESPACE:                        ${NAMESPACE}"

TMP_DIR=`mktemp -d`
echo tempdir ${TMP_DIR}

mako-render "${COMPONENT_DIR}/installation/context.yaml.tlp" \
  --var namespace="${NAMESPACE}" \
  --output-file="${TMP_DIR}/context.yaml"

mako-render "${COMPONENT_DIR}/installation/dataobject-values.yaml.tlp" \
  --var namespace="${NAMESPACE}" \
  --var sleep="${SLEEP}" \
  --var helmDeployment="${HELM_DEPLOYMENT}" \
  --var text="${TEXT}" \
  --output-file="${TMP_DIR}/dataobject-values.yaml"

mako-render "${COMPONENT_DIR}/installation/target.yaml.tlp" \
  --var namespace="${NAMESPACE}" \
  --var kubeconfig_path="${TARGET_CLUSTER_KUBECONFIG_PATH}" \
  --output-file="${TMP_DIR}/target.yaml"

for (( i=1; i<=${NUM_TOP_LEVEL_INSTS}; i++ ))
do
   echo "This is loop number $i"

   echo "render releases"

   mako-render "${COMPONENT_DIR}/installation/dataobject-releases.yaml.tlp" \
     --var namespace="${NAMESPACE}" \
     --var num="${i}" \
     --var numsubinsts="${NUM_SUB_INSTS}" \
     --output-file="${TMP_DIR}/dataobject-releases-${i}.yaml"

   echo "render installation"

   mako-render "${COMPONENT_DIR}/installation/installation.yaml.tlp" \
     --var namespace="${NAMESPACE}" \
     --var num="${i}" \
     --output-file="${TMP_DIR}/installation-${i}.yaml"
done

kubectl apply -f "${TMP_DIR}"

