#!/bin/bash

# Importing functions run_as_root and uninstall_rpm_package_system
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Removing VirtualBox package
uninstall_rpm_package_system virtualbox VirtualBox-7.0

# Removing VirtualBox repository
rm /etc/yum.repos.d/virtualbox.repo
