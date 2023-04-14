
# GitHub Actions Runner Images

**Table of Contents**

- [About](#about)
- [Available Images](#available-images)
- [Ongoing migrations](#ongoing-migrations)
- [Image Definitions](#image-definitions)
- [Image Releases](#image-releases)
- [Software and Image Support](#software-and-image-support)
- [How to Interact with the Repo](#how-to-interact-with-the-repo)
- [FAQs](#faqs)

## About

This repository contains the source code used to create the VM images for [GitHub-hosted runners](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners) used for Actions, as well as for [Microsoft-hosted agents](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/hosted?view=azure-devops#use-a-microsoft-hosted-agent) used for Azure Pipelines.
To build a VM machine from this repo's source, see the [instructions](docs/create-image-and-azure-resources.md).

## Available Images

| Image | YAML Label | Included Software | Rollout Progress of Latest Image Release |
| --------------------|---------------------|--------------------|---------------------|
| Ubuntu 22.04 | `ubuntu-latest` or `ubuntu-22.04` | [ubuntu-22.04] | [![status22](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=ubuntu22&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=ubuntu22&redirect=1)
| Ubuntu 20.04 | `ubuntu-20.04` | [ubuntu-20.04] | [![status20](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=ubuntu20&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=ubuntu20&redirect=1)
| macOS 12 | `macos-latest` or `macos-12`| [macOS-12] | [![statusumac12](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=macos-12&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=macos-12&redirect=1)
| macOS 11 | `macos-11`| [macOS-11] | [![statusmac11](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=macos-11&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=macos-11&redirect=1)
| macOS 10.15 <sup>deprecated</sup> | `macos-10.15` | [macOS-10.15] | [![statusmac10](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=macos-10.15&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=macos-10.15&redirect=1)
| Windows Server 2022 | `windows-latest` or `windows-2022` | [windows-2022] | [![statuswin22](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2022&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2022&redirect=1) |
| Windows Server 2019 | `windows-2019` | [windows-2019] | [![statuswin19](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2019&badge=1)](https://actionvirtualenvironmentsstatus.azurewebsites.net/api/status?imageName=windows-2019&redirect=1)

### Label scheme

- In general the `-latest` label is used for the latest OS image version that is GA
- Before moving the`-latest` label to a new OS version we will announce the change and give sufficient lead time for users to update their workflows

[ubuntu-22.04]: https://github.com/actions/runner-images/blob/main/images/linux/Ubuntu2204-Readme.md
[ubuntu-20.04]: https://github.com/actions/runner-images/blob/main/images/linux/Ubuntu2004-Readme.md
[windows-2022]: https://github.com/actions/runner-images/blob/main/images/win/Windows2022-Readme.md
[windows-2019]: https://github.com/actions/runner-images/blob/main/images/win/Windows2019-Readme.md
[macOS-11]: https://github.com/actions/runner-images/blob/main/images/macos/macos-11-Readme.md
[macOS-12]: https://github.com/actions/runner-images/blob/main/images/macos/macos-12-Readme.md
[macOS-10.15]: https://github.com/actions/runner-images/blob/main/images/macos/macos-10.15-Readme.md
[self-hosted runners]: https://help.github.com/en/actions/hosting-your-own-runners

## Ongoing migrations

There are no migrations in progress.

## Image Definitions

### Beta

The purpose of a Beta is to collect feedback on an image before it is released to GA. The goal of a Beta is to identify and fix any potential issues that exist on that
image. Images are updated on a weekly cadence. Any workflows that run on a beta image do not fall under the customer [SLA](https://github.com/customer-terms/github-online-services-sla) in place for Actions.
Customers choosing to use Beta images are encouraged to provide feedback in the runner-images repo by creating an issue. A Beta may take on different availability, i.e. public vs private.

### GA

A GA (General Availability) image has been through a Beta period and is deemed ready for general use. Images are updated on a weekly cadence. In order to be moved to
GA the image must meet the following criteria:

1. Has been through a Beta period (public or private)
2. Most major software we install on the image has a compatible
version for the underlying OS and
3. All major bugs reported during the Beta period have been addressed.

This image type falls under the customer [SLA](https://github.com/customer-terms/github-online-services-sla) for actions. GA images are eventually deprecated according to our guidelines as we only support the
latest 2 versions of an OS.

## Image Releases

*How to best follow along with changes*

1. Find the latest releases for this repository [here.](https://github.com/actions/runner-images/releases)
2. Subscribe to the releases coming out of this repository, instructions [here.](https://docs.github.com/en/account-and-profile/managing-subscriptions-and-notifications-on-github/setting-up-notifications/configuring-notifications#configuring-your-watch-settings-for-an-individual-repository)
3. Upcoming changes: A pre-release is created when the deployment of an image has started. As soon as the deployment is finished, the pre-release is converted to a release. If you have subscribed to releases, you will get notified of pre-releases as well.

   - You can also track upcoming changes using the [awaiting-deployment](https://github.com/actions/runner-images/labels/awaiting-deployment) label.
4. For high impact changes, we will post these in advance to the GitHub Changelog on our [blog](https://github.blog/changelog/) and on [twitter](https://twitter.com/GHchangelog).
   - Ex: breaking changes, GA or deprecation of images
5. You can also view notable upcoming changes by viewing the [Announcement](https://github.com/actions/runner-images/labels/Announcement) label.

*Cadence*

- We typically deploy weekly updates to the software on the runner images.

## Software and Image Support

### Support Policy

- Tools and versions will typically be removed 6 months after they are deprecated or have reached end-of-life
- We support (at maximum) 2 GA images and 1 beta image at a time. We begin the deprecation process of the oldest image label once the newest OS image label has been released to GA.
- The images generally contain the latest versions of packages installed except for Ubuntu LTS where we mostly rely on the Canonical-provided repositories.

- Popular tools can have several versions installed side-by-side with the following strategy:

| Tool name | Installation strategy |
|-----------|-----------------------|
| Docker images | not more than 3 latest LTS OS\tool versions. New images or new versions of current images are added using the standard tool request process |
| Java      | all LTS versions |
| Node.js   | 3 latest LTS versions |
| Go        | 3 latest minor versions |
| Python <br/> Ruby | 5 most popular `major.minor` versions |
| PyPy      | 3 most popular `major.minor` versions |
| .NET Core | 2 latest LTS versions and 1 latest version. For each feature version only latest patch is installed |
| GCC <br/> GNU Fortran <br/> Clang <br/> GNU C++ | 3 latest major versions |
| Android NDK | 1 latest non-LTS, 2 latest LTS versions |
| Xcode     | - all OS compatible versions side-by-side <br/> - for beta, GM versions - latest beta only <br/> - old patch versions are deprecated in 3 months |

### Package managers usage

We use third-party package managers to install software during the image generation process. The table below lists the package managers and the software installed.
> **Note**: third-party repositories are re-evaluated every year to identify if they are still useful and secure.


| Operating system | Package manager                       | Third-party repos and packages |
| :---             |        :---:                          |                           ---: |
| Ubuntu           | [APT](https://wiki.debian.org/Apt)    | [Eclipse-Temurin (Adoptium)](https://packages.adoptium.net/artifactory/deb) </br> [Erlang](https://packages.erlang-solutions.com/ubuntu) </br>[Firefox](https://launchpad.net/~mozillateam/+archive/ubuntu/ppa) </br> [gcc, gfortran](https://launchpad.net/~ubuntu-toolchain-r/+archive/ubuntu/test)  </br> [git](https://launchpad.net/~git-core/+archive/ubuntu/ppa) </br> [HHvm](https://dl.hhvm.com/ubuntu) </br> [PHP](https://launchpad.net/~ondrej/+archive/ubuntu/php) (Ubuntu 20 only) </br> [Mono](https://download.mono-project.com/repo/ubuntu) </br> [PostgreSQL](https://apt.postgresql.org/pub/repos/apt) </br> [R](https://cloud.r-project.org/bin/linux/ubuntu)                                     |
|                  | [pipx](https://pypa.github.io/pipx)   | ansible-core </br>yamllint     |
| Windows          | [Chocolatey](https://chocolatey.org)  | No third-party repos installed |
| macOS            | [Homebrew](https://homebrew.sh)       | [aws-cli v2](https://github.com/aws/homebrew-tap) </br> [azure/bicep](https://github.com/Azure/homebrew-bicep) </br> [mongodb/brew](https://github.com/mongodb/homebrew-brew)                                                  |
|                  | [pipx](https://pypa.github.io/pipx/)  | yamllint                       |


### Image Deprecation Policy

- Images begin the deprecation process of the oldest image label once a new GA OS version has been released.
- Deprecation process begins with an announcement that sets a date for deprecation
- As it gets closer to the date, GitHub begins doing scheduled brownouts of the image
- During this time there will be an Announcement pinned in the repo to remind users of the deprecation.
- Finally GitHub will deprecate the image and it will no longer be available

### Preinstallation Policy

In general, these are the guidelines we follow when deciding what to pre-install on our images:

- Popularity: widely-used tools and ecosystems will be given priority.
- Latest Technology: recent versions of tools will be given priority.
- Deprecation: end-of-life tools and versions will not be added.
- Licensing: MIT, Apache, or GNU licenses are allowed.
- Time & Space on the Image: we will evaluate how much time is saved and how much space is used by having the tool pre-installed.
- Support: If a tool requires the support of more than one version, we will consider the cost of this maintenance.

### Default Version Update Policy

- In general, once a new version is installed on the image, we announce the default version update 2 weeks prior to deploying it.
- For potentially dangerous updates, we may extend the timeline up to 1 month between the announcement and deployment.

## How to Interact with the Repo

- **Issues**: To file a bug report, or request tools to be added/updated, please [open an issue using the appropriate template](https://github.com/actions/runner-images/issues/new/choose)
- **Discussions**: If you want to share your thoughts about image configuration, installed software, or bring a new idea, please create a new topic in a [discussion](https://github.com/actions/runner-images/discussions) for a corresponding category. Before making a new discussion please make sure no similar topics were created earlier.
- For general questions about using the runner images or writing your Actions workflow, please open requests in the [GitHub Actions Community Forum](https://github.community/c/github-actions/41).

## FAQs

<details>
   <summary><b><i>What images are available for GitHub Actions and Azure DevOps?</b></i></summary>

The availability of images for GitHub Actions and Azure DevOps is the same. However, deprecation policies may differ. See documentation for more details:
- [GitHub Actions](https://docs.github.com/en/free-pro-team@latest/actions/reference/specifications-for-github-hosted-runners#supported-runners-and-hardware-resources)
- [Azure DevOps](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/hosted?view=azure-devops&tabs=yaml#software)
</details>

<details>
   <summary><b><i>What image version is used in my build?</b></i></summary>

Usually, image deployment takes 2-3 days, and documentation in the `main` branch is only updated when deployment is finished. To find out which image version and what software versions are used in a specific build, see `Set up job` (GitHub Actions) or `Initialize job` (Azure DevOps) step log.
<img width="1440" alt="actions-runner-image" src="https://user-images.githubusercontent.com/56982181/169595536-91a8a79b-d5e0-47d1-a736-510cff6cfb83.png">
</details>

<details>
   <summary><b><i>Looking for other Linux distributions?</b></i></summary>

We do not plan to offer other Linux distributions. We recommend using Docker if you'd like to build using other distributions with the hosted runner images. Alternatively, you can leverage [self-hosted runners] and fully customize your VM image to your needs.
</details>

<details>
   <summary><b><i>How do I contribute to the macOS source?</b></i></summary>

macOS source lives in this repository and is available for everyone. However, macOS image-generation CI doesn't support external contributions yet so we are not able to accept pull-requests for now.

We are in the process of preparing macOS CI to accept contributions. Until then, we appreciate your patience and ask you to continue to make tool requests by filing issues.
</details>

<details>
   <summary><b><i>How does GitHub determine what tools are installed on the images?</b></i></summary>

For some tools, we always install the latest at the time of the deployment; for others, we pin the tool to specific version(s). For more details please see the [Preinstallation Policy](#preinstallation-policy)
</details>

<details>
   <summary><b><i>How do I request that a new tool be pre-installed on the image?</b></i></summary>
Please create an issue and get an approval from us to add this tool to the image before creating the pull request.
</details>
