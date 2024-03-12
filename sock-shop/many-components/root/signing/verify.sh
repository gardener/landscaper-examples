#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

COMPONENT_DIR="$(dirname $0)/.."

BASE_URL="eu.gcr.io/gardener-project/landscaper/examples"
BASE_URL_SIGNED="${BASE_URL}/signed"
COMPONENT_NAME="github.com/gardener/landscaper-examples/sock-shop/many-components/root"
VERSION="v0.1.0"
SIGNATURE_NAME="example-signature"

# Set path to your public key pem file for signing
PUBLIC_KEY=<path to your public key pem file>

component-cli ca signature verify rsa ${BASE_URL_SIGNED} ${COMPONENT_NAME} ${VERSION} \
  --signature-name ${SIGNATURE_NAME} \
  --public-key ${PUBLIC_KEY}
