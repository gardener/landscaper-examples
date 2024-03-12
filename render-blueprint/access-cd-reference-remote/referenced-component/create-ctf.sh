#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

REFERENCED_COMPONENT_DIR="$(dirname $0)"

CA_PATH=${REFERENCED_COMPONENT_DIR}
CTF_PATH=${REFERENCED_COMPONENT_DIR}/transport.tar

component-cli component-archive "${CA_PATH}" "${CTF_PATH}"
