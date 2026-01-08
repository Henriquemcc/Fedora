#!/bin/bash

# Checking if Java 11 is installed
if [ "$(command -v java11)" ]; then
    exit 0
fi

# Importing function run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing Java 11 JRE
install_rpm_package java-11-openjdk-headless

# Creating command java11
ln --symbolic "/usr/lib/jvm/java-11/bin/java" "/bin/java11"