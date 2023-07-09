#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

git -C "$SCRIPTPATH" submodule update --init --recursive

ansible-galaxy collection install -r "$SCRIPTPATH/ansible/requirements.yml"

ansible-playbook \
    "$SCRIPTPATH/ansible/site.yml" \
    -i "$SCRIPTPATH/ansible/inventory/my-cluster/hosts.ini"