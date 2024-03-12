#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

COMPONENT_DIR="$(dirname $0)/.."

BLUEPRINT_DIR=${COMPONENT_DIR}/blueprint
TEST_DIR=${COMPONENT_DIR}/test

landscaper-cli blueprints render ${BLUEPRINT_DIR} deployitems \
  -f ${TEST_DIR}/values.yaml \
  -c ${COMPONENT_DIR}/component-descriptor.yaml \
  -r ${COMPONENT_DIR}/resources.yaml \
  -w ${TEST_DIR}/result
