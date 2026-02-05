#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

function sign_nvidia_modules() {
  # Checking if secure boot is activated
  if [ "$(mokutil --sb-state)" == "SecureBoot enabled" ]; then

    # Checking if private and public keys file exist
    bash ./New-KernelModulesPairOfKeys.bash

    # Path defined in the script New-KernelModulesPairOfKeys.bash
    path_folder_signed_modules="/root/signed-modules"
    path_private_key="$path_folder_signed_modules/private_key.priv"
    path_public_key="$path_folder_signed_modules/public_key.der"

    # Location of the kernel signature binary in Fedora
    sign_file_binary_path="/usr/src/kernels/$(uname -r)/scripts/sign-file"

    # Finds the directory where the nvidia modules were installed
    # On Fedora with akmod, they are usually located in /lib/modules/$(uname -r)/extra/nvidia/
    nvidia_module_path=$(dirname "$(modinfo -n nvidia 2>/dev/null)")

    if [ -z "$nvidia_module_path" ]; then
        echo "Error: No Nvidia modules found. Certify that akmod-nvidia finished the compilation."
        return 1
    fi

    echo "Signing modules in: $nvidia_module_path"

    # Iterates over the modules (nvidia, nvidia-modeset, nvidia-uvm, nvidia-drm)
    for module in "$nvidia_module_path"/*.ko*; do

      # Logic for compressed files (.xz), similar to Sign-VirtualBox.bash script.
      if [[ "$module" == *.xz ]]; then
        echo "Unpacking and signing: $module"
        xz --decompress --keep "$module"
        module_decompressed="${module::-3}"

        command_to_sign="$sign_file_binary_path sha256 \"$path_private_key\" \"$path_public_key\" \"$module_decompressed\""
        eval "$command_to_sign" [cite: 4, 5]

        # Optional: Repackage or remove the old .xz file so the kernel loads the signed .ko file.
        rm "$module"
        xz "$module_decompressed"

      # Logic for direct .ko files
      elif [[ "$module" == *.ko ]]; then
        echo "Signing: $module"
        "$sign_file_binary_path" sha256 "$path_private_key" "$path_public_key" "$module"
      fi
    done

    echo "Signing completed. Loading modules..."
    depmod -a
    modprobe nvidia
  fi
}

# Ensures execution as root
run_as_root

# Runs the signing function
sign_nvidia_modules

# Rebuild opcional to ensure that akmods recognizes the changes
akmods --force
