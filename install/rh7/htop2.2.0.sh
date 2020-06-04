#!/usr/bin/env bash
#Install htop

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" && source ${DIR}/common.sh

PACKAGE_LIST=(
    https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/h/htop-2.2.0-3.el7.x86_64.rpm
)

INSTALL_DIR=htop2.2.0
installRPMS "${INSTALL_DIR}" "${PACKAGE_LIST[@]}"



