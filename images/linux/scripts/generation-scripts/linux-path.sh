#!/bin/bash

# Remove quotes if found around PATH
if [[ $PATH == \"*\" ]]
then
    PATH=${PATH#"\""}
    PATH=${PATH%"\""}
    echo "PATH=$PATH" | sudo tee -a /etc/environment
    echo "Updated path to remove quotes: $PATH"
else
    echo "No path update needed: $PATH"
fi
