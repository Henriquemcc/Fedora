#!/bin/bash

# Importing functions run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Exiting if snap is already installed
if [ "$(command -v snap)" ]; then
  exit 0
fi

# Running as root
run_as_root

# Installing Snap package manager
install_rpm_package snapd

# Enabling Snapd
systemctl enable --now snapd.socket

# Enabling classic snap support
ln -s /var/lib/snapd/snap /snap

# Installing Kernel modules
install_rpm_package fuse
install_rpm_package squashfuse
install_rpm_package kernel-modules

# Installing snap core
snap install core

# Updating snap core
snap refresh core