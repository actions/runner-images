# Ubuntu Minimal
- OS Version: 22.04.5 LTS
- Kernel Version: 6.5.0-1025-azure
- Image Version: 20241215.1.0
- Systemd version: 249.11-0ubuntu3.12

## Description

The `UbuntuMinimal` image is a lightweight version of the Ubuntu image, designed to provide a minimal environment with only the essential software installed. This image is ideal for users who want a clean and minimal setup, with the flexibility to install only the software they need.

## Installed Software

### Language and Runtime
- Bash 5.1.16(1)-release
- Dash 0.5.11+git20210903+057cd650a4ed-3build1
- GNU C++: 10.5.0, 11.4.0, 12.3.0
- GNU Fortran: 10.5.0, 11.4.0, 12.3.0
- Python 3.10.12

### Package Management
- apt 2.4.9
- dpkg 1.21.1ubuntu2.3

### Tools
- Git 2.47.1
- curl 7.81.0-1ubuntu1.19
- wget 1.21.2-2ubuntu1.1

### CLI Tools
- jq 1.6
- unzip 6.0-26ubuntu3.2
- zip 3.0-12build2

### Environment variables
| Name                    | Value                  |
| ----------------------- | ---------------------- |
| PATH                    | /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin |

## Post-generation Scripts

The following post-generation scripts are executed to configure the `UbuntuMinimal` image:

- `cleanup-logs.sh`: Cleans up log files to reduce the image size.
- `environment-variables.sh`: Configures environment variables for the default user.
- `systemd-linger.sh`: Enables user session on boot, not on login.

## Repository Investigation

The repository has been investigated to understand its structure, main steps for creating VM images, available image types, customization options, troubleshooting, automation, environment variables, network security, resource group management, adding new tools, and security considerations.

### Repository Structure

- The repository includes various configuration files such as `.gitattributes`, `.gitignore`, and `.vscode` settings.
- The `.github` directory contains GitHub-specific configurations, including issue templates, workflows, and a code owners file.
- The `README.md` file provides an overview of the repository, available images, announcements, image definitions, and support policies.
- The `docs/create-image-and-azure-resources.md` file contains detailed instructions for creating VM images, including build agent preparation, manual and automated image generation, and post-generation scripts.
- The `helpers/GenerateResourcesAndImage.ps1` script includes functions for generating Azure resources and images, with support for various image types.
- The `helpers/CreateAzureVMFromPackerTemplate.ps1` script provides a function to create a VM from a generated image.
- Packer templates for different operating systems are located in the `images/ubuntu/templates` and `images/windows/templates` directories.
- The `CONTRIBUTING.md` file provides guidelines for contributing to the project, including how to submit a pull request and add new tools.
- The `SECURITY.md` file outlines the security policies and procedures for the repository.
- The `images/ubuntu/assets/post-gen/cleanup-logs.sh` script removes all build process logs from the machine.
