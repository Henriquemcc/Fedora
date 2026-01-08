#!/bin/bash

# Importing function run_as_root, get_os_type and install_rpm_package
source RunAsRoot.bash
source OsInfo.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing requirements
install_rpm_package dnf-plugins-core

# Applying update on Fedora Silverblue
if [ "$(command -v rpm-ostree)" ]; then
  rpm-ostree apply-live
fi

# Getting OS Type
os_type="$(get_os_type)"
if [ "$os_type" == "almalinux" ] || [ "$os_type" == "ol" ]; then
  os_type="rhel"
fi

# Adding Docker repository
if [ "$(command -v dnf4)" ]; then
  dnf4 config-manager --assumeyes --add-repo "https://download.docker.com/linux/${os_type}/docker-ce.repo"
elif [ "$(command -v dnf)" ]; then
  dnf config-manager --assumeyes --add-repo "https://download.docker.com/linux/${os_type}/docker-ce.repo"
else
  curl -o /etc/yum.repos.d/docker-ce.repo "https://download.docker.com/linux/${os_type}/docker-ce.repo"
fi

# Installing Docker Engine
install_rpm_package --allowerasing docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enabling Docker
systemctl enable --now docker containerd.service

# Adding user group
groupadd docker
usermod -aG docker "$SUDO_USER"

# Configuring to run in rootless mode
sh -eux <<EOF
# Load ip_tables module
modprobe ip_tables
EOF
setenforce 0
sudo -u "$SUDO_USER" dockerd-rootless-setuptool.sh install
