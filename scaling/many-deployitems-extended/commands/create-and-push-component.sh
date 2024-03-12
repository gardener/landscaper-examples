#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

# Prerequisite: you must login with the following command
# gcloud auth login

set -o errexit

COMPONENT_DIR="$(dirname $0)/.."
TRANSPORT_FILE=`mktemp -d`

${COMPONENT_DIR}/../../hack/create-and-push-component.sh "${COMPONENT_DIR}" "${TRANSPORT_FILE}"
