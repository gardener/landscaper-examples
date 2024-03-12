#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0


# Prerequisite: you must login with the following command
# gcloud auth login

COMPONENT_DIR="$(dirname $0)/.."

TMP_DIR=`mktemp -d`

helm package "${COMPONENT_DIR}/chart/many-deployitems" -d "${TMP_DIR}"

gcloud auth print-access-token | helm registry login -u oauth2accesstoken --password-stdin https://eu.gcr.io

helm push "${TMP_DIR}/many-deployitems-extended-1.0.0.tgz" oci://eu.gcr.io/gardener-project/landscaper/examples/charts/scaling
