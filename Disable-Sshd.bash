#!/bin/bash

# Importing function run_as_root and uninstall_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Disabling sshd service
systemctl disable --now sshd

# Removing ssh from firewall
firewall-cmd --remove-service=ssh --permanent
firewall-cmd --reload

# Uninstalling sshd
uninstall_rpm_package openssh-server