#!/bin/bash

# Checking if Apkeep is already installed
if [ "$(command -v apkeep)" ]; then
    exit 0
fi

# Installing requirements
bash ./Install-RustLang.bash

# Installing Apkeep
cargo install apkeep