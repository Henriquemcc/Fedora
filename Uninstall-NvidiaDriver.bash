#!/bin/bash

# Importing function run_as_root, get_os_type and get_os_version
source RunAsRoot.bash
source OsInfo.bash

# Running as root
run_as_root

# Removing kernel module
rm "/etc/modules-load.d/nvidia.conf"

# Removing Nvidia Cuda ToolKit
dnf autoremove --assumeyes cuda-toolkit

# Removing GPUDirect Filesystem
dnf autoremove --assumeyes nvidia-gds

# Removing Nvidia driver
dnf module reset --assumeyes nvidia-driver
dnf autoremove --assumeyes nvidia-driver

# Removing repository
if [ "$(command -v dnf4)" ]; then
  dnf4 config-manager --disable "cuda-rhel9-x86_64"
else
  dnf config-manager --disable "cuda-rhel9-x86_64"
fi
