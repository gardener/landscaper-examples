#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

# set -o errexit

COMPONENT_DIR="$(dirname $0)/.."
cd "${COMPONENT_DIR}"
COMPONENT_DIR="$(pwd)"
echo compdir ${COMPONENT_DIR}

source ${COMPONENT_DIR}/commands/settings

TMP_DIR=`mktemp -d`
echo tempdir ${TMP_DIR}

start=$SECONDS

# Counter
externalLoop=1
# Iterate over all files in the directory
for TARGET_CLUSTER_KUBECONFIG_PATH in "$TARGET_CLUSTER_KUBECONFIG_FOLDER"/*
do
  # Check if it is a file (not a directory)
  if [ -f "$TARGET_CLUSTER_KUBECONFIG_PATH" ]; then
    echo "External loop: $externalLoop"
    echo "Reading file $TARGET_CLUSTER_KUBECONFIG_PATH"

    sum=$((START_NUMBER + NUM_TOP_LEVEL_INSTS))
    for (( internalLoop=$START_NUMBER ; internalLoop<$sum; internalLoop++ ))
    do
       echo "Internal loop $internalLoop"

       echo "render installation"

       mako-render "${COMPONENT_DIR}/installation/installation.yaml.tlp" \
         --var namespace="${NAMESPACE}" \
         --var externalLoop="${externalLoop}" \
         --var internalLoop="${internalLoop}" \
         --var hasNoSiblingImports="${HAS_NO_SIBLING_IMPORTS}" \
         --var hasNoSiblingExports="${HAS_NO_SIBLING_EXPORTS}" \
         --output-file="${TMP_DIR}/installation-${externalLoop}-${internalLoop}.yaml"
    done

    externalLoop=$((externalLoop+1))
  fi
done

echo "delete k8s installations"
kubectl delete -f "${TMP_DIR}" --wait=false

set +o errexit

while true
do
    resultInst=$(kubectl get inst -n ${NAMESPACE} | grep item)
    resultExec=$(kubectl get exec -n ${NAMESPACE} | grep item)
    resultDi=$(kubectl get di -n ${NAMESPACE} | grep item)

    resultRootInst=$(echo "$resultInst"  | grep scaling-many-deployitems)
    resultRootInstSucceeded=$(echo "$resultRootInst"  | grep Succeeded)
    resultRootInstFailed=$(echo "$resultRootInst"  | grep Failed)

    echo; echo;

    echo "Print Numbers"
    numRootInst=$(echo "$resultRootInst" | wc -l)
    numRootInstSucc=$(echo "$resultRootInstSucceeded" | wc -l)
    numRootInstFailed=$(echo "$resultRootInstFailed" | wc -l)
    echo "all root inst:           $numRootInst";
    echo "succeeded root inst:     $numRootInstSucc"; echo;

    numAllInst=$(echo "$resultInst" | wc -l)
    numAllExec=$(echo "$resultExec" | wc -l)
    numAllDi=$(echo "$resultDi" | wc -l)
    echo "all installations:       $numAllInst";
    echo "all executions:          $numAllExec";
    echo "all deployitems:         $numAllDi"; echo;

    numAllInstSucc=$(echo "$resultInst" | grep Succeeded | wc -l)
    numAllExecSucc=$(echo "$resultExec" | grep Succeeded | wc -l)
    numAllDiSucc=$(echo "$resultDi" | grep Succeeded | wc -l)
    numAllInstFailed=$(echo "$resultInst" | grep Failed | wc -l)
    numAllExecFailed=$(echo "$resultExec" | grep Failed | wc -l)
    numAllDiFailed=$(echo "$resultDi" | grep Failed | wc -l)
    echo "succeeded installations: $numAllInstSucc";
    echo "succeeded executions:    $numAllExecSucc";
    echo "succeeded deployitems:   $numAllDiSucc";
    echo "failed installations:    $numAllInstFailed";
    echo "failed executions:       $numAllExecFailed";
    echo "failed deployitems:      $numAllDiFailed"; echo; echo

    end=$SECONDS
    duration=$(( end - start ))
    echo "The script ran for $duration seconds."

    if [ "$numRootInst" -eq 1 ]; then
     echo "All Inst finished"
     exit
    fi

    if [ "$numRootInst" -eq 0 ]; then
      echo "All Inst finished"
      exit
    fi

    sleep 5
done
