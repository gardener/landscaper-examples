#!/bin/bash
#
# SPDX-FileCopyrightText: 2024 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

DOCKERFILE_DIR="$(dirname $0)/../Docker"
NAME="container-deployer"
VERSION="v0.1.0"
OCI_REPO="eu.gcr.io/gardener-project/landscaper/examples/images"

docker build -t "${OCI_REPO}/${NAME}:${VERSION}" --platform amd64 $DOCKERFILE_DIR
docker push "${OCI_REPO}/${NAME}:${VERSION}"
