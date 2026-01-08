#!/bin/bash

# Importing function run_as_root, get_os_type, get_os_version and install_rpm_package
source RunAsRoot.bash
source OsInfo.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installation variables
VERSION_ID="$(get_os_version)"
ARCHITECTURE="$(uname -m)"

# Installing Mega Sync
if [ "$(get_os_type)" == "fedora" ]; then
  install_rpm_package "https://mega.nz/linux/repo/Fedora_${VERSION_ID}/${ARCHITECTURE}/megasync-Fedora_${VERSION_ID}.${ARCHITECTURE}.rpm"
elif [ "$(get_os_type)" == "centos" ] || [ "$(get_os_type)" == "rhel" ] || [ "$(get_os_type)" == "almalinux" ] || [ "$(get_os_type)" == "ol" ]; then
  install_rpm_package https://mega.nz/linux/repo/Fedora_39/x86_64/megasync-Fedora_39.x86_64.rpm
fi
