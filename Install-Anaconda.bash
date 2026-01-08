#!/bin/bash

# Importing function run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

if ! [ "$(command -v anaconda)" ]; then
  install_rpm_package anaconda
fi