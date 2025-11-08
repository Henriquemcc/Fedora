#!/bin/bash

# Importing function run_as_root and get_os_type
source RunAsRoot.bash
source OsInfo.bash

# Running as root
run_as_root

# Installing requirements
dnf install --assumeyes 'dnf-command(config-manager)'

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
dnf install --allowerasing --assumeyes ffmpeg