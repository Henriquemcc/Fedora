#!/bin/bash

# Importing functions run_as_root and uninstall_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Removing RPM Fusion's VirtualBox
uninstall_rpm_package VirtualBox VirtualBox-kmodsrc VirtualBox-server akmod-VirtualBox kmod-VirtualBox