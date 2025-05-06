#!/bin/bash

# Importing function run_as_root, get_os_type and get_os_version
source RunAsRoot.bash
source OsInfo.bash

# Running as root
run_as_root

# Checking if the computer has a NVIDIA GPU
if ! lspci | grep -i nvidia; then
    exit 1
fi

# Checking if architecture is x86_64
if [ "$(uname -m)" != "x86_64" ] ; then
    exit 1
fi

# Installing repository
if [ "$(get_os_type)" == "fedora" ]; then
  if [ "$(command -v dnf4)" ]; then
    dnf4 config-manager --add-repo "https://developer.download.nvidia.com/compute/cuda/repos/$(get_os_type)$(get_os_version)/x86_64/cuda-$(get_os_type)$(get_os_version).repo" || exit 1
  else
    dnf config-manager --add-repo "https://developer.download.nvidia.com/compute/cuda/repos/$(get_os_type)$(get_os_version)/x86_64/cuda-$(get_os_type)$(get_os_version).repo" || exit 1
  fi
elif [ "$(get_os_type)" == "rhel" ] || [ "$(get_os_type)" == "centos" ] || [ "$(get_os_type)" == "almalinux" ] || [ "$(get_os_type)" == "ol" ]; then
  if [ "$(command -v dnf4)" ]; then
    dnf4 config-manager --add-repo "https://developer.download.nvidia.com/compute/cuda/repos/rhel$(get_os_version)/x86_64/cuda-rhel$(get_os_version).repo" || exit 1
  else
    dnf config-manager --add-repo "https://developer.download.nvidia.com/compute/cuda/repos/rhel$(get_os_version)/x86_64/cuda-rhel$(get_os_version).repo" || exit 1
  fi
fi

# Installing Nvidia driver
dnf module install --assumeyes nvidia-driver

# Installing Nvidia Cuda ToolKit
dnf install --assumeyes cuda-toolkit

# Installing GPUDirect Filesystem
dnf install --assumeyes nvidia-gds

# Enabling kernel module
echo "nvidia" > "/etc/modules-load.d/nvidia.conf"