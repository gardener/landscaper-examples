#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

set -o errexit
set -x

hack_dir="$(dirname $0)/."
cd "${hack_dir}"
hack_dir="$(pwd)"
echo "hack directory: ${hack_dir}"

source "${hack_dir}/settings"

if [[ -z "${REPO_BASE_URL}" ]]; then
  echo "environment variable REPO_BASE_URL must be set"
  exit 1
fi
echo "repo base url: ${REPO_BASE_URL}"

component_constructor=$1
if [[ -z "${component_constructor}" ]]; then
  echo "path to component-constructor.yaml must be provided as argument"
  exit 1
fi
echo "component constructor: ${component_constructor}"

ctf_dir=$(mktemp -d)
echo "temporary directory: ${component_constructor}"

echo "add components"
ocm add components --create --file "${ctf_dir}" "${component_constructor}"

ocm transfer ctf --overwrite "${ctf_dir}" "${REPO_BASE_URL}"
