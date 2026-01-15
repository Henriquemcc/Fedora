#!/bin/bash

# Importing functions run_as_root and uninstall_rpm_package_system
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Exiting if Visual Studio Code is already installed
if [ "$(command -v code)" ]; then
  exit 0
fi

# Installing Visual Studio Code from RPM package
if [ "$(command -v dnf)" ]; then
  rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
  dnf --assumeyes check-update
  dnf --assumeyes install code

# Installing Visual Studio Code from Snap package
else
  # Installing Snapd
  bash ./Install-Snapd.bash

  # Installing Visual Studio Code
  while true; do
    snap install code --classic && break
  done
fi
