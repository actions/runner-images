# Contributing

[fork]: https://github.com/actions/runner-images/fork
[pr]: https://github.com//actions/runner-images/compare
[code-of-conduct]: CODE_OF_CONDUCT.md

Hi there! We're thrilled that you'd like to contribute to this project. Your help is essential for keeping it great.

Contributions to this project are [released](https://help.github.com/articles/github-terms-of-service/#6-contributions-under-repository-license) to the public under the [MIT](LICENSE.md) license.

Please note that this project is released with a [Contributor Code of Conduct][code-of-conduct]. By participating in this project, you agree to abide by its terms.

## Submitting a pull request

1. [Fork][fork] and clone the repository.
1. Create a new branch: `git checkout -b my-branch-name`.
1. Make your changes, ensuring that they include steps to install, validate post-install, and update the software report (please see [How to add a new tool](CONTRIBUTING.md#how-to-add-a-new-tool) for details).
1. Test your changes by [creating an image and deploying a VM](docs/create-image-and-azure-resources.md).
1. Push to your fork and [submit a pull request][pr].

Here are a few things you can do that will increase the likelihood of your pull request being accepted:

- Follow the style guide for [Powershell](https://github.com/PoshCode/PowerShellPracticeAndStyle) when writing Windows scripts. There is currently no set style for the Shell scripts that run Linux installs :soon:.
- Include complete details of why this is needed in the PR description.
- Keep your change as focused as possible. If there are multiple changes you would like to make that are not dependent upon each other, consider submitting them as separate pull requests.
- Write [good commit messages](https://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html).
- For new tools:
  - Make sure that the tool satisfies the [Software Guidelines](README.md#software-guidelines).
  - Create an issue and get approval from us to add this tool to the image before creating the pull request.

## How to add a new tool

### General rules

- For every new tool, add validation scripts and update the software report script to ensure that it is included in the documentation.
- If the tool is available on multiple platforms (macOS, Windows, Linux), make sure you include it on as many as possible.
- If installing multiple versions of the tool, consider putting the list of versions in the corresponding `toolset.json` file. This will help other customers configure their builds flexibly. See [toolset-windows-2019.json](images/windows/toolsets/toolset-2019.json) as an example.
- Use consistent naming across all files.
- Validation scripts should be simple and shouldn't change the image content.

### Windows

- Add a script that will install the tool and put the script in the `scripts/build` folder.
There are a bunch of helper functions that could simplify your code: `Install-ChocoPackage`, `Install-Binary`, `Install-VSIXFromFile`, `Install-VSIXFromUrl`, `Invoke-DownloadWithRetry`, `Test-IsWin19`, `Test-IsWin22` (find the full list of helpers in [ImageHelpers.psm1](images/windows/scripts/helpers/ImageHelpers.psm1)).
- Add a script that will validate the tool installation and put the script in the `scripts/tests` folder.
We use [Pester v5](https://github.com/pester/pester) for validation scripts. If the tests for the tool are complex enough, create a separate `*.Tests.ps1`. Otherwise, use `Tools.Tests.ps1` for simple tests.
Add `Invoke-PesterTests -TestFile <testFileName> [-TestName <describeName>]` at the end of the installation script to ensure that your tests will be run.
- Add changes to the software report generator `images/windows/scripts/docs-gen/Generate-SoftwareReport.ps1`. The software report generator is used to generate an image's README file, e.g. [Windows2019-Readme.md](images/windows/Windows2019-Readme.md) and uses [MarkdownPS](https://github.com/Sarafian/MarkdownPS).

### Ubuntu

- Add a script that will install and validate the tool and put the script in the `scripts/build` folder.
Use existing scripts such as [github-cli.sh](images/ubuntu/scripts/build/github-cli.sh) as a starting point.
  - Use [helpers](images/ubuntu/scripts/helpers/install.sh) to simplify the installation process.
  - The validation part should `exit 1` if there is any issue with the installation.
- Add changes to the software report generator `images/ubuntu/scripts/docs-gen/Generate-SoftwareReport.ps1`. The software report generator is used to generate an image's README file, e.g. [Ubuntu2204-Readme.md](images/ubuntu/Ubuntu2204-Readme.md)   and it uses [MarkdownPS](https://github.com/Sarafian/MarkdownPS).

### macOS

The macOS source lives in this repository and is available for everyone. However, the macOS image-generation CI doesn't support external contributions yet, so we are not able to accept pull requests for now.
We are in the process of preparing the macOS CI to accept contributions. Until then, we appreciate your patience and ask that you continue to make tool requests by filing issues.

## Resources

- [How to Contribute to Open Source](https://opensource.guide/how-to-contribute/)
- [Using Pull Requests](https://help.github.com/articles/about-pull-requests/)
- [GitHub Help](https://help.github.com)
