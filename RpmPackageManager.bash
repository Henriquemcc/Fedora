#!/bin/bash

function install_rpm_packages_system() {
  local array_name="$1[@]"
  local rpm_package_to_be_installed=("${!array_name}")
  for package in "${rpm_package_to_be_installed[@]}" ; do
    install_rpm_package_system "$package"
  done
}

function install_rpm_package_system() {
  if [ "$(command -v dnf)" ]; then
    dnf install --assumeyes "$@"
  elif [ "$(command -v yum)" ]; then
    yum install --assumeyes "$@"
  elif [ "$(command -v rpm-ostree)" ]; then
    rpm-ostree install --assumeyes "$@"
  else
    echo "Error: No package manager (dnf, yum, rpm-ostree) founded." >&2
    return 1
  fi
}

function uninstall_rpm_packages_system() {
  local array_name="$1[@]"
  local rpm_package_to_be_uninstalled=("${!array_name}")
  for package in "${rpm_package_to_be_uninstalled[@]}" ; do
    uninstall_rpm_package_system "$package"
  done
}

function uninstall_rpm_package_system() {
  if [ "$(command -v dnf)" ]; then
    dnf remove --assumeyes "$@"
  elif [ "$(command -v yum)" ]; then
    yum remove --assumeyes "$@"
  elif [ "$(command -v rpm-ostree)" ]; then
    rpm-ostree remove --assumeyes "$@"
  else
    echo "Error: No package manager (dnf, yum, rpm-ostree) founded." >&2
    return 1
  fi
}