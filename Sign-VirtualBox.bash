#!/bin/bash

# Importing function run_as_root and get_os_type
source RunAsRoot.bash
source OsInfo.bash

function sign_virtualbox_modules() {
  if [ "$(mokutil --sb-state)" == "SecureBoot enabled" ]; then

    # Checking if private and public keys file exist
    bash ./New-KernelModulesPairOfKeys.bash

    # Setting private and public key path
    path_folder_signed_modules="/root/signed-modules"
    path_private_key="$path_folder_signed_modules/private_key.priv"
    path_public_key="$path_folder_signed_modules/public_key.der"

    sign_file_binary_path="/usr/src/kernels/$(uname -r)/scripts/sign-file"

    path_virtualbox_modules_directory="$(dirname "$(modinfo -n vboxdrv)")"

    # For each file in the VirtualBox kernel module directory
    for file_path_in_virtualbox_modules_directory in "$path_virtualbox_modules_directory"/*; do

      # Decompressing XZ file
      if [ "${file_path_in_virtualbox_modules_directory: -3}" == ".xz" ]; then
        command_to_sign_kernel_module="$sign_file_binary_path sha256 \"$path_private_key\" \"$path_public_key\" \"$file_path_in_virtualbox_modules_directory\""
        eval "$command_to_sign_kernel_module"
        xz --decompress --keep "$file_path_in_virtualbox_modules_directory"
        file_path_in_virtualbox_modules_directory="${file_path_in_virtualbox_modules_directory::-3}"
      fi

      # Signing .ko file
      if [ "${file_path_in_virtualbox_modules_directory: -3}" == ".ko" ]; then
        command_to_sign_kernel_module="$sign_file_binary_path sha256 \"$path_private_key\" \"$path_public_key\" \"$file_path_in_virtualbox_modules_directory\""
        eval "$command_to_sign_kernel_module"
      fi

    done

  fi

}

# Running as root
run_as_root

# Installing requirements
sudo dnf install --assumeyes kmod
sudo dnf install --assumeyes coreutils
sudo dnf install --assumeyes kernel-devel
sudo dnf install --assumeyes kernel-devel-"$(uname -r)"
sudo dnf install --assumeyes kernel-headers
sudo dnf install --assumeyes akmods
sudo dnf install --assumeyes dkms
sudo dnf install --assumeyes qt5-qtx11extras
sudo dnf install --assumeyes elfutils-libelf-devel
sudo dnf install --assumeyes zlib-devel
sudo dnf install --assumeyes @development-tools

# Installing kernel uek devel for Oracle Linux
if [ "$(get_os_type)" == "ol" ]; then
  sudo dnf install --assumeyes kernel-uek-devel
  sudo dnf install --assumeyes kernel-uek-devel-"$(uname -r)"
fi

sign_virtualbox_modules

# Unloading KVM kernel modules
sudo modprobe -r kvm_intel kvm

# Loading VirtualBox kernel modules
sudo modprobe vboxdrv

# Rebuilding kernel akmod packages
sudo akmods

# Restarting VirtualBox service
sudo systemctl restart vboxdrv.service

# Configuring VirtualBox
sudo /sbin/vboxconfig
