#!/bin/bash

# Importing functions run_as_root, get_os_type, get_os_version and uninstall_rpm_package
source RunAsRoot.bash
source OsInfo.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Removing kernel module
rm "/etc/modules-load.d/nvidia.conf"

# Removing Nvidia Cuda ToolKit
uninstall_rpm_package cuda-toolkit

# Removing GPUDirect Filesystem
uninstall_rpm_package nvidia-gds

# Removing Nvidia driver
dnf module reset --assumeyes nvidia-driver
uninstall_rpm_package nvidia-driver

# Removing repository
if [ "$(command -v dnf4)" ]; then
  dnf4 config-manager --disable "cuda-rhel9-x86_64"
elif [ "$(command -v dnf)" ]; then
  dnf config-manager --disable "cuda-rhel9-x86_64"
else
  sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/cuda-rhel9-x86_64.repo
fi
