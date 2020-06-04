#!/usr/bin/env bash
set -x
#Install Intellij

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" && source ${DIR}/common.sh

PACKAGE_LIST=(
    https://download-cf.jetbrains.com/idea/ideaIC-2020.1.2.tar.gz
)

INSTALL_DIR=${OPT_INSTALL}

if [ -n "${OPT_INSTALL}" ]; then
    installTarGz "${INSTALL_DIR}" "${PACKAGE_LIST[@]}"
else
    echo "OPT_INSTALL not defined."
fi