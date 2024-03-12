#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

COMPONENT_DIR="$(dirname $0)"

# Path to the kubeconfig to be included in the target
TARGET_KUBECONFIG_PATH=<kubeconfig path>  # <<<<<<<<<< MAINTAIN PATH TO KUBECONFIG !
TARGET_NAME=my-cluster
TARGET_NAMESPACE=example

landscaper-cli targets create kubernetes-cluster \
  --name ${TARGET_NAME} \
  --namespace ${TARGET_NAMESPACE} \
  --target-kubeconfig ${TARGET_KUBECONFIG_PATH} > ${COMPONENT_DIR}/target.yaml
