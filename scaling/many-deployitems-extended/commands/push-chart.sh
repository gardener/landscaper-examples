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


# Prerequisite: you must login with the following command
# gcloud auth login

COMPONENT_DIR="$(dirname $0)/.."

TMP_DIR=`mktemp -d`

helm package "${COMPONENT_DIR}/chart/many-deployitems" -d "${TMP_DIR}"

gcloud auth print-access-token | helm registry login -u oauth2accesstoken --password-stdin https://eu.gcr.io

helm push "${TMP_DIR}/many-deployitems-extended-1.0.0.tgz" oci://eu.gcr.io/gardener-project/landscaper/examples/charts/scaling