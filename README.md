
# GitHub Actions Runner Images - Prebuilt Images in Azure Compute Gallery

![Build Status](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/wiki/azure-way/actions-runner-images/ubuntu-24.04.md?v=1) ![Build Status](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/wiki/azure-way/actions-runner-images/ubuntu-22.04.md) ![Build Status](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/wiki/azure-way/actions-runner-images/ubuntu-20.04.md)

![Build Status](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/wiki/azure-way/actions-runner-images/windows-2022.md)
![Build Status](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/wiki/azure-way/actions-runner-images/windows-2019.md)

This repository demonstrates how to build GitHub Actions Runner Image in the Azure Compute Gallery. Later on, you can use those images to create an Azure DevOps private Agent Pool.

For detailed information about using prebuilt images in your self-hosted agent, refer to the [full guide here](https://azureway.cloud/azure-devops-self-hosted-agent-using-prebuilt-images/).

## Overview

This repository is a fork of [GitHub Actions runner images](https://github.com/actions/runner-images). I've added the Terraform wrapper for Packer; the image definition remains the same as in the fork.

## Features

- Prebuilt agent images to reduce setup complexity
- Customizable pipeline configurations for specific use cases
- Full control over your build and deployment environments
- Cost-effective alternative to Microsoft-hosted agents
