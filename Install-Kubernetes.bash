#!/bin/bash

# Importing functions run_as_root and install_rpm_package
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Kubectl
bash ./Install-Kubectl.bash

# Installing Minikube
bash ./Install-Minikube.bash

# Installing Kind
bash ./Install-Kind.bash