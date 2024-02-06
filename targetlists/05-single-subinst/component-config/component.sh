#!/bin/bash
#
# Copyright (c) 2024 SAP SE or an SAP affiliate company. All rights reserved. This file is licensed under the Apache Software License, v. 2 except as noted otherwise in the LICENSE file
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

if [[ -z "${repository_base_url}" ]]; then
  echo "Variable repository_base_url must contain the base path of the ocm repository"
  exit 1
fi

# This commands adds the components to a ctf (common transport archive), which is a file system representation of a
# oci registry
# --create specifies that the ctf file/directory should be created if it does not exist yet
# --file specifies the target ctf file/directory where the components should be added
ocm add components --create --file ../component-ctf ./components.yaml

# This command transfers the components contained in the specified ctf (here tour-ctf) to another component repository
# (here, an oci registry)
# --enforce specifies that already existing components in the target should always be overwritten with the ones
# from your source
ocm transfer ctf --enforce ../component-ctf ${repository_base_url}

## to inspect a specific component, you can use the following command to download into a component archive (a simple file
## system representation of a single component)
## this can be done from a remote repository
# ocm download component eu.gcr.io/gardener-project/landscaper/examples//github.com/gardener/landscaper-examples/guided-tour/external-blueprint:2.0.0 -O ../archive
## or from a local ctf representation
# ocm download component ../tour-ctf//github.com/gardener/landscaper-examples/guided-tour/external-blueprint:2.0.0 -O ../archive