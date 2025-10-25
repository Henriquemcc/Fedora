#!/bin/bash

# Importing function run_as_root and get_os_type
source RunAsRoot.bash
source OsInfo.bash

# Running as root
run_as_root

# Removing RPM Fusion's VirtualBox
bash ./Uninstall-VirtualBox.bash

# Downloading and registering Oracle VirtualBox Key
rpm --import https://www.virtualbox.org/download/oracle_vbox.asc

# Adding Oracle VirtualBox Repository
if [ "$(get_os_type)" == "fedora" ]; then
  curl -L https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo --output virtualbox.repo
elif [ "$(get_os_type)" == "rhel" ] || [ "$(get_os_type)" == "centos" ] || [ "$(get_os_type)" == "almalinux" ] || [ "$(get_os_type)" == "ol" ]; then
  curl -L https://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo --output virtualbox.repo
fi

mv ./virtualbox.repo /etc/yum.repos.d/virtualbox.repo

# Installing VirtualBox
dnf install --assumeyes VirtualBox-7.2
