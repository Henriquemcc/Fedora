#!/bin/bash

# Importing function run_as_root, get_os_type and install_rpm_package
source RunAsRoot.bash
source OsInfo.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing requirements
install_rpm_package 'dnf-command(config-manager)'

# Getting the name of the Code Ready Builder repository
repository_name=""

# Oracle Linux
if [ "$(get_os_type)" == "ol" ]; then
  repository_name="ol$(get_os_version)_codeready_builder"

# AlmaLinux
elif [ "$(get_os_type)" == "almalinux" ]; then
  if [ "$(get_os_version)" == "9" ]; then
    repository_name="crb"
  else
    repository_name="powertools"
  fi
fi

# Enabling Code Ready Builder repository
dnf config-manager --set-enabled "$repository_name"

# Installing ffmpeg
install_rpm_package --allowerasing ffmpeg