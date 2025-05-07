#!/bin/bash

function install_snap_packages() {
  local array_name="$1[@]"
  local rpm_package_to_be_installed=("${!array_name}")
  for package in "${rpm_package_to_be_installed[@]}" ; do
    while true; do
      snap install "$package" && break
    done
  done
}

function uninstall_snap_packages() {
  local array_name="$1[@]"
  local rpm_package_to_be_uninstalled=("${!array_name}")
  for package in "${rpm_package_to_be_uninstalled[@]}" ; do
    while true; do
      snap remove "$package" && break
    done
  done
}