# Toolset JSON structure

## Xcode

- `versions` - the array of objects that will present installed Xcode versions  
  - `link` property points to the place where Xcode will be located on image. `/Applications/Xcode_<link>.app`  
  - `version` points to Xcode version that will be downloaded and installed
  - `symlinks` describes the list of aliases where symlinks will be created to
  - `sha256` used to check integrity of the Xcode installer file
  - `install_runtimes` – controls the installation of simulator runtimes:
    - `default` – installs all default runtimes.
    - `none` – skips runtime installation.
    - **Hashtable** – allows manual selection:
      - Mandatory keys: `[ "iOS", "watchOS", "tvOS" ]`, plus `visionOS` for arm64 images.
      - Values [array of string]:  
        - `"default"` – installs the default runtime.  
        - `"skip"` – skips installation.  
        - Specific version numbers, e.g., `"18.2"`, `"2.2"`, `"18.3.1"`.
        - Apple release version, e.g., `"22E5216h"`, `"17A577"`.

- `default` - version of Xcode to set as default (should be matched with any `link` in `versions` property)
    **Example:** `"11.2"`  

**Note:**

- `version` is specified with `+` or `-`, exact Xcode name should be like `16.2.0-Beta.3+16C5023f` or `16.2_Release_Candidate+16C5031c` and will be matching `.xip` file name.
- `link` is specified with `_` and doesn't contain spaces, example: `16.2_Release_Candidate` or `16.1`; pattern description:
  - DOWNLOAD_URL="https://download.developer.apple.com/Developer_Tools/$SOURCE_FILE_LOCATION/$SOURCE_FILE_NAME.$FILE_EXTENSION"
  - SOURCE_FILE_NAME: "Xcode_$link"
  - SOURCE_FILE_LOCATION: "Xcode_$link"
  - FILE_EXTENSION: xip

**Example:**

String format:

```json
"versions": [
    { "link": "16_beta_4", "version": "16.0.0-Beta.4+16A5211f", "symlinks": ["16.0"], "install_runtimes": "none", "sha256": "4270cd8021b2f7f512ce91bfc4423b25bccab36cdab21834709d798c8daade72"},
    { "link": "15.4", "version": "15.4.0+15F31d", "install_runtimes": "default", "sha256": "82d3d61804ff3f4c7c82085e91dc701037ddaa770e542848b2477e22f4e8aa7a"}
]
```

Block format:

```json
"versions": [
    {
        "link": "16.2",
        "version": "16.2+16C5032a",
        "sha256": "0e367d06eb7c334ea143bada5e4422f56688aabff571bedf0d2ad9434b7290de",
        "install_runtimes": [
          { "iOS": ["18.0", "18.1", "18.2"] },
          { "watchOS": "default" },
          { "tvOS": "default" },
          { "visionOS": "2.2" }
        ]
    },
    {
        "link": "16.1",
        "version": "16.1+16B40",
        "sha256": "8ca961d55981f983d21b99a95a6b0ac04905b837f6e11346ee86d28f12afe720",
        "install_runtimes": "default"
    }
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
