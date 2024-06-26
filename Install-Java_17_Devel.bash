#!/bin/bash

# Importing function run_as_root
source RunAsRoot.bash

# Running as root
run_as_root

# Installing Java
bash ./Install-Java_17_Headless.bash

# Checking if Java compiler 17 is installed
if [ "$(command -v javac17)" ]; then
    exit 0
fi

# Installing Java 17 JDK
dnf install --assumeyes java-17-openjdk-devel

# Creating command javac17
ln --symbolic "/usr/lib/jvm/java-17/bin/javac" "/bin/javac17"