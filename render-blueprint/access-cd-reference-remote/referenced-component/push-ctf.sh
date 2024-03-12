#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

REFERENCED_COMPONENT_DIR="$(dirname $0)"
CTF_PATH=${REFERENCED_COMPONENT_DIR}/transport.tar

component-cli ctf push "${CTF_PATH}"
