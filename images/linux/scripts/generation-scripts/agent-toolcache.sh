#!/bin/bash

if [[ "$USER" = "runner" ]]; then
    if [ -z "$RUNNER_TOOL_CACHE" ]; then
        RUNNER_TOOL_CACHE=$AGENT_TOOLSDIRECTORY
        echo "RUNNER_TOOL_CACHE=$RUNNER_TOOL_CACHE" | sudo tee -a /etc/environment
        echo "RUNNER_TOOL_CACHE set to match AGENT_TOOLSDIRECTORY: $RUNNER_TOOL_CACHE"
    else
        echo "RUNNER_TOOL_CACHE non-empty: $RUNNER_TOOL_CACHE"
    fi
elif [[ "$USER" = "vsts" ]]; then
    if [ -z "$RUNNER_TOOLSDIRECTORY" ]; then
        RUNNER_TOOLSDIRECTORY=$AGENT_TOOLSDIRECTORY
        echo "RUNNER_TOOLSDIRECTORY=$RUNNER_TOOLSDIRECTORY" | sudo tee -a /etc/environment
        echo "RUNNER_TOOLSDIRECTORY set to match AGENT_TOOLSDIRECTORY: $RUNNER_TOOLSDIRECTORY"
    else
        echo "RUNNER_TOOLSDIRECTORY non-empty: $RUNNER_TOOLSDIRECTORY"
    fi
else
    echo "the environment is incorrect"
fi







