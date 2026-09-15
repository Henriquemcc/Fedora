#!/bin/bash

# Checking if Java 25 is installed
if [ "$(command -v java25)" ]; then
    exit 0
fi

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Java 25 JRE
dnf install --assumeyes java-25-openjdk-headless

# Creating command java25
ln --symbolic "/usr/lib/jvm/java-25/bin/java" "/bin/java25"
