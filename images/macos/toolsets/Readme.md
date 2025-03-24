# Toolset JSON structure

## Xcode

- `versions` - the array of objects that will present installed Xcode versions  
  - `link` property points to the place where Xcode will be located on image. `/Applications/Xcode_<link>.app`  
  - `version` points to Xcode version that will be downloaded and installed
  - `symlinks` describes the list of aliases where symlinks will be created to
  - `install_runtimes` is an array or boolean function to control over the related simulator runtimes, set of possible values: [ `iOS`, `watchOS`, `visionOS`, `tvOS` ], use `true` if you want to install all runtimes, use `false` if you want to skip runtimes installation
  - `sha256` used to check integrity of the Xcode installer file
- `default` - version of Xcode to set as default (should be metched with any `link` in `versions` property)
    **Example:** `"11.2"`  

**Note:**

- `version` is specified with `+` or `-`, exact Xcode name should be like `16.2.0-Beta.3+16C5023f` or `16.2_Release_Candidate+16C5031c` and will be matching `.xip` file name.
- `link` is specified with `_` and doesn't contain spaces, example: `16.2_Release_Candidate` or `16.1`; pattern description:
  - DOWNLOAD_URL="https://download.developer.apple.com/Developer_Tools/$SOURCE_FILE_LOCATION/$SOURCE_FILE_NAME.$FILE_EXTENSION"
  - SOURCE_FILE_NAME: "Xcode_$link"
  - SOURCE_FILE_LOCATION: "Xcode_$link"
  - FILE_EXTENSION: xip

**Example:**

```json
"versions": [
    { "link": "16_beta_4", "version": "16.0.0-Beta.4+16A5211f", "symlinks": ["16.0"], "install_runtimes": "false", "sha256": "4270cd8021b2f7f512ce91bfc4423b25bccab36cdab21834709d798c8daade72"},
    { "link": "15.4", "version": "15.4.0+15F31d", "install_runtimes": "true", "sha256": "82d3d61804ff3f4c7c82085e91dc701037ddaa770e542848b2477e22f4e8aa7a"}
]
```

## Android

- `platform-list` - the array of android platforms to install.  
    **Example:** `[ "android-29", "android-28", "android-27" ]`  

- `build-tools` - the array of android build tools to install.  
    **Example:** `[ "29.0.2", "29.0.1", "29.0.0", "28.0.3" ]`  

- `extras` - the array of android extra items to install.  
    **Example:** `[ "google;google_play_services", "intel;Hardware_Accelerated_Execution_Manager" ]`  

- `addons` - the array of android add-ons to install.  
    **Example:** `[ "addon-google_apis-google-24", "addon-google_apis-google-23" ]`  

## Toolset JSON validation

File `Toolset.Tests.ps1` contains PowerShell [Pester](https://github.com/Pester/Pester) tests that validate JSON toolset files.
Type `Invoke-Pester` in the current folder in PowerShell to run tests.
