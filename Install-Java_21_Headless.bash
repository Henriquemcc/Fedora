#!/bin/bash

# Checking if Java 21 is installed
if [ "$(command -v java21)" ]; then
    exit 0
fi

# Importing function run_as_root and install_rpm_package
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing Java 21 JRE
install_rpm_package java-21-openjdk-headless

# Creating command java21
ln --symbolic "/usr/lib/jvm/java-21/bin/java" "/bin/java21"
