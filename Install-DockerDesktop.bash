#!/bin/bash

# Importing functions run_as_root and install_rpm_package_system
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing Docker Engine
bash ./Install-DockerEngine.bash

# Installing Docker desktop
install_rpm_package_system https://desktop.docker.com/linux/main/amd64/docker-desktop-x86_64.rpm
