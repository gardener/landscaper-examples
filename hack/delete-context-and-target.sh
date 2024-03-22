#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

set -o errexit

hack_dir="$(dirname $0)/."
cd "${hack_dir}"
hack_dir="$(pwd)"
echo "hack directory: ${hack_dir}"

source "${hack_dir}/settings"

echo "deleting context"
kubectl delete context "landscaper-examples" -n "${NAMESPACE}"

echo "deleting target"
kubectl delete target "my-cluster" -n "${NAMESPACE}"
