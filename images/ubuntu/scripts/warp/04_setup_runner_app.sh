#!/bin/bash

cd /runner
curl -f -L -o runner.tar.gz https://github.com/actions/runner/releases/download/v2.311.0/actions-runner-linux-x64-2.311.0.tar.gz \
        && tar xzf ./runner.tar.gz \
        && rm runner.tar.gz

curl -f -L -o runner-container-hooks.zip https://github.com/actions/runner-container-hooks/releases/download/v0.3.2/actions-runner-hooks-k8s-0.3.2.zip \
        && unzip ./runner-container-hooks.zip -d ./k8s \
        && rm runner-container-hooks.zip

export DEBIAN_FRONTEND=noninteractive
