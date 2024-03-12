#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

if [[ -z "${LS_KUBECONFIG}" ]]; then
  echo "Variable LS_KUBECONFIG must contain the path to the kubeconfig of the landscaper cluster"
  exit 1
fi

if [[ -z "${LS_NAMESPACE}" ]]; then
  LS_NAMESPACE="ls-system"
fi

echo "LS_KUBECONFIG:      " "${LS_KUBECONFIG}"
echo "LS_NAMESPACE:       " "${LS_NAMESPACE}"

echo "Uninstalling landscaper"

landscaper-cli quickstart uninstall \
  --namespace=${LS_NAMESPACE} \
  --kubeconfig=${LS_KUBECONFIG}
