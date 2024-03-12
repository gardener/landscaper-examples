#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

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
