#!/bin/bash

# Checking if Java 27 is installed
if [ "$(command -v java27)" ]; then
    exit 0
fi

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Java 27 JRE
dnf install --assumeyes java-latest-openjdk-headless

# Creating command java27
ln --symbolic "/usr/lib/jvm/java-27/bin/java" "/bin/java27"
