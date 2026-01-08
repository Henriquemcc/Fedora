#!/bin/bash

# Importing function run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing Google Earth
install_rpm_package https://dl.google.com/dl/earth/client/current/google-earth-pro-stable-current.x86_64.rpm