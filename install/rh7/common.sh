#!/usr/bin/env bash
#Init functions
#DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" && source ${DIR}/common.sh

#Extract any file
f_extract() {
    if [ -f $1 ]; then
        #RPM extract: https://www.cyberciti.biz/tips/how-to-extract-an-rpm-package-without-installing-it.html
        case $1 in
        *.tar.bz2) tar xvjf $1 ;;
        *.tar.gz) tar xvzf $1 ;;
        *.bz2) bunzip2 $1 ;;
        *.dmg) hdiutil mount $1 ;;
        *.rar) unrar x $1 ;;
        *.gz) gunzip $1 ;;
        *.tar) tar xvf $1 ;;
        *.tbz2) tar xvjf $1 ;;
        *.tgz) tar xvzf $1 ;;
        *.zip) unzip $1 ;;
        *.ZIP) unzip $1 ;;
        *.Z) uncompress $1 ;;
        *.7z) 7z x $1 ;;
        *.pax) cat $1 | pax -r ;;
        *.pax.Z) uncompress $1 --stdout | pax -r ;;
        *.rar) unrar x $1 ;;
        *.xz) tar -xJf $1 ;;
        *.rpm) rpm2cpio $1 | cpio -idmv ;;
        *) echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

#Get the current directory
getPwd() {
    DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
    echo "${DIR}"
}

#Install a list of RPMs
installRPMS() {
    # First parameter has to be install directory
    INSTALL_DIR=${1}

    #Shift to process the rest
    shift

    if [ -n "${INSTALL_DIR}" ]; then
        mkdir -p ${INSTALL_DIR}
        cd ${INSTALL_DIR}
        for PACKAGE in ${@}; do
            wget -c ${PACKAGE} -O - | rpm2cpio | cpio -idmv
            #curl ${PACKAGE} | rpm2cpio | cpio -idmv
        done
    fi
}

#Install a list of RPMs
installTarGz() {
    # First parameter has to be install directory
    INSTALL_DIR=${1}

    #Shift to process the rest
    shift

    if [ -n "${INSTALL_DIR}" ]; then
        mkdir -p ${INSTALL_DIR}
        cd ${INSTALL_DIR}
        for PACKAGE in ${@}; do
            #Downloads and extract
            curl ${PACKAGE} | tar -xvz
        done
    fi
}

#Join array
join_arr() {
    local IFS="$1"
    shift
    echo "${data[$*]}"
}

#Download RPM and resolve dependencies. Downloads to current directory
downloadRPM() {
    PACKAGE=$1
    #Requires:
    # yum install yum-utils
    #https://www.ostechnix.com/download-rpm-package-dependencies-centos/
    yumdownloader --resolve "${PACKAGE}"
}

#Reference:
#https://stackoverflow.com/questions/12813987/bash-command-spanning-multiple-lines-with-several-lines-of-comments-in-between
#https://stackoverflow.com/questions/5750450/how-can-i-print-each-command-before-executing
#https://wiki.bash-hackers.org/scripting/debuggingtips#use_shell_debug_output
