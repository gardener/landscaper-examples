#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

COMPONENT_DIR="$(dirname $0)/.."
cd "${COMPONENT_DIR}"
COMPONENT_DIR="$(pwd)"
echo compdir ${COMPONENT_DIR}

source ${COMPONENT_DIR}/commands/settings

TMP_DIR=`mktemp -d`
echo tempdir ${TMP_DIR}

mako-render "${COMPONENT_DIR}/installation/context.yaml.tlp" \
  --var namespace="${NAMESPACE}" \
  --output-file="${TMP_DIR}/context.yaml"

mako-render "${COMPONENT_DIR}/installation/dataobject-values.yaml.tlp" \
  --var namespace="${NAMESPACE}" \
  --var sleep="${SLEEP}" \
  --var helm="${HELM}" \
  --var helmDeployment="${HELM_DEPLOYMENT}" \
  --var text="${TEXT}" \
  --var numOfCm="${NUM_OF_CM}" \
  --var hasNoSiblingImports="${HAS_NO_SIBLING_IMPORTS}" \
  --var hasNoSiblingExports="${HAS_NO_SIBLING_EXPORTS}" \
  --var subInstPrefix="${SUB_INST_PREFIX}" \
  --output-file="${TMP_DIR}/dataobject-values.yaml"

# Counter
externalLoop=1
# Iterate over all files in the directory
for TARGET_CLUSTER_KUBECONFIG_PATH in "$TARGET_CLUSTER_KUBECONFIG_FOLDER"/*
do
  # Check if it is a file (not a directory)
  if [ -f "$TARGET_CLUSTER_KUBECONFIG_PATH" ]; then
    echo "External loop: $externalLoop"
    echo "Reading file $TARGET_CLUSTER_KUBECONFIG_PATH"

    mako-render "${COMPONENT_DIR}/installation/target.yaml.tlp" \
      --var namespace="${NAMESPACE}" \
      --var externalLoop="${externalLoop}" \
      --var kubeconfig_path="${TARGET_CLUSTER_KUBECONFIG_PATH}" \
      --output-file="${TMP_DIR}/target-${externalLoop}.yaml"

    sum=$((START_NUMBER + NUM_TOP_LEVEL_INSTS))
    for (( internalLoop=$START_NUMBER ; internalLoop<$sum; internalLoop++ ))
    do
       echo "Internal loop $internalLoop"

       echo "render releases"

       mako-render "${COMPONENT_DIR}/installation/dataobject-releases.yaml.tlp" \
         --var namespace="${NAMESPACE}" \
         --var externalLoop="${externalLoop}" \
         --var internalLoop="${internalLoop}" \
         --var numsubinsts="${NUM_SUB_INSTS}" \
         --output-file="${TMP_DIR}/dataobject-releases-${externalLoop}-${internalLoop}.yaml"

       echo "delete namespace"
       for (( j=0; j<${NUM_SUB_INSTS}; j++ ))
       do
         kubectl delete ns item-${externalLoop}-${internalLoop}-${j} --kubeconfig "${TARGET_CLUSTER_KUBECONFIG_PATH}" --wait=false
       done
    done

    externalLoop=$((externalLoop+1))
  fi
done

echo "delete k8s resources"
kubectl delete -f "${TMP_DIR}"

echo "delete namespaceregistration"
outputFile="${TMP_DIR}/namespace-registration.yaml"
mako-render "${COMPONENT_DIR}/installation/namespaceregistration.yaml.tlp" \
  --var namespace="${NAMESPACE}" \
  --output-file=${outputFile}
kubectl delete -f ${outputFile}

