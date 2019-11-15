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
1. Make your changes, ensure that they include steps to install and validate post-install (e.g. [kind.sh](images/linux/scripts/installers/kind.sh)).
1. Test your changes by [creating VHD and deploying a VM](help/CreateImageAndAzureResources.md).
1. Push to your fork and [submit a pull request][pr]

Here are a few things you can do that will increase the likelihood of your pull request being accepted:

- Follow the style guide for [Powershell](https://github.com/PoshCode/PowerShellPracticeAndStyle) when writing Windows scripts. There is currently no set style for the Shell scripts that run Linux installs :soon:.
- Include complete details of why this is needed in the PR description. If it's a new piece tool being installed, consider cross-platform. If the tool is available in other platforms (MacOS, Windows, Linux), make sure you include it in as many as possible.
- Keep your change as focused as possible. If there are multiple changes you would like to make that are not dependent upon each other, consider submitting them as separate pull requests.
- Write [good commit messages](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html).

## Resources

- [How to Contribute to Open Source](https://opensource.guide/how-to-contribute/)
- [Using Pull Requests](https://help.github.com/articles/about-pull-requests/)
- [GitHub Help](https://help.github.com)
