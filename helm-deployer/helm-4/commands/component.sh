#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

commands_dir="$(dirname $0)/."
cd "${commands_dir}"
commands_dir="$(pwd)"

../../../hack/component.sh "${commands_dir}/component-constructor.yaml"
