
# GitHub Actions Runner Images - Prebuilt Images in Azure Compute Gallery

![Build Status](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/wiki/azure-way/actions-runner-images/ubuntu-24.04.md?v=1) ![Build Status](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/wiki/azure-way/actions-runner-images/ubuntu-22.04.md) ![Build Status](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/wiki/azure-way/actions-runner-images/ubuntu-20.04.md)

![Build Status](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/wiki/azure-way/actions-runner-images/windows-2022.md)
![Build Status](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/wiki/azure-way/actions-runner-images/windows-2019.md)

This repository demonstrates how to set up and configure a self-hosted Azure DevOps agent using prebuilt images. The guide provides a comprehensive overview of the steps needed to deploy and manage your own agent to optimize CI/CD pipelines.

## Overview

Azure DevOps allows users to configure self-hosted agents for build and release pipelines. By using prebuilt images, we can simplify the agent setup process and increase efficiency. This approach minimizes the configuration overhead and provides a faster setup for development teams.

For detailed information about using prebuilt images in your self-hosted agent, refer to the [full guide here](https://azureway.cloud/azure-devops-self-hosted-agent-using-prebuilt-images/).

## Features

- Prebuilt agent images to reduce setup complexity
- Customizable pipeline configurations for specific use cases
- Full control over your build and deployment environments
- Cost-effective alternative to Microsoft-hosted agents

## Prerequisites

- An Azure subscription
- Access to Azure DevOps services
- Virtual machine with supported OS (e.g., Ubuntu, Windows Server)
- Docker installed (optional if using containerized agents)

## Quick Start

1. **Provision Virtual Machine**: Start by creating a VM in your Azure portal with an OS supported by Azure DevOps agents.
2. **Install Required Dependencies**: Ensure the required dependencies such as .NET, Git, or Node.js are pre-installed based on your development environment.
3. **Download and Configure the Agent**: Follow the instructions on Azure DevOps to download and configure the self-hosted agent package for your VM.
4. **Start the Agent**: Run the agent in interactive mode or as a service for continuous availability.
5. **Register the Agent**: Connect your self-hosted agent to the Azure DevOps organization for use in your pipelines.

## Usage

After completing the setup, you can use the self-hosted agent in your pipeline YAML file:

```yaml
pool:
  name: 'Self-hosted pool'
  demands:
    - agent.name -equals YourAgentName
