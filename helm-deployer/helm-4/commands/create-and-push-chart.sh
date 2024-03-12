#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0


# Prerequisite: you must login with the following command
# gcloud auth login

COMPONENT_DIR="$(dirname $0)/.."

helm package "${COMPONENT_DIR}/chart/simple-chart" -d "${COMPONENT_DIR}/commands"

gcloud auth print-access-token | helm registry login -u oauth2accesstoken --password-stdin https://eu.gcr.io

helm push "${COMPONENT_DIR}/commands/simple-chart-0.1.0.tgz" oci://eu.gcr.io/gardener-project/landscaper/integration-tests/charts
