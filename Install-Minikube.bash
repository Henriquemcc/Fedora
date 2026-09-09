#!/bin/bash

# Importing functions run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing minikube
if [ "$(uname -m)" == "x86_64" ]; then
  install_rpm_package https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm
elif [ "$(uname -m)" == "aarch64" ]; then
  install_rpm_package https://storage.googleapis.com/minikube/releases/latest/minikube-latest.aarch64.rpm
fi