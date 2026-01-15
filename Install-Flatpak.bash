#!/bin/bash

# Importing functions run_as_root and install_rpm_package_system
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing flatpak
install_rpm_package_system flatpak