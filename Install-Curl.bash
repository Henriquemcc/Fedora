#!/bin/bash

# Importing function run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

if ! [ "$(command -v curl)" ]; then
  install_rpm_package curl
fi