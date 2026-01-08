#!/bin/bash

# Importing function run_as_root, get_os_type, get_os_version and uninstall_rpm_package
source RunAsRoot.bash
source OsInfo.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Removing Nvidia Cuda
dnf module reset nvidia-driver
uninstall_rpm_package nvidia-driver
uninstall_rpm_package cuda

# Removing repository
if [ "$(command -v dnf4)" ]; then
  dnf4 config-manager --disable "cuda-rhel9-x86_64"
elif [ "$(command -v dnf)" ]; then
  dnf config-manager --disable "cuda-rhel9-x86_64"
else
  sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/cuda-rhel9-x86_64.repo
fi

# Updating grub
grub2-mkconfig -o /etc/grub2.cfg
grub2-mkconfig -o /etc/grub2-efi.cfg
grub2-mkconfig -o /boot/grub2/grub.cfg
