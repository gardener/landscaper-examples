#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

COMPONENT_DIR="$(dirname $0)/.."

${COMPONENT_DIR}/carts/ctf/create-ctf.sh
${COMPONENT_DIR}/catalogue/ctf/create-ctf.sh
${COMPONENT_DIR}/front-end/ctf/create-ctf.sh
${COMPONENT_DIR}/namespace/ctf/create-ctf.sh
${COMPONENT_DIR}/orders/ctf/create-ctf.sh
${COMPONENT_DIR}/payment/ctf/create-ctf.sh
${COMPONENT_DIR}/queue/ctf/create-ctf.sh
${COMPONENT_DIR}/root/ctf/create-ctf.sh
${COMPONENT_DIR}/shipping/ctf/create-ctf.sh
${COMPONENT_DIR}/user/ctf/create-ctf.sh
