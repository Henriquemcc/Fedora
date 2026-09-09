#!/bin/bash

# Installing curl
bash ./Install-Curl.bash

# Downloading Kind
if [ "$(uname -m)" == "x86_64" ]; then
  curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.32.0/kind-linux-amd64
elif [ "$(uname -m)" = "aarch64" ]; then
  curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.32.0/kind-linux-arm64
fi

# Defining permissions
chmod +x ./kind

# Moving kind executable
mv ./kind /usr/local/bin/kind