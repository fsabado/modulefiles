#!/usr/bin/env bash
set -x
#Install yum-utils

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" && source ${DIR}/common.sh

PACKAGE_LIST=(
    http://mirror.centos.org/centos/7/os/x86_64/Packages/yum-utils-1.1.31-53.el7.noarch.rpm
)

INSTALL_DIR=${OPT_INSTALL}/yum-utils-1.1.31.53

if [ -n "${OPT_INSTALL}" ]; then
    installRPMS "${INSTALL_DIR}" "${PACKAGE_LIST[@]}"
else
    echo "OPT_INSTALL not defined."
fi


