#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

EXAMPLE_DIR="$(dirname $0)/.."

BLUEPRINT_DIR=${EXAMPLE_DIR}/blueprint
TEST_DIR=${EXAMPLE_DIR}/test

landscaper-cli blueprints render $BLUEPRINT_DIR all \
  -f ${TEST_DIR}/values.yaml \
  -w ${TEST_DIR}/result
