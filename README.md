# GitHub Actions Runner Images
**Table of Contents**
- [About](#about)
- [Available Images](#available-images)
- [Image Definitions](#image-definitions)
- [Image Releases](#image-releases)
- [Software and Image guidelines]
- [How to interact with this Repo]
- [FAQs]


## About
This repository contains the source used to create the [runner images](https://help.github.com/en/actions/reference/virtual-environments-for-github-hosted-runners) for GitHub Actions hosted runners, as well as the VM images of [Microsoft-hosted agents](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/hosted?view=azure-devops#use-a-microsoft-hosted-agent) used for Azure Pipelines. To build a VM machine from this repo's source, see the [instructions](docs/create-image-and-azure-resources.md).

## Available Images
| Image | YAML Label | Included Software | Latest Release & Rollout Progress |
| --------------------|---------------------|--------------------|---------------------|
| Ubuntu 20.04 | `ubuntu-latest` or `ubuntu-20.04` | [ubuntu-20.04] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=ubuntu20&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=ubuntu20&redirect=1)
| Ubuntu 18.04 | `ubuntu-18.04` | [ubuntu-18.04] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=ubuntu18&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=ubuntu18&redirect=1)
| macOS 11 | `macos-latest` or `macos-11`| [macOS-11] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=macos-11&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=macos-11&redirect=1)
| macOS 10.15 | `macos-10.15` | [macOS-10.15] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=macos-10.15&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=macos-10.15&redirect=1)
| Windows Server 2022 | `windows-latest` or `windows-2022` | [windows-2022] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2022&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2022&redirect=1) |
| Windows Server 2019 | `windows-2019` | [windows-2019] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2019&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2019&redirect=1)
| Windows Server 2016 | `windows-2016` | [windows-2016] | [![](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2016&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2016&redirect=1)

[ubuntu-20.04]: https://github.com/actions/virtual-environments/blob/main/images/linux/Ubuntu2004-Readme.md
[ubuntu-18.04]: https://github.com/actions/virtual-environments/blob/main/images/linux/Ubuntu1804-Readme.md
[windows-2022]: https://github.com/actions/virtual-environments/blob/main/images/win/Windows2022-Readme.md
[windows-2019]: https://github.com/actions/virtual-environments/blob/main/images/win/Windows2019-Readme.md
[windows-2016]: https://github.com/actions/virtual-environments/blob/main/images/win/Windows2016-Readme.md
[macOS-11]: https://github.com/actions/virtual-environments/blob/main/images/macos/macos-11-Readme.md
[macOS-10.15]: https://github.com/actions/virtual-environments/blob/main/images/macos/macos-10.15-Readme.md
[self-hosted runners]: https://help.github.com/en/actions/hosting-your-own-runners

## Image Definitions
### Beta:
The purpose of a Beta is to collect feedback on an image before it is released to GA. The goal of a Beta is to identify and fix any potential issues that exist on that image. Images are updated on a weekly cadence. Any workflows that run on a beta image do not fall under the customer [SLA](https://github.com/customer-terms/github-online-services-sla) in place for Actions. Customers choosing to use Beta images are encouraged to provide feedback in the runner-images repo by creating an issue. A Beta may take on different availability, i.e. public vs private.

### GA:
A GA (General Availability) image has been through a Beta period and is deemed ready for general use. Images are updated on a weekly cadence. In order to be moved to GA the image must meet the following criteria: 1- Has been through a Beta period (public or private) 2- Most major software we install on the image has a compatible version for the underlying OS and 3- All major bugs reported during the Beta period have been addressed. This image type falls under the customer [SLA](https://github.com/customer-terms/github-online-services-sla) for actions. GA images are eventually deprecated according to our guidelines as we only support the latest 2 versions of an OS. 

## Image Releases
*How to best follow along with changes*

1. Find the latest releases for this repository [here.](https://github.com/actions/virtual-environments/releases)
2. Subscribe to the releases coming out of this repository, instructions [here.](https://docs.github.com/en/account-and-profile/managing-subscriptions-and-notifications-on-github/setting-up-notifications/configuring-notifications#configuring-your-watch-settings-for-an-individual-repository)
3. Upcoming changes: A pre-release is created when deployment is started. As soon as deployment is finished, it is converted to a release. If you have subscribed to releases, you will get notified of pre-releases as well. 
   - You can also track upcoming changes using the [awaiting-deployment](https://github.com/actions/virtual-environments/labels/awaiting-deployment) label.
4. For high impact changes, we will post these in advance to the GitHub Changelog on our [blog](https://github.blog/changelog/) and on [twitter](https://twitter.com/GHchangelog). 
   - Ex: breaking changes, GA or deprecation of images
5. You can also view notable upcoming changes by viewing the [Announcement](https://github.com/actions/virtual-environments/labels/Announcement) label.

*Cadence*

- We typically deploy weekly updates to the software on the runner images.



## Software and image guidelines
To learn more about tools and images support policy, see the [guidelines](./docs/software-and-images-guidelines.md).

## How to interact with this repo
- To file a bug report, or request tools to be added/updated, please [open an issue using the appropriate template](https://github.com/actions/virtual-environments/issues/new/choose)
- If you want to share your thoughts about image configuration, installed software, or bring some idea, please, create a new topic in a [discussions section](https://github.com/actions/virtual-environments/discussions) for a corresponding category. Before making a new discussion please make sure no similar topics were created earlier.

For general questions about using the runner images or writing your Actions workflow, please open requests in the [GitHub Actions Community Forum](https://github.community/c/github-actions/41).

## FAQs
***What images are available for GitHub Actions and Azure DevOps?***
The availability of images for GitHub Actions and Azure DevOps is different. See documentation for more details:
- [GitHub Actions](https://docs.github.com/en/free-pro-team@latest/actions/reference/specifications-for-github-hosted-runners#supported-runners-and-hardware-resources)
- [Azure DevOps](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/hosted?view=azure-devops&tabs=yaml#software)

***What image version is used in my build?*** Usually, image deployment takes 3-4 days, and documentation in the `main` branch is only updated when deployment is finished. To find out which image version and what software versions are used in a specific build, see `Set up job` (GitHub Actions) or `Initialize job` (Azure DevOps) step log.
<img width="1440" alt="actions-runner-image" src="https://user-images.githubusercontent.com/56982181/169595536-91a8a79b-d5e0-47d1-a736-510cff6cfb83.png">

***Looking for other Linux distributions?*** We do not plan to offer other Linux distributions. We recommend using Docker if you'd like to build using other distributions with the hosted runner images. Alternatively, you can leverage [self-hosted runners] and fully customize your VM image to your needs.

***How do I contribute to the macOS source?*** macOS source lives in this repository and is available for everyone. However, macOS image-generation CI doesn't support external contributions yet so we are not able to accept pull-requests for now.
We are in the process of preparing macOS CI to accept contributions. Until then, we appreciate your patience and ask you to continue to make tool requests by filing issues.

***How do GitHub determine what tools are installed on the images?***
For some tools, we always install the latest at the time of the deployment; for others,
we pin the tool to specific version(s). ( needs more details)
