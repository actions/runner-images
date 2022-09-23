#!/bin/bash

# Enable user session on boot, not on login
UserId=$(cut -d: -f3 /etc/passwd | tail -1)
loginctl enable-linger $UserId
