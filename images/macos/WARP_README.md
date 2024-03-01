## WarpBuild fork of GitHub's official runner images

The changes from upstream MacOS image are as follows. Please keep these in mind while updating the repo from upstream.

### MacOS

- The main difference is GH uses Veertu and we use Tart. That's why only the `macOS-*.arm64.tart.*.hcl` files are relevant to us. The anka files are from upstream and aren't being used.
- The [`isVeertu` powershell helper](/images/macos/scripts/helpers/Common.Helpers.psm1#L107-L109) and the [`is_veertu` bash helper](/images/macos/scripts/helpers/utils.sh#L80-L83) have been changed to check for Tart environment as well.
- The `build` section of the `macOS-*.arm64.tart.pkr.hcl` is almost the same as that of the build section of the `anka` ones but with extra two Tart specific steps prepended and the second last step omitted. Please refer to anyone of [`macOS-13.arm64.tart.pkr.hcl`](/images/macos/templates/macOS-13.arm64.tart.pkr.hcl) or [`macOS-14.arm64.tart.pkr.hcl`](/images/macos/templates/macOS-14.arm64.tart.pkr.hcl) while creating a new one.
- The toolsets versions in [`toolsets/toolset-*.json`](/images/macos/toolsets) for `arm64` have a subtle yet important distinction. The versions are of format `15.2.0-15C500b` as compared to the upstream format of `15.2.0+15C500b`. Please ensure hyphens instead of plus signs after an upstream pull.
