#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Checking if the computer has a NVIDIA GPU
if ! lspci | grep -i nvidia; then
    exit 1
fi

# Enabling RPM Fusion
bash ./Enable-RpmFusion.bash

# Installing nvidia driver and nvidia cuda
dnf install --assumeyes --allowerasing akmod-nvidia
dnf install --assumeyes --allowerasing xorg-x11-drv-nvidia-cuda

# Enabling kernel module
echo "nvidia" > "/etc/modules-load.d/nvidia.conf"