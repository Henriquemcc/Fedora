#!/bin/bash

# Importing function run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing Google Chrome Beta
install_rpm_package https://dl.google.com/linux/direct/google-chrome-beta_current_x86_64.rpm