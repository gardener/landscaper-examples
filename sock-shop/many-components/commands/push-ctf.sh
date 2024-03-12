#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

COMPONENT_DIR="$(dirname $0)/.."

component-cli ctf push "${COMPONENT_DIR}/carts/ctf/transport.tar"
component-cli ctf push "${COMPONENT_DIR}/catalogue/ctf/transport.tar"
component-cli ctf push "${COMPONENT_DIR}/front-end/ctf/transport.tar"
component-cli ctf push "${COMPONENT_DIR}/namespace/ctf/transport.tar"
component-cli ctf push "${COMPONENT_DIR}/orders/ctf/transport.tar"
component-cli ctf push "${COMPONENT_DIR}/payment/ctf/transport.tar"
component-cli ctf push "${COMPONENT_DIR}/queue/ctf/transport.tar"
component-cli ctf push "${COMPONENT_DIR}/shipping/ctf/transport.tar"
component-cli ctf push "${COMPONENT_DIR}/user/ctf/transport.tar"
component-cli ctf push "${COMPONENT_DIR}/root/ctf/transport.tar"
