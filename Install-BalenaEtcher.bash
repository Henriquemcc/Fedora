#!/bin/bash

version="2.1.4"
download_url="https://github.com/balena-io/etcher/releases/download/v${version}/balena-etcher-${version}-1.x86_64.rpm"

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Balena Etcher
dnf install --assumeyes "$download_url"