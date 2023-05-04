#!/bin/bash

# Checking if Java 11 is installed
if [ "$(command -v java11)" ]; then
    exit 0
fi

# Installing Java 11 JRE
sudo dnf install --assumeyes java-11-openjdk-headless

# Creating command java11
sudo ln --symbolic "/usr/lib/jvm/java-11/bin/java" "/bin/java11"