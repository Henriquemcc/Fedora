#!/bin/bash

version="2.1.4"
download_url="https://github.com/balena-io/etcher/releases/download/v${version}/balena-etcher-${version}-1.x86_64.rpm"

# Importing function run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing Balena Etcher
install_rpm_package "$download_url"