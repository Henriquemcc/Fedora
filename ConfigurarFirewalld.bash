#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing firewalld
if [ "$(command -v dnf)" ]; then
  dnf install --assumeyes firewalld
elif [ "$(command -v yum)" ]; then
  yum install --assumeyes firewalld
elif [ "$(command -v rpm-ostree)" ]; then
  rpm-ostree install --assumeyes firewalld
fi

# Closing all open ports by default
firewall-cmd --permanent --remove-port=1025-65535/tcp
firewall-cmd --permanent --remove-port=1025-65535/udp

# Reloading
firewall-cmd --permanent --reload