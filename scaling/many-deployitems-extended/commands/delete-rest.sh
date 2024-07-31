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

outputFile="${TMP_DIR}/context.yaml"
export namespace="${NAMESPACE}"
inputFile="${COMPONENT_DIR}/installation/context.yaml.tlp"
envsubst < ${inputFile} > ${outputFile}

outputFile="${TMP_DIR}/dataobject-values.yaml"
export namespace="${NAMESPACE}"
export sleep="${SLEEP}"
export helm="${HELM}"
export helmDeployment="${HELM_DEPLOYMENT}"
export text="${TEXT}"
export numOfCm="${NUM_OF_CM}"
export hasNoSiblingImports="${HAS_NO_SIBLING_IMPORTS}"
export hasNoSiblingExports="${HAS_NO_SIBLING_EXPORTS}"
export subInstPrefix="${SUB_INST_PREFIX}"
inputFile="${COMPONENT_DIR}/installation/dataobject-values.yaml.tlp"
envsubst < ${inputFile} > ${outputFile}

# Counter
externalLoop=1
# Iterate over all files in the directory
for TARGET_CLUSTER_KUBECONFIG_PATH in "$TARGET_CLUSTER_KUBECONFIG_FOLDER"/*
do
  # Check if it is a file (not a directory)
  if [ -f "$TARGET_CLUSTER_KUBECONFIG_PATH" ]; then
    echo "External loop: $externalLoop"
    echo "Reading file $TARGET_CLUSTER_KUBECONFIG_PATH"

    outputFile="${TMP_DIR}/target-${externalLoop}.yaml"
        export namespace="${NAMESPACE}"
        export externalLoop="${externalLoop}"
        export kubeconfig=`sed 's/^/      /' $TARGET_CLUSTER_KUBECONFIG_PATH`
        inputFile="${COMPONENT_DIR}/installation/target.yaml.tlp"
        envsubst < ${inputFile} > ${outputFile}

    sum=$((START_NUMBER + NUM_TOP_LEVEL_INSTS))
    for (( internalLoop=$START_NUMBER ; internalLoop<$sum; internalLoop++ ))
    do
       echo "Internal loop $internalLoop"

       echo "render releases"

       outputFile="${TMP_DIR}/dataobject-releases-${externalLoop}-${internalLoop}.yaml"
       export namespace="${NAMESPACE}"
       export externalLoop="${externalLoop}"
       export internalLoop="${internalLoop}"
       export numsubinsts="${NUM_SUB_INSTS}"
       inputFile="${COMPONENT_DIR}/installation/dataobject-releases.yaml.tlp"
       envsubst < ${inputFile} > ${outputFile}
       for (( i=0; i<$numsubinsts; i++ ))
       do
         echo "  - name: item-${externalLoop}-${internalLoop}-${i}" >> ${outputFile}
         echo "    namespace: scaling-${externalLoop}-${internalLoop}-${i}" >> ${outputFile}
       done

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
export namespace="${NAMESPACE}"
inputFile="${COMPONENT_DIR}/installation/namespaceregistration.yaml.tlp"
envsubst < ${inputFile} > ${outputFile}
kubectl delete -f ${outputFile}

