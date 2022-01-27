# GitHub Actions Virtual Environments
This repository contains the source used to create the [virtual environments](https://help.github.com/en/actions/reference/virtual-environments-for-github-hosted-runners) for GitHub Actions hosted runners, as well as the VM images of [Microsoft-hosted agents](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/hosted?view=azure-devops#use-a-microsoft-hosted-agent) used for Azure Pipelines. To build a VM machine from this repo's source, see the [instructions](docs/create-image-and-azure-resources.md).

How to get in touch with us:
- To file a bug report, or request tools to be added/updated, please [open an issue using the appropriate template](https://github.com/actions/virtual-environments/issues/new/choose)
- If you want to share your thoughts about image configuration, installed software, or bring some idea, please, create a new topic in a [discussions section](https://github.com/actions/virtual-environments/discussions) for a corresponding category. Before making a new discussion please make sure no similar topics were created earlier.

For general questions about using the virtual environments or writing your Actions workflow, please open requests in the [GitHub Actions Community Forum](https://github.community/c/github-actions/41).

## Available Environments
| Environment | YAML Label | Included Software | Latest Release & Rollout Progress |
| --------------------|---------------------|--------------------|---------------------|
| Ubuntu 20.04 | `ubuntu-latest` or `ubuntu-20.04` | [ubuntu-20.04] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=ubuntu20&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=ubuntu20&redirect=1)
| Ubuntu 18.04 | `ubuntu-18.04` | [ubuntu-18.04] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=ubuntu18&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=ubuntu18&redirect=1)
| macOS 11 | `macos-latest` or `macos-11`| [macOS-11] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=macos-11&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=macos-11&redirect=1)
| macOS 10.15 | `macos-10.15` | [macOS-10.15] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=macos-10.15&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=macos-10.15&redirect=1)
| Windows Server 2022 | `windows-2022` | [windows-2022] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2022&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2022&redirect=1) |
| Windows Server 2019 | `windows-latest` or `windows-2019` | [windows-2019] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2019&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2019&redirect=1)
| Windows Server 2016 | `windows-2016` | [windows-2016] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2016&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2016&redirect=1)

<b>Note:</b> Beta and Preview images are provided "as-is", "with all faults" and "as available" and are excluded from the service level agreement and warranty. Beta and Preview images may not be covered by customer support.

***What images are available for GitHub Actions and Azure DevOps?***
The availability of images for GitHub Actions and Azure DevOps is different. See documentation for more details:
- [GitHub Actions](https://docs.github.com/en/free-pro-team@latest/actions/reference/specifications-for-github-hosted-runners#supported-runners-and-hardware-resources)
- [Azure DevOps](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/hosted?view=azure-devops&tabs=yaml#software)

***What image version is used in my build?*** Usually, image deployment takes 3-4 days, and documentation in the `main` branch is only updated when deployment is finished. To find out which image version and what software versions are used in a specific build, see `Set up job` (GitHub Actions) or `Initialize job` (Azure DevOps) step log.

***Looking for other Linux distributions?*** We do not plan to offer other Linux distributions. We recommend using Docker if you'd like to build using other distributions with the hosted virtual environments. Alternatively, you can leverage [self-hosted runners] and fully customize your environment to your needs.

***How to contribute to macOS source?*** macOS source lives in this repository and available for everyone. However, MacOS image-generation CI doesn't support external contributions yet so we are not able to accept pull-requests for now.
We are in the process of preparing MacOS CI to accept contributions. Until then, we appreciate your patience and ask you continue to make tool requests by filing issues.

## Updates to virtual environments
*Cadence*

We typically deploy weekly updates to the software on the virtual environments.
For some tools, we always install the latest at the time of the deployment; for others,
we pin the tool to specific version(s).

*Following Along / Change Notifications*

* **High Impact Changes** (ex. breaking changes, new or deprecated environments) will be posted to the GitHub Changelog on our [blog](https://github.blog/changelog/) and on [twitter](https://twitter.com/GHchangelog).
* **Low Impact Changes** will be pinned in this repository and marked with the [Announcement](https://github.com/actions/virtual-environments/labels/Announcement) label.
* **Regular Weekly Rhythm** can be followed by watching [Releases](https://github.com/actions/virtual-environments/releases). Pre-release is created when deployment is started. As soon as deployment is finished, it is converted to release.
You can also track upcoming changes using the [awaiting-deployment](https://github.com/actions/virtual-environments/labels/awaiting-deployment) label.

[ubuntu-20.04]: https://github.com/actions/virtual-environments/blob/main/images/linux/Ubuntu2004-Readme.md
[ubuntu-18.04]: https://github.com/actions/virtual-environments/blob/main/images/linux/Ubuntu1804-Readme.md
[windows-2022]: https://github.com/actions/virtual-environments/blob/main/images/win/Windows2022-Readme.md
[windows-2019]: https://github.com/actions/virtual-environments/blob/main/images/win/Windows2019-Readme.md
[windows-2016]: https://github.com/actions/virtual-environments/blob/main/images/win/Windows2016-Readme.md
[macOS-11]: https://github.com/actions/virtual-environments/blob/main/images/macos/macos-11-Readme.md
[macOS-10.15]: https://github.com/actions/virtual-environments/blob/main/images/macos/macos-10.15-Readme.md
[self-hosted runners]: https://help.github.com/en/actions/hosting-your-own-runners

## Software and image guidelines
To learn more about tools and images support policy, see the [guidelines](./docs/software-and-images-guidelines.md).
