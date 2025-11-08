#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Disabling sshd service
systemctl disable --now sshd

# Removing ssh from firewall
firewall-cmd --remove-service=ssh --permanent
firewall-cmd --reload

# Uninstalling sshd
dnf autoremove --assumeyes openssh-server