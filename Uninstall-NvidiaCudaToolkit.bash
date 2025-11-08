#!/bin/bash

# Importing function run_as_root, get_os_type and get_os_version
source RunAsRoot.bash
source OsInfo.bash

# Running as root
run_as_root

# Removing Nvidia Cuda
dnf module reset nvidia-driver
dnf autoremove --assumeyes nvidia-driver
dnf autoremove --assumeyes cuda

# Removing repository
if [ "$(command -v dnf4)" ]; then
  dnf4 config-manager --disable "cuda-rhel9-x86_64"
else
  dnf config-manager --disable "cuda-rhel9-x86_64"
fi

# Updating grub
grub2-mkconfig -o /etc/grub2.cfg
grub2-mkconfig -o /etc/grub2-efi.cfg
grub2-mkconfig -o /boot/grub2/grub.cfg
