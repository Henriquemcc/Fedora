#!/bin/bash

# Importing functions run_as_root, get_os_type, get_os_version and install_rpm_package_system
source RunAsRoot.bash
source OsInfo.bash
source RpmPackageManager.bash

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
  elif [ "$(command -v dnf)" ]; then
    dnf config-manager --add-repo "https://developer.download.nvidia.com/compute/cuda/repos/$(get_os_type)$(get_os_version)/x86_64/cuda-$(get_os_type)$(get_os_version).repo" || exit 1
  else
    curl -o "/etc/yum.repos.d/cuda-$(get_os_type)$(get_os_version).repo" "https://developer.download.nvidia.com/compute/cuda/repos/$(get_os_type)$(get_os_version)/x86_64/cuda-$(get_os_type)$(get_os_version).repo"
  fi
elif [ "$(get_os_type)" == "rhel" ] || [ "$(get_os_type)" == "centos" ] || [ "$(get_os_type)" == "almalinux" ] || [ "$(get_os_type)" == "ol" ]; then
  if [ "$(command -v dnf4)" ]; then
    dnf4 config-manager --add-repo "https://developer.download.nvidia.com/compute/cuda/repos/rhel$(get_os_version)/x86_64/cuda-rhel$(get_os_version).repo" || exit 1
  elif [ "$(command -v dnf)" ]; then
    dnf config-manager --add-repo "https://developer.download.nvidia.com/compute/cuda/repos/rhel$(get_os_version)/x86_64/cuda-rhel$(get_os_version).repo" || exit 1
  else
    curl -o "/etc/yum.repos.d/cuda-rhel$(get_os_version).repo" "https://developer.download.nvidia.com/compute/cuda/repos/rhel$(get_os_version)/x86_64/cuda-rhel$(get_os_version).repo"
  fi
fi

# Installing Nvidia driver
if [ "$(command -v dnf)" ]; then
  dnf module install --assumeyes --allowerasing nvidia-driver
else
  install_rpm_package_system --allowerasing nvidia-driver
fi

# Installing Nvidia Cuda ToolKit
install_rpm_package_system cuda-toolkit

# Installing GPUDirect Filesystem
install_rpm_package_system nvidia-gds

# Enabling kernel module
echo "nvidia" > "/etc/modules-load.d/nvidia.conf"