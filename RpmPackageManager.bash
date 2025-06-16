#!/bin/bash

function install_rpm_packages() {
  local array_name="$1[@]"
  local rpm_package_to_be_installed=("${!array_name}")
  for package in "${rpm_package_to_be_installed[@]}" ; do
    if [ "$(command -v dnf)" ]; then
      dnf install --assumeyes "$package"
    elif [ "$(command -v yum)" ]; then
      yum install --assumeyes "$package"
    elif [ "$(command -v rpm-ostree)" ]; then
      rpm-ostree install --assumeyes "$package"
    fi
  done
}

function uninstall_rpm_packages() {
  local array_name="$1[@]"
  local rpm_package_to_be_uninstalled=("${!array_name}")
  for package in "${rpm_package_to_be_uninstalled[@]}" ; do
    if [ "$(command -v dnf)" ]; then
      dnf remove --assumeyes "$package"
    elif [ "$(command -v yum)" ]; then
      yum remove --assumeyes "$package"
    elif [ "$(command -v rpm-ostree)" ]; then
      rpm-ostree remove --assumeyes "$package"
    fi
  done
}