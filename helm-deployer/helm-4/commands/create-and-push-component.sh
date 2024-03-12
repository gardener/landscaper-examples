#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

COMPONENT_DIR="$(dirname $0)/.."

CA_PATH=${COMPONENT_DIR}
CTF_PATH=${COMPONENT_DIR}/commands/transport.tar

landscaper-cli component-cli component-archive "${CA_PATH}" "${CTF_PATH}" \
  -r ${COMPONENT_DIR}/resources.yaml

component-cli ctf push "${CTF_PATH}"
