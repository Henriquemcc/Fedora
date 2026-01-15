#!/bin/bash

# Importing functions run_as_root and install_rpm_package_system
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Uninstalling Oracle VirtualBox
bash ./Uninstall-OracleVirtualBox.bash

# Enabling RPM fusion
bash ./Enable-RpmFusion.bash

# Installing VirtualBox
if ! [ "$(command -v virtualbox)" ]; then
  install_rpm_package_system VirtualBox
  install_rpm_package_system virtualbox-guest-additions

  # Installing Secure Boot required packages
  if [ "$(mokutil --sb-state)" == "SecureBoot enabled" ]; then
    install_rpm_package_system kmod-VirtualBox
    install_rpm_package_system VirtualBox-kmodsrc
    install_rpm_package_system akmod-VirtualBox
  fi
fi
