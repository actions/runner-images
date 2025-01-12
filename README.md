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

#### Breaking changes
Ubuntu 24.04 is ready to be the default version for the "ubuntu-latest" label in GitHub Actions and Azure DevOps.

#### Target date
This change will be rolled out over a period of several weeks beginning December 5th and will complete on January 17th, 2025.

#### The motivation for the changes
GitHub Actions and Azure DevOps have supported Ubuntu 24.04 in preview mode since May 2024, and starting from July 2024 Ubuntu 24.04 is generally available for all customers. We have monitored customer feedback to improve the Ubuntu 24.04 image stability and now we are ready to set it as the latest. There are a set of packages listed below that we have removed from the Ubuntu 24 image. Please review the list carefully to see if you will be impacted by these changes. We have made cuts to the list of packages so that we can maintain our SLA for free disk space. The images have grown so large we are in danger of violating our SLA if we keep the package list as-is. 

The factors we took into consideration when removing packages are as follows:
- How long does it take to install the tool at runtime?
- How much space does it take up on the image?
- How many users are there of the tool? 

We understand that our reasoning may not make sense to some of you out there, but please bear in mind that we tried to keep disruptions as minimal as possible, and tried to keep the best interests of the community at large in mind. There is a very large and diverse community using our images, and as much as we would like to, we cannot pre-install every tool on these images.

#### Platforms affected
- [x]  Azure DevOps
- [x]  GitHub Actions

#### Mitigation ways
Steps or options for impact mitigation
If you see any issues with your workflows during transition period:

- Switch back to Ubuntu 22 by changing workflow YAML to use `runs-on: ubuntu-22.04` We support two latest LTS Ubuntu versions, so Ubuntu 22 will still be maintained for the next 2 years.
- File an issue in this repository

#### Software Differences
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
