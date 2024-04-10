#!/bin/bash

# Importing function run_as_root and get_os_type
source RunAsRoot.bash
source OsInfo.bash

# Running as root
run_as_root

# Installing requirements
dnf install --assumeyes dnf-plugins-core

# Adding Docker repository
dnf config-manager --assumeyes --add-repo "https://download.docker.com/linux/$(get_os_type)/docker-ce.repo"

# Installing Docker Engine
dnf install --assumeyes docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enabling Docker
systemctl enable --now docker