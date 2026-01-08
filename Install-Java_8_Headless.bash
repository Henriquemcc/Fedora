#!/bin/bash

# Checking if Java 8 is installed
if [ "$(command -v java8)" ]; then
    exit 0
fi

# Importing function run_as_root
source RunAsRoot.bash
source RpmPackageManager.bash

# Running as root
run_as_root

# Installing Java 8 JRE
install_rpm_package java-1.8.0-openjdk-headless

# Creating command java8
ln --symbolic "/usr/lib/jvm/jre-1.8.0/bin/java" "/bin/java8"