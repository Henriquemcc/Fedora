#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Removing RPM Fusion's VirtualBox
if [ "$(command -v dnf4)" ]; then
  dnf4 autoremove --assumeyes VirtualBox VirtualBox-kmodsrc VirtualBox-server akmod-VirtualBox kmod-VirtualBox
else
  dnf autoremove --assumeyes VirtualBox VirtualBox-kmodsrc VirtualBox-server akmod-VirtualBox kmod-VirtualBox
fi