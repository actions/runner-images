# Toolset JSON structure

## Xcode

- `versions` - the array of objects that will present installed Xcode versions  
  - `link` property points to the place where Xcode will be located on image. `/Applications/Xcode_<link>.app`  
  - `version` points to Xcode version that will be downloaded and installed
  - `symlinks` describes the list of aliases where symlinks will be created to
  - `install_runtimes` is boolean function to control over the related simulator runtimes
  - `sha256` used to check integrity of the Xcode installer file
- `default` - version of Xcode to set as default (should be metched with any `link` in `versions` property)
    **Example:** `"11.2"`  

**Note:**

- If `version` is specified with spaces, it is considered as exact Xcode name like `12.1.1 Release Candidate`.
- If `version` doesn't contain spaces, the latest version will be resolved with the following priority:  
  - stable version like `12.1`
  - release candidate version like `12.1 Release Candidate N` (the latest N will be chosen)
  - GM version like `12.1 GM Seed N` (the latest N will be chosen)
  - beta version like `12.1 beta N` (the latest N will be chosen)

**Example:**

```json
"versions": [
    { "link": "16_beta_4", "version": "16.0.0-Beta.4+16A5211f", "symlinks": ["16.0"], "install_runtimes": "false", "sha256": "4270cd8021b2f7f512ce91bfc4423b25bccab36cdab21834709d798c8daade72"},
    { "link": "15.4", "version": "15.4.0+15F31d", "install_runtimes": "true", "sha256": "82d3d61804ff3f4c7c82085e91dc701037ddaa770e542848b2477e22f4e8aa7a"}
]
```

## Xamarin

- `vsmac` - version of Visual Studio For Mac to install.  
    **Example:** `"8.3.11.1"`

- `mono_versions` - the array of Mono versions to install.  
    **Example:** `[ "6.4.0.208", "6.0.0.334" ]`  

- `ios_versions` - the array of Xamarin iOS versions to install.  
    **Example:** `[ "13.6.0.12", "13.4.0.2", "13.2.0.47" ]`  

- `mac_versions` - the array of Xamarin iOS versions to install.  
    **Example:** `[ "6.6.0.12", "6.4.0.2", "6.2.0.47" ]`  

- `android_versions` - the array of Xamarin iOS versions to install.  
    **Example:** `[ "10.0.6.2", "9.4.1.0" ]`  

**Note:** More than one version of SDK with the same major.minor version should not be installed. It applies to `mono_versions`, `ios_versions`, `mac_versions`, `android_versions` fields.  
For example, if Mono `6.4.0.100` is installed and Mono `6.4.1.2` was released recently, we should not install both, just update `6.4.0.100` -> `6.4.1.2`. Only major and minor version changes can break backward compatibility so it is safe.  

- `bundle_default` - the symlink of the bundle that will be set as default on the image.  
This bundle will be set as `Current`.  
    **Example:** `"5_12_0"` (set bundle with symlink `5_12_0` as default)  
    **Example:** `"latest"` (set latest bundle as default)  

- `bundles` - the array of objects that describe bundles that will be created on image after sdk installation.  
The first bundle in the list will be as `Latest`.  

    Each object should contain the following fields:
  - `symlink` - unique id of the bundle (usually looks like "<major_mono_version>_<minor_mono_version>_<index>")  
  - `mono` - version of Mono that will be set in this bundle. Only two numbers (`major.minor`) should be specified.  
  - `ios` - version of Xamarin.iOS that will be set in this bundle. Only two numbers (`major.minor`) should be specified.  
  - `mac` - version of Xamarin.Mac that will be set in this bundle. Only two numbers (`major.minor`) should be specified.  
  - `android` - version of Xamarin.Android that will be set in this bundle. Only two numbers (`major.minor`) should be specified.  

**Example:**  

```json
        [
          {
            "symlink": "6_4_2",
            "mono": "6.4",
            "ios": "13.6",
            "mac": "6.6",
            "android": "10.0"
          },
          {
            "symlink": "6_4_1",
            "mono": "6.4",
            "ios": "13.4",
            "mac": "6.4",
            "android": "10.0"
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

- `addons` - the array of android addons to install.  
    **Example:** `[ "addon-google_apis-google-24", "addon-google_apis-google-23" ]`  

## Toolset JSON validation

File `Toolset.Tests.ps1` contains PowerShell [Pester](https://github.com/Pester/Pester) tests that validate JSON toolset files.
Type `Invoke-Pester` in the current folder in PowerShell to run tests.
