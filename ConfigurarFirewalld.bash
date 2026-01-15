#!/bin/bash

# Importing functions run_as_root and install_rpm_package_system
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing firewalld
install_rpm_package_system firewalld

# Closing all open ports by default
firewall-cmd --permanent --remove-port=1025-65535/tcp
firewall-cmd --permanent --remove-port=1025-65535/udp

# Reloading
firewall-cmd --permanent --reload