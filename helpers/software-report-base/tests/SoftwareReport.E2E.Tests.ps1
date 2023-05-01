using module ../SoftwareReport.psm1
using module ../SoftwareReport.Nodes.psm1

Describe "SoftwareReport.E2E" {
    Context "Report example 1" {
        BeforeEach {
            $softwareReport = [SoftwareReport]::new("macOS 11")
            $softwareReport.Root.AddToolVersion("OS Version:", "macOS 11.7 (20G817)")
            $softwareReport.Root.AddToolVersion("Image Version:", "20220918.1")
            $installedSoftware = $softwareReport.Root.AddHeader("Installed Software")

            $languagesAndRuntimes = $installedSoftware.AddHeader("Language and Runtime")
            $languagesAndRuntimes.AddToolVersion("Bash", "5.1.16(1)-release")
            $languagesAndRuntimes.AddToolVersionsListInline(".NET Core SDK", @("1.2.100", "1.2.200", "3.1.414"), "^\d+\.\d+\.\d")
            $languagesAndRuntimes.AddNode([ToolVersionNode]::new("Perl", "5.34.0"))

            $cachedTools = $installedSoftware.AddHeader("Cached Tools")
            $cachedTools.AddToolVersionsList("Ruby", @("2.7.3", "2.8.1", "3.1.2"), "^\d+\.\d+")
            $cachedTools.AddToolVersionsList("Node.js", @("14.8.0", "15.1.0", "16.4.2"), "^\d+")

            $javaSection = $installedSoftware.AddHeader("Java")
            $javaSection.AddTable(@(
                [PSCustomObject] @{ Version = "8.0.125"; Vendor = "My Vendor"; "Environment Variable" = "JAVA_HOME_8_X64" },
                [PSCustomObject] @{ Version = "11.3.103"; Vendor = "My Vendor"; "Environment Variable" = "JAVA_HOME_11_X64" }
            ))

            $sqlSection = $installedSoftware.AddHeader("MySQL")
            $sqlSection.AddToolVersion("MySQL", "6.1.0")
            $sqlSection.AddNote("MySQL service is disabled by default.`nUse the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'")

            $expectedMarkdown = @'
# macOS 11
- OS Version: macOS 11.7 (20G817)
- Image Version: 20220918.1

## Installed Software

### Language and Runtime
- Bash 5.1.16(1)-release
- .NET Core SDK: 1.2.100, 1.2.200, 3.1.414
- Perl 5.34.0

### Cached Tools

#### Ruby
- 2.7.3
- 2.8.1
- 3.1.2

#### Node.js
- 14.8.0
- 15.1.0
- 16.4.2

### Java
| Version  | Vendor    | Environment Variable |
| -------- | --------- | -------------------- |
| 8.0.125  | My Vendor | JAVA_HOME_8_X64      |
| 11.3.103 | My Vendor | JAVA_HOME_11_X64     |

### MySQL
- MySQL 6.1.0
```
MySQL service is disabled by default.
Use the following command as a part of your job to start the service: 'sudo systemctl start mysql.service'
```
'@
        }

        It "ToMarkdown" {
            $softwareReport.ToMarkdown() | Should -Be $expectedMarkdown
        }

        It "Serialization + Deserialization" {
            $json = $softwareReport.ToJson()
            $deserializedReport = [SoftwareReport]::FromJson($json)
            $deserializedReport.ToMarkdown() | Should -Be $expectedMarkdown
        }
    }

    Context "GetImageVersion" {
        It "Image version exists" {
            $softwareReport = [SoftwareReport]::new("MyReport")
            $softwareReport.Root.AddToolVersion("Image Version:", "123.4")
            $softwareReport.GetImageVersion() | Should -Be "123.4"
        }

        It "Empty report" {
            $softwareReport = [SoftwareReport]::new("MyReport")
            $softwareReport.GetImageVersion() | Should -Be "Unknown version"
        }
    }
}