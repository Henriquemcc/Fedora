#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing ollama
dnf install --assumeyes ollama

# Enabling ollama
systemctl enable --now ollama