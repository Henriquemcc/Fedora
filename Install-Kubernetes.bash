#!/bin/bash

# Importing functions run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Adding repository
{
  echo "[kubernetes]"
  echo "name=Kubernetes"
  echo "baseurl=https://pkgs.k8s.io/core:/stable:/v1.36/rpm/"
  echo "enabled=1"
  echo "1gpgcheck=1"
  echo "gpgkey=https://pkgs.k8s.io/core:/stable:/v1.36/rpm/repodata/repomd.xml.key"
} > /etc/yum.repos.d/kubernetes.repo

# Installing kubectl
install_rpm_package kubectl

# Installing auto completion
kubectl completion bash > /etc/bash_completion.d/kubectl
chmod a+r /etc/bash_completion.d/kubectl

# Installing minikube
install_rpm_package https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm