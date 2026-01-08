#!/bin/bash

# Importing functions run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Checking if the computer has a NVIDIA GPU
if ! lspci | grep -i nvidia; then
    exit 1
fi

# Enabling RPM Fusion
bash ./Enable-RpmFusion.bash

# Installing nvidia driver and nvidia cuda
install_rpm_package --allowerasing akmod-nvidia
install_rpm_package --allowerasing xorg-x11-drv-nvidia-cuda

# Enabling kernel module
echo "nvidia" > "/etc/modules-load.d/nvidia.conf"