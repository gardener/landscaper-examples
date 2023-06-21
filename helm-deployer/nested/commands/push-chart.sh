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

# Get an identity token for the artifactory from your artifactory user profile: https://common.repositories.cloud.sap/ui/user_profile
identity_token=<your identity token>     # <-------------------------- replace with your identity token
user_name=<your user name>               # <-------------------------- replace with your user name

component_dir="$(dirname $0)/.."
chart_version="1.0.1"
local_chart_dir="${component_dir}/chart/nested-root"
local_packaged_chart_dir="${component_dir}/commands"
local_packaged_chart_file="${local_packaged_chart_dir}/nested-root-${chart_version}.tgz"
artifactory_chart_url="https://common.repositories.cloud.sap/artifactory/landscaper-examples/guided-tour/nested-root-${chart_version}.tgz"

echo "Packaging helm chart"
helm package "${local_chart_dir}" --version="${chart_version}" --destination="${local_packaged_chart_dir}"

echo "Pushing helm chart"
curl "${artifactory_chart_url}" --upload-file "${local_packaged_chart_file}" --user "${user_name}:${identity_token}"
