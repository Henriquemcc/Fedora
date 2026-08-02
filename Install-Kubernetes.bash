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
if [ "$(uname -m)" == "x86_64" ]; then
  install_rpm_package https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm
elif [ "$(uname -m)" == "aarch64" ]; then
  install_rpm_package https://storage.googleapis.com/minikube/releases/latest/minikube-latest.aarch64.rpm
fi

# Installing Kind
if [ "$(uname -m)" == "x86_64" ]; then
  curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.32.0/kind-linux-amd64
elif [ "$(uname -m)" = "aarch64" ]; then
  curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.32.0/kind-linux-arm64
fi
chmod +x ./kind
mv ./kind /usr/local/bin/kind