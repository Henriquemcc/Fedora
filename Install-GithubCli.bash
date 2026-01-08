#!/bin/bash

# Importing function run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing requirements
install_rpm_package 'dnf-command(config-manager)'
install_rpm_package git
install_rpm_package git-lfs

# Adding GitHub Cli repository
if [ "$(command -v dnf4)" ]; then
  dnf4 config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo --assumeyes
elif [ "$(command -v dnf)" ]; then
  dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo --assumeyes
else
  curl -o /etc/yum.repos.d/gh-cli.repo https://cli.github.com/packages/rpm/gh-cli.repo
fi

# Installing GitHub Cli.
install_rpm_package --assumeyes gh