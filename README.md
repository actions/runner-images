# GitHub Actions Runner Images

**Table of Contents**

- [About](#about)
- [Available Images](#available-images)
- [Announcements](#announcements)
- [Image Definitions](#image-definitions)
- [Image Releases](#image-releases)
- [Software and Image Support](#software-and-image-support)
- [How to Interact with the Repo](#how-to-interact-with-the-repo)
- [FAQs](#faqs)

## About

This repository contains the source code used to create the VM images for [GitHub-hosted runners](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners) used for Actions, as well as for [Microsoft-hosted agents](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/hosted?view=azure-devops#use-a-microsoft-hosted-agent) used for Azure Pipelines.
To build a VM machine from this repo's source, see the [instructions](docs/create-image-and-azure-resources.md).

## Available Images

| Image | YAML Label | Included Software | Rollout Status of Latest Image Release |
| --------------------|---------------------|--------------------|--------------------|
| Ubuntu 24.04 | `ubuntu-latest` or `ubuntu-24.04` | [ubuntu-24.04] | ![Endpoint Badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fgist.githubusercontent.com%2Fsubir0071%2F385e39188f4280878bada99250e99db7%2Fraw%2Fubuntu24.json) |
| Ubuntu 22.04 | `ubuntu-22.04` | [ubuntu-22.04] | ![Endpoint Badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fgist.githubusercontent.com%2Fsubir0071%2F385e39188f4280878bada99250e99db7%2Fraw%2Fubuntu22.json) |
| Ubuntu 20.04 | `ubuntu-20.04` | [ubuntu-20.04] | ![Endpoint Badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fgist.githubusercontent.com%2Fsubir0071%2F385e39188f4280878bada99250e99db7%2Fraw%2Fubuntu20.json) |
| macOS 15 <sup>beta</sup> | `macos-15-large`| [macOS-15] | ![Endpoint Badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fgist.githubusercontent.com%2Fsubir0071%2F385e39188f4280878bada99250e99db7%2Fraw%2Fmacos-15.json) |
| macOS 15 Arm64 <sup>beta</sup> | `macos-15` or `macos-15-xlarge` | [macOS-15-arm64] | ![Endpoint Badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fgist.githubusercontent.com%2Fsubir0071%2F385e39188f4280878bada99250e99db7%2Fraw%2Fmacos-15-arm64.json) |
| macOS 14 | `macos-latest-large` or `macos-14-large`| [macOS-14] | ![Endpoint Badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fgist.githubusercontent.com%2Fsubir0071%2F385e39188f4280878bada99250e99db7%2Fraw%2Fmacos-14.json) |
| macOS 14 Arm64 |`macos-latest`, `macos-14`, `macos-latest-xlarge` or `macos-14-xlarge`| [macOS-14-arm64] | ![Endpoint Badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fgist.githubusercontent.com%2Fsubir0071%2F385e39188f4280878bada99250e99db7%2Fraw%2Fmacos-14-arm64.json) |
| macOS 13 | `macos-13` or `macos-13-large` | [macOS-13] | ![Endpoint Badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fgist.githubusercontent.com%2Fsubir0071%2F385e39188f4280878bada99250e99db7%2Fraw%2Fmacos-13.json) |
| macOS 13 Arm64 | `macos-13-xlarge` | [macOS-13-arm64] | ![Endpoint Badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fgist.githubusercontent.com%2Fsubir0071%2F385e39188f4280878bada99250e99db7%2Fraw%2Fmacos-13-arm64.json) |
| macOS 12 <sup>deprecated</sup> | `macos-12` or `macos-12-large`| [macOS-12] | ![Endpoint Badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fgist.githubusercontent.com%2Fsubir0071%2F385e39188f4280878bada99250e99db7%2Fraw%2Fmacos-12.json) |
| Windows Server 2025 <sup>beta</sup> | `windows-2025` | [windows-2025] | ![Endpoint Badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fgist.githubusercontent.com%2Fsubir0071%2F385e39188f4280878bada99250e99db7%2Fraw%2Fwin25.json) |
| Windows Server 2022 | `windows-latest` or `windows-2022` | [windows-2022] | ![Endpoint Badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fgist.githubusercontent.com%2Fsubir0071%2F385e39188f4280878bada99250e99db7%2Fraw%2Fwin22.json) |
| Windows Server 2019 | `windows-2019` | [windows-2019] | ![Endpoint Badge](https://img.shields.io/endpoint?url=https%3A%2F%2Fgist.githubusercontent.com%2Fsubir0071%2F385e39188f4280878bada99250e99db7%2Fraw%2Fwin19.json) |

### Label scheme

- In general the `-latest` label is used for the latest OS image version that is GA
- Before moving the`-latest` label to a new OS version we will announce the change and give sufficient lead time for users to update their workflows

[ubuntu-24.04]: https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2404-Readme.md
[ubuntu-22.04]: https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2204-Readme.md
[ubuntu-20.04]: https://github.com/actions/runner-images/blob/main/images/ubuntu/Ubuntu2004-Readme.md
[windows-2025]: https://github.com/actions/runner-images/blob/main/images/windows/Windows2025-Readme.md
[windows-2022]: https://github.com/actions/runner-images/blob/main/images/windows/Windows2022-Readme.md
[windows-2019]: https://github.com/actions/runner-images/blob/main/images/windows/Windows2019-Readme.md
[macOS-12]: https://github.com/actions/runner-images/blob/main/images/macos/macos-12-Readme.md
[macOS-13]: https://github.com/actions/runner-images/blob/main/images/macos/macos-13-Readme.md
[macOS-13-arm64]: https://github.com/actions/runner-images/blob/main/images/macos/macos-13-arm64-Readme.md
[macOS-14]: https://github.com/actions/runner-images/blob/main/images/macos/macos-14-Readme.md
[macOS-14-arm64]: https://github.com/actions/runner-images/blob/main/images/macos/macos-14-arm64-Readme.md
[macOS-15]: https://github.com/actions/runner-images/blob/main/images/macos/macos-15-Readme.md
[macOS-15-arm64]: https://github.com/actions/runner-images/blob/main/images/macos/macos-15-arm64-Readme.md
[self-hosted runners]: https://help.github.com/en/actions/hosting-your-own-runners

## Announcements

See notable upcoming changes by viewing issues with the [Announcement](https://github.com/actions/runner-images/labels/Announcement) label.

### Ubuntu-latest workflows will use Ubuntu-24.04 image

Rollout will begin on December 5th and will complete on January 17th, 2025.

**Breaking changes**
Ubuntu 24.04 is ready to be the default version for the "ubuntu-latest" label in GitHub Actions and Azure DevOps.

**Target date**
This change will be rolled out over a period of several weeks beginning December 5th and will complete on January 17th, 2025.

**The motivation for the changes**
GitHub Actions and Azure DevOps have supported Ubuntu 24.04 in preview mode since May 2024, and starting from July 2024 Ubuntu 24.04 is generally available for all customers. We have monitored customer feedback to improve the Ubuntu 24.04 image stability and now we are ready to set it as the latest. There are a set of packages listed below that we have removed from the Ubuntu 24 image. Please review the list carefully to see if you will be impacted by these changes. We have made cuts to the list of packages so that we can maintain our SLA for free disk space. The images have grown so large we are in danger of violating our SLA if we keep the package list as-is. 

The factors we took into consideration when removing packages are as follows:
- How long does it take to install the tool at runtime?
- How much space does it take up on the image?
- How many users are there of the tool? 

We understand that our reasoning may not make sense to some of you out there, but please bear in mind that we tried to keep disruptions as minimal as possible, and tried to keep the best interests of the community at large in mind. There is a very large and diverse community using our images, and as much as we would like to, we cannot pre-install every tool on these images.

**Platforms affected**
- [x]  Azure DevOps
- [x]  GitHub Actions

**Mitigation ways**
Steps or options for impact mitigation
If you see any issues with your workflows during transition period:

- Switch back to Ubuntu 22 by changing workflow YAML to use `runs-on: ubuntu-22.04` We support two latest LTS Ubuntu versions, so Ubuntu 22 will still be maintained for the next 2 years.
- File an issue in this repository

**Software Differences**
The Ubuntu 22.04 image has a different set of software than Ubuntu 24.04. The most significant changes are listed in the table below:
| Tool name | Ubuntu 22.04 | Ubuntu 24.04 | Notes |
|-----------|--------------|--------------|-------|
| Clang | <ul><li>13.* </li><li>14.* (default)</li><li>15.* </li></ul> | <ul><li>16.* </li><li>17.* </li><li>18.* (default)</li></ul> | The most recent versions are installed |
| GCC / GNU C++ / GNU Fortran | <ul><li>9.* </li><li>10.* </li><li>11.* </li><li>12.* </li><li>13.* </li></ul> | <ul><li>12.* </li><li>13.* </li><li>14.* </li></ul> | The most recent versions are installed |
| PHP | 8.1.* | 8.3.* | The most recent version are installed |
| Java | <ul><li>8.* </li><li>11.* (default)</li><li>17.* </li><li>21.* </li></ul> | <ul><li>8.* </li><li>11.* </li><li>17.* (default)</li><li>21.* </li></ul> | Default Java switched to 17.* for Ubuntu 24.04 image. |
| Python | <ul><li>3.7.* (cached)</li><li>3.8.* (cached)</li><li>3.9.* (cached)</li><li>3.10.* (default)</li><li>3.11.* (cached)</li><li>3.12.* (cached)</li></ul> | <ul><li>3.9.* (cached)</li><li>3.10.* (cached)</li><li>3.11.* (cached)</li><li>3.12.* (default)</li></ul> | Pre-cached versions currently unavailable. Default version switched to the latest one. On GitHub Actions, [actions/setup-python](https://github.com/actions/setup-python) can install any version on-flight so this change doesn't impact users |
| Go | <ul><li>1.20.* (cached)</li><li>1.21.* (default)</li><li>1.22.* (cached)</li></ul> | <ul><li>1.21.* (cached)</li><li>1.22.* (cached)</li><li>1.23.* (default)</li></ul> | If your use-case requires using any of these versions, consider using tasks to install Go on-flight: <ul><li>[actions/setup-go](https://github.com/actions/setup-go) (GitHub Actions) </li><li>[Go Tool Installer](https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/tool/go-tool?view=azure-devops) (Azure DevOps)</li></ul> |
| PyPy | <ul><li>3.7.* (cached)</li><li>3.8.* (cached)</li><li>3.9.* (cached)</li><li>3.10.* (cached)</li></ul> | <ul><li>3.9.* (cached)</li><li>3.10.* (cached)</li></ul> | Deprecated all the versions besides the most recent ones |
| Ruby | <ul><li>3.0.* (default)</li><li>3.1.* (cached)</li></ul> | <ul><li>3.2.* (default)</li></ul> | We need to update 3.3.5 |
| Node.js | <ul><li>16.* (cached)</li><li>18.* (default)</li><li>20.* (cached)</li></ul> | <ul><li>16.* (cached)</li><li>18.* (cached)</li><li>20.* (default)</li></ul> | If your use-case requires using any of these versions, consider using tasks to install Node.js on-flight: <ul><li>[actions/setup-node](https://github.com/actions/setup-node) (GitHub Actions) </li><li>[Node.js Tool Installer](https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/tool/node-js?view=azure-devops) (Azure DevOps)</li><li> Node 16 will be replaced with Node 22 </li></ul> |
| Heroku | latest available | - | Removed from the Ubuntu 24.04 image due to maintenance reasons. |
| Leiningen | latest available | - | Removed from the Ubuntu 24.04 image due to maintenance reasons. |
| Mono / MSBuild / NuGet | latest available | - | Software is not available for Ubuntu 24 at the moment. |
| Terraform | latest available | - | Removed from the Ubuntu 24.04 image due to maintenance reasons. |
| R | latest available | - | Removed from the Ubuntu 24.04 image due to maintenance reasons. |
| SVN | latest available | - | Removed from the Ubuntu 24.04 image due to maintenance reasons. |
| Alibaba Cloud CLI | latest available | - | Removed from the Ubuntu 24.04 image due to maintenance reasons. |
| Netlify CLI | latest available | - | Removed from the Ubuntu 24.04 image due to maintenance reasons. |
| OpenShift CLI | latest available | - | Removed from the Ubuntu 24.04 image due to maintenance reasons. |
| ORAS CLI | latest available | - | Removed from the Ubuntu 24.04 image due to maintenance reasons. |
| Vercel CLI | latest available | - | Removed from the Ubuntu 24.04 image due to maintenance reasons. |
| Bindgen / Cbindgen | latest available | - | Removed from the Ubuntu 24.04 image due to maintenance reasons. |
| Cargo audit/clippy/outdated | latest available | - | Removed from the Ubuntu 24.04 image due to maintenance reasons. |
| .NET Core SDK | <ul><li>6.* </li><li>7.* </li><li>8.* </li></ul> | <ul><li>8.* </li></ul> | Please consider using tasks to install any version on-flight: <ul><li>[actions/setup-dotnet](https://github.com/actions/setup-dotnet) (GitHub Actions) </li><li>[Use .NET Core](https://docs.microsoft.com/en-us/azure/devops/pipelines/tasks/tool/dotnet-core-tool-installer?view=azure-devops) (Azure DevOps)</li></ul> |
| PostgreSQL | 14.* | 16.* | More recent version are installed |
 MS SQL Server Client Tools | sqlcmd / SqlPackage | - | Removed from the Ubuntu 24.04 image due to maintenance reasons. |
| MarkdownPS Module | latest available | - | Removed from the Ubuntu 24.04 image due to maintenance reasons. |
| Android Command Line Tools | 9.0 | 12.0 | The most recent version are installed |
| Android SDK Build-tools | <ul><li>34.0.0 </li><li>33.0.0 </li><li>33.0.1 </li><li>33.0.2 </li><li>33.0.3 </li><li>32.0.0 </li><li>31.0.0</li></ul> | <ul><li>34.0.0</li></ul> | The most recent version are installed |
| Android NDK | <ul><li>25.* (default)</li><li>26.* </li></ul> | <ul><li>27.* (default)</li><li>26.* </li></ul> | The most recent version are installed |
| Cached Docker images | <ul><li>alpine:3.16</li><li>alpine:3.17</li><li>alpine:3.18</li><li>debian:10</li><li>debian:11</li><li>moby/buildkit:latest</li><li>node:16</li><li>node:16-alpine</li><li>node:18</li><li>node:18-alpine</li><li>node:20</li><li>node:20-alpine</li><li>ubuntu:20.04</li><li>ubuntu:22.04</li></ul> | - | Removed from the Ubuntu 24.04 image due to maintenance reasons. |

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

#### Latest Migration Process

GitHub Actions and Azure DevOps use the `-latest` YAML label (ex: `ubuntu-latest`, `windows-latest`, and `macos-latest`). These labels point towards the newest stable OS version available.


The `-latest` migration process is gradual and happens over 1-2 months in order to allow customers to adapt their workflows to the newest OS version. During this process, any workflow using the `-latest` label, may see changes in the OS version in their workflows or pipelines. To avoid unwanted migration, users can specify a specific OS version in the yaml file (ex: macos-14, windows-2022, ubuntu-22.04).

## Image Releases

*How to best follow along with changes*

1. Find the latest releases for this repository [here.](https://github.com/actions/runner-images/releases)
2. Subscribe to the releases coming out of this repository, instructions [here.](https://docs.github.com/en/account-and-profile/managing-subscriptions-and-notifications-on-github/setting-up-notifications/configuring-notifications#configuring-your-watch-settings-for-an-individual-repository)
3. Upcoming changes: A pre-release is created when the deployment of an image has started. As soon as the deployment is finished, the pre-release is converted to a release. If you have subscribed to releases, you will get notified of pre-releases as well.

   - You can also track upcoming changes using the [awaiting-deployment](https://github.com/actions/runner-images/labels/awaiting-deployment) label.
4. For high impact changes, we will post these in advance to the GitHub Changelog on our [blog](https://github.blog/changelog/) and on [twitter](https://twitter.com/GHchangelog).
   - Ex: breaking changes, GA or deprecation of images

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
| Xcode     | - only one major version of Xcode will be supported per macOS version <br/> - all minor versions of the supported major version will be available <br/> - beta and RC versions will be provided "as-is" in the latest available macOS image only no matter of beta/GA status of the image <br/> - when a new patch version is released, the previous patch version will be replaced |

### Package managers usage

We use third-party package managers to install software during the image generation process. The table below lists the package managers and the software installed.
> [!NOTE]
> Third-party repositories are re-evaluated every year to identify if they are still useful and secure.

| Operating system | Package manager                       | Third-party repos and packages |
| :---             |        :---:                          |                           ---: |
| Ubuntu           | [APT](https://wiki.debian.org/Apt)    | [containers](https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable) (Ubuntu 20 only) <br/> [docker](https://download.docker.com/linux/ubuntu) (Ubuntu20 0nly) <br/> [Eclipse-Temurin (Adoptium)](https://packages.adoptium.net/artifactory/deb/) <br/> [Erlang](https://packages.erlang-solutions.com/ubuntu) <br/> [Firefox](http://ppa.launchpad.net/mozillateam/ppa/ubuntu) <br/> [git-lfs](https://packagecloud.io/install/repositories/github/git-lfs) <br/> [git](https://launchpad.net/~git-core/+archive/ubuntu/ppa) <br/> [Google Cloud CLI](https://packages.cloud.google.com/apt) <br/> [Heroku](https://cli-assets.heroku.com/channels/stable/apt) <br/> [HHvm](https://dl.hhvm.com/ubuntu) <br/> [MongoDB](https://repo.mongodb.org/apt/ubuntu) <br/> [Mono](https://download.mono-project.com/repo/ubuntu) <br/> [MS Edge](https://packages.microsoft.com/repos/edge) <br/> [PostgreSQL](https://apt.postgresql.org/pub/repos/apt/) <br/> [R](https://cloud.r-project.org/bin/linux/ubuntu)                                      |
|                  | [pipx](https://pypa.github.io/pipx)   | ansible-core <br/>yamllint     |
| Windows          | [Chocolatey](https://chocolatey.org)  | No third-party repos installed |
| macOS            | [Homebrew](https://brew.sh)           | [aws-cli v2](https://github.com/aws/homebrew-tap) </br> [azure/bicep](https://github.com/Azure/homebrew-bicep) </br> [mongodb/brew](https://github.com/mongodb/homebrew-brew)                                                  |
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
<img width="1440" alt="actions-runner-image" src="https://github.com/actions/runner-images/assets/88318005/922a8bf5-3e4d-4265-9527-b3b51e6bf9c8">
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

<details>
   <summary><b><i>What branch should I use to build custom image?</b></i></summary>
We strongly encourage customers to build their own images using the main branch.
This repository contains multiple branches and releases that serve as document milestones to reflect what software is installed in the images at certain point of time. Current builds are not idempotent and if one tries to build a runner image using the specific tag it is not guaranteed that the build will succeed.
</details>
