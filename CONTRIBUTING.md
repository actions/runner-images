## Contributing

[fork]: https://github.com/actions/virtual-environments/fork
[pr]: https://github.com//actions/virtual-environments/compare
[code-of-conduct]: CODE_OF_CONDUCT.md

Hi there! We're thrilled that you'd like to contribute to this project. Your help is essential for keeping it great.

Contributions to this project are [released](https://help.github.com/articles/github-terms-of-service/#6-contributions-under-repository-license) to the public under the [MIT](LICENSE.md).

Please note that this project is released with a [Contributor Code of Conduct][code-of-conduct]. By participating in this project you agree to abide by its terms.

## Submitting a pull request

1. [Fork][fork] and clone the repository
1. Create a new branch: `git checkout -b my-branch-name`
1. Make your changes, ensure that they include steps to install, validate post-install and update software report (please see [How to add new tool](CONTRIBUTING.md#how-to-add-new-tool) for details).
1. Test your changes by [creating VHD and deploying a VM](help/CreateImageAndAzureResources.md).
1. Push to your fork and [submit a pull request][pr]

Here are a few things you can do that will increase the likelihood of your pull request being accepted:

- Follow the style guide for [Powershell](https://github.com/PoshCode/PowerShellPracticeAndStyle) when writing Windows scripts. There is currently no set style for the Shell scripts that run Linux installs :soon:.
- Include complete details of why this is needed in the PR description. 
- Keep your change as focused as possible. If there are multiple changes you would like to make that are not dependent upon each other, consider submitting them as separate pull requests.
- Write [good commit messages](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html).
- For new tools:
  - Make sure that the tool satisfies [Software Guidelines](README.md#software-guidelines).
  - Create an issue and get an approval from us to add this tool to the image before creating the pull request.

## How to add new tool
### General rules
- For every new tool add validation scripts and update software report script to make sure that it is included to documentation
- If the tool is available in other platforms (MacOS, Windows, Linux), make sure you include it in as many as possible.
- If tools installation includes a few versions, consider putting the list of versions to `toolset.json` file. It will help other customers to configure their builds flexibly. See [toolset-windows-2016.json](images/win/toolsets/toolset-2019.json) as example.
- Use consistent naming across all files
- Validation scripts should be simple and shouldn't change image content

### Windows
- Add script that will install tool and put it to `scripts/Installers` folder.  
There are a bunch of helper functions that could simplify your code: `Choco-Install`, `Install-Binary`, `Install-VsixExtension`, ` Start-DownloadWithRetry`, `Test-IsWin16`, ` Test-IsWin19` (Find the full list of helpers in [ImageHelpers.psm1](images/win/scripts/ImageHelpers/ImageHelpers.psm1)).
- Add script that will validate tool installation and put it to `scripts/Tests` folder.  
We use [Pester v5](https://github.com/pester/pester) for validation scripts. Create the separate `*.Tests.ps1` file in case if tool requires complex tests or use `Tools.Tests.ps1` for simple tests.  
Run your test by adding `Invoke-PesterTests -TestFile <testFileName> [-TestName <describeName>]` at the end of installation script to make sure that your tests will be run.
- Add changes to document tool name and version to the software report generator `images/win/scripts/SoftwareReport/SoftwareReport.Generator.ps1` that is used to generate software README file, e.g. [Windows2019-Readme.md](images/win/Windows2019-Readme.md). We use [MarkdownPS](https://github.com/Sarafian/MarkdownPS) to build documentation for image.

### Ubuntu
- Add script that will install tool, validate it and document and put it to `script/Installers` (Currently, the single file is used on Ubuntu images).
  - Use [helpers](images/linux/scripts/helpers/install.sh) to simplify installation process.
  - Validation part should `exit 1` if any issue with installation.
  - Use `DocumentInstalledItem "<add to docs>"` helper for building documentation.

### macOS
We are in the process of preparing our macOS source to live in this repo so we can take contributions from the community. Until then, we appreciate your patience and ask you continue to make tool requests by filing issues.

## Resources

- [How to Contribute to Open Source](https://opensource.guide/how-to-contribute/)
- [Using Pull Requests](https://help.github.com/articles/about-pull-requests/)
- [GitHub Help](https://help.github.com)
