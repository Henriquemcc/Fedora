#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Removing VirtualBox package
if [ "$(command -v dnf4)" ]; then
  dnf4 autoremove --assumeyes virtualbox VirtualBox-7.0
else
  dnf autoremove --assumeyes virtualbox VirtualBox-7.0
fi

# Removing VirtualBox repository
rm /etc/yum.repos.d/virtualbox.repo
