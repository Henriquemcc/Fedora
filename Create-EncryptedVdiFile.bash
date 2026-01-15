#!/bin/bash

# Importing functions run_as_root and install_rpm_package_system
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Variables
vdi_file_path="$1"
vdi_file_max_size="$2"

# Installing requirements
install_rpm_package_system qemu-img
install_rpm_package_system cryptsetup
install_rpm_package_system udisks

# Getting the vdi file path if it is not provided as an argument
if [ -z "$vdi_file_path" ]; then
    echo "VDI file path: "
    read -r vdi_file_path
fi

# Getting the vdi file size if it is not provided as an argument
if [ -z "$vdi_file_max_size" ]; then
    echo "VDI file max size: "
    read -r vdi_file_max_size
fi

# Checking if the vdi file already exists
if [ -f "$vdi_file_path" ]; then
    echo "VDI file already exists"
    exit 1
fi

# Creating VDI file
qemu-img create -f vdi "$vdi_file_path" "$vdi_file_max_size"

# Path to the destination device file where the vdi file will be mounted
destination_device_path="/dev/nbd0"

# Exiting if the vdi file is already mounted
if [ -f "$destination_device_path" ]; then
  echo "VDI file is already mounted"
  exit 1
fi

# Removing Module NBD
rmmod nbd

# Adding Module NBD
modprobe nbd max_part=1

# Mounting vdi file
qemu-nbd --connect "$destination_device_path" "$vdi_file_path"

# Creating encrypted device
cryptsetup luksFormat "$destination_device_path"

# Opening encrypted device
cryptsetup luksOpen "$destination_device_path" my_encrypted_volume

# Creating ext4 file system
mkfs.ext4 /dev/mapper/my_encrypted_volume