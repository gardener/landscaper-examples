#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

EXAMPLE_DIR="$(dirname $0)/.."
MAIN_COMPONENT_DIR=${EXAMPLE_DIR}/main-component
BLUEPRINT_DIR=${MAIN_COMPONENT_DIR}/blueprint
TEST_DIR=${EXAMPLE_DIR}/test

landscaper-cli blueprints render $BLUEPRINT_DIR deployitems \
  -f ${TEST_DIR}/values.yaml \
  -c ${MAIN_COMPONENT_DIR}/component-descriptor.yaml \
  -w ${TEST_DIR}/result