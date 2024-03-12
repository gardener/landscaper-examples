#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

COMPONENT_DIR="$(dirname $0)/.."

BASE_URL="eu.gcr.io/gardener-project/landscaper/examples"
COMPONENT_NAME_PREFIX="github.com/gardener/landscaper-examples/sock-shop/many-components"
VERSION="v0.1.0"
NAMES=("carts" "catalogue" "front-end" "namespace" "orders" "payment" "queue" "root" "shipping" "user")

for name in ${NAMES[@]}; do
  componentName="${COMPONENT_NAME_PREFIX}/${name}"
  cdPath="${COMPONENT_DIR}/signing/cd-${name}.yaml"
  echo "Downloading component descriptor ${componentName}"
  component-cli ca remote get ${BASE_URL}/signed ${componentName} ${VERSION} > ${cdPath}
done
