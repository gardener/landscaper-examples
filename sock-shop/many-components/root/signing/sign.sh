#!/bin/bash
#
# Copyright (c) 2022 SAP SE or an SAP affiliate company. All rights reserved. This file is licensed under the Apache Software License, v. 2 except as noted otherwise in the LICENSE file
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

COMPONENT_DIR="$(dirname $0)/.."

BASE_URL="eu.gcr.io/gardener-project/landscaper/examples"
COMPONENT_NAME="github.com/gardener/landscaper-examples/sock-shop/many-components/root"
VERSION="v0.1.0"

# Set path to your private key pem file for signing
PRIVATE_KEY=<path to your private key pem file>

component-cli ca signature sign rsa \
  ${BASE_URL} \
  ${COMPONENT_NAME} \
  ${VERSION} \
  --upload-base-url ${BASE_URL}/signed \
  --recursive \
  --signature-name example-signature \
  --private-key ${PRIVATE_KEY}
