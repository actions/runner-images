using module ../SoftwareReport.psm1
using module ../SoftwareReport.DifferenceCalculator.psm1

Describe "Comparer.E2E" {
    It "Some tools are updated" {
        # Previous report
        $prevSoftwareReport = [SoftwareReport]::new("macOS 11")
        $prevSoftwareReport.Root.AddToolVersion("OS Version:", "macOS 11.7.1 (20G817)")
        $prevSoftwareReport.Root.AddToolVersion("Image Version:", "20220918.1")
        $prevInstalledSoftware = $prevSoftwareReport.Root.AddHeader("Installed Software")
        $prevTools = $prevInstalledSoftware.AddHeader("Tools")
        $prevTools.AddToolVersion("ToolWillBeUpdated1", "1.0.0")
        $prevTools.AddToolVersion("ToolWillBeUpdated2", "3.0.1")
        $prevTools.AddToolVersionsList("ToolWillBeUpdated3", @("14.0.0", "15.5.1"), "^\d+")

        # Next report
        $nextSoftwareReport = [SoftwareReport]::new("macOS 11")
        $nextSoftwareReport.Root.AddToolVersion("OS Version:", "macOS 11.7.1 (20G817)")
        $nextSoftwareReport.Root.AddToolVersion("Image Version:", "20220922.1")
        $nextInstalledSoftware = $nextSoftwareReport.Root.AddHeader("Installed Software")
        $nextTools = $nextInstalledSoftware.AddHeader("Tools")
        $nextTools.AddToolVersion("ToolWillBeUpdated1", "2.5.0")
        $nextTools.AddToolVersion("ToolWillBeUpdated2", "3.0.2")
        $nextTools.AddToolVersionsList("ToolWillBeUpdated3", @("14.2.0", "15.5.1"), "^\d+")

        # Compare reports
        $comparer = [SoftwareReportDifferenceCalculator]::new($prevSoftwareReport, $nextSoftwareReport)
        $comparer.CompareReports()
        $comparer.GetMarkdownReport() | Should -BeExactly @'
# :desktop_computer: Actions Runner Image: macOS 11
- OS Version: macOS 11.7.1 (20G817)
- Image Version: 20220922.1

## :mega: What's changed?

### Updated

<table>
    <thead>
        <th>Category</th>
        <th>Tool name</th>
        <th>Previous (20220918.1)</th>
        <th>Current (20220922.1)</th>
    </thead>
    <tbody>
        <tr>
            <td rowspan="3">Tools</td>
            <td>ToolWillBeUpdated1</td>
            <td>1.0.0</td>
            <td>2.5.0</td>
        </tr>
        <tr>
            <td>ToolWillBeUpdated2</td>
            <td>3.0.1</td>
            <td>3.0.2</td>
        </tr>
        <tr>
            <td>ToolWillBeUpdated3</td>
            <td>14.0.0</td>
            <td>14.2.0</td>
        </tr>
    </tbody>
</table>


'@
    }
    
    It "Some tools are updated, added and removed" {
        # Previous report
        $prevSoftwareReport = [SoftwareReport]::new("macOS 11")
        $prevSoftwareReport.Root.AddToolVersion("OS Version:", "macOS 11.7.1 (20G817)")
        $prevSoftwareReport.Root.AddToolVersion("Image Version:", "20220918.1")
        $prevInstalledSoftware = $prevSoftwareReport.Root.AddHeader("Installed Software")

        $prevLanguagesAndRuntimes = $prevInstalledSoftware.AddHeader("Language and Runtime")
        $prevLanguagesAndRuntimes.AddToolVersion("ToolWillBeRemoved", "5.1.16(1)-release")
        $prevLanguagesAndRuntimes.AddToolVersionsListInline("ToolWithMultipleVersions3", @("1.2.100", "1.2.200", "1.3.500", "1.4.100", "1.4.200"), "^\d+\.\d+\.\d")
        $prevLanguagesAndRuntimes.AddToolVersion("ToolWithoutChanges", "5.34.0")
        $prevLanguagesAndRuntimes.AddToolVersion("ToolWillBeUpdated", "8.1.0")

        $prevCachedTools = $prevInstalledSoftware.AddHeader("Cached Tools")
        $prevCachedTools.AddToolVersionsList("ToolWithMultipleVersions1", @("2.7.3", "2.8.1", "3.1.2"), "^\d+\.\d+")
        $prevCachedTools.AddToolVersionsList("ToolWithMultipleVersions2", @("14.8.0", "15.1.0", "16.4.2"), "^\d+")

        $prevSQLSection = $prevInstalledSoftware.AddHeader("Databases")
        $prevSQLSection.AddToolVersion("MineSQL", "6.1.0")
        $prevSQLSection.AddNote("First Note")

        # Next report
        $nextSoftwareReport = [SoftwareReport]::new("macOS 11")
        $nextSoftwareReport.Root.AddToolVersion("OS Version:", "macOS 11.7.2 (20G922)")
        $nextSoftwareReport.Root.AddToolVersion("Image Version:", "20220922.0")
        $nextInstalledSoftware = $nextSoftwareReport.Root.AddHeader("Installed Software")

        $nextLanguagesAndRuntimes = $nextInstalledSoftware.AddHeader("Language and Runtime")
        $nextLanguagesAndRuntimes.AddToolVersion("ToolWillBeAdded", "16.18.0")
        $nextLanguagesAndRuntimes.AddToolVersionsListInline("ToolWithMultipleVersions3", @("1.2.200", "1.3.515", "1.4.100", "1.4.200", "1.5.800"), "^\d+\.\d+\.\d")
        $nextLanguagesAndRuntimes.AddToolVersion("ToolWithoutChanges", "5.34.0")
        $nextLanguagesAndRuntimes.AddToolVersion("ToolWillBeUpdated", "8.3.0")

        $nextCachedTools = $nextInstalledSoftware.AddHeader("Cached Tools")
        $nextCachedTools.AddToolVersionsList("ToolWithMultipleVersions1", @("2.7.3", "2.8.1", "3.1.2"), "^\d+\.\d+")
        $nextCachedTools.AddToolVersionsList("ToolWithMultipleVersions2", @("15.1.0", "16.4.2", "17.0.1"), "^\d+")

        $nextSQLSection = $nextInstalledSoftware.AddHeader("Databases")
        $nextSQLSection.AddToolVersion("MineSQL", "6.1.1")
        $nextSQLSection.AddNote("Second Note")

        # Compare reports
        $comparer = [SoftwareReportDifferenceCalculator]::new($prevSoftwareReport, $nextSoftwareReport)
        $comparer.CompareReports()
        $comparer.GetMarkdownReport() | Should -BeExactly @'
# :desktop_computer: Actions Runner Image: macOS 11
- OS Version: macOS 11.7.2 (20G922)
- Image Version: 20220922.0

## :mega: What's changed?

### Added :heavy_plus_sign:

<table>
    <thead>
        <th>Category</th>
        <th>Tool name</th>
        <th>Current (20220922.0)</th>
    </thead>
    <tbody>
        <tr>
            <td rowspan="2">Language and Runtime</td>
            <td>ToolWillBeAdded</td>
            <td>16.18.0</td>
        </tr>
        <tr>
            <td>ToolWithMultipleVersions3</td>
            <td>1.5.800</td>
        </tr>
        <tr>
            <td rowspan="1">Cached Tools</td>
            <td>ToolWithMultipleVersions2</td>
            <td>17.0.1</td>
        </tr>
    </tbody>
</table>

### Deleted :heavy_minus_sign:

<table>
    <thead>
        <th>Category</th>
        <th>Tool name</th>
        <th>Previous (20220918.1)</th>
    </thead>
    <tbody>
        <tr>
            <td rowspan="2">Language and Runtime</td>
            <td>ToolWithMultipleVersions3</td>
            <td>1.2.100</td>
        </tr>
        <tr>
            <td>ToolWillBeRemoved</td>
            <td>5.1.16(1)-release</td>
        </tr>
        <tr>
            <td rowspan="1">Cached Tools</td>
            <td>ToolWithMultipleVersions2</td>
            <td>14.8.0</td>
        </tr>
    </tbody>
</table>

### Updated

<table>
    <thead>
        <th>Category</th>
        <th>Tool name</th>
        <th>Previous (20220918.1)</th>
        <th>Current (20220922.0)</th>
    </thead>
    <tbody>
        <tr>
            <td rowspan="1"></td>
            <td>OS Version</td>
            <td>macOS 11.7.1 (20G817)</td>
            <td>macOS 11.7.2 (20G922)</td>
        </tr>
        <tr>
            <td rowspan="2">Language and Runtime</td>
            <td>ToolWithMultipleVersions3</td>
            <td>1.3.500</td>
            <td>1.3.515</td>
        </tr>
        <tr>
            <td>ToolWillBeUpdated</td>
            <td>8.1.0</td>
            <td>8.3.0</td>
        </tr>
        <tr>
            <td rowspan="1">Databases</td>
            <td>MineSQL</td>
            <td>6.1.0</td>
            <td>6.1.1</td>
        </tr>
    </tbody>
</table>


'@
    }

    It "Header tree changes" {
        # Previous report
        $prevSoftwareReport = [SoftwareReport]::new("macOS 11")
        $prevSoftwareReport.Root.AddToolVersion("Image Version:", "20220918.1")
        $prevInstalledSoftware = $prevSoftwareReport.Root.AddHeader("Installed Software")
        $prevInstalledSoftware.AddToolVersion("ToolWithoutChanges", "5.34.0")
        $prevInstalledSoftware.AddHeader("HeaderWillBeRemoved").AddHeader("SubheaderWillBeRemoved").AddToolVersion("ToolWillBeRemoved", "1.0.0")
        $prevInstalledSoftware.AddHeader("Header1").AddToolVersion("ToolWillBeMovedToAnotherHeader", "3.0.0")

        # Next report
        $nextSoftwareReport = [SoftwareReport]::new("macOS 11")
        $nextSoftwareReport.Root.AddToolVersion("Image Version:", "20220922.0")
        $nextInstalledSoftware = $nextSoftwareReport.Root.AddHeader("Installed Software")
        $nextInstalledSoftware.AddToolVersion("ToolWithoutChanges", "5.34.0")
        $nextInstalledSoftware.AddHeader("HeaderWillBeAdded").AddHeader("SubheaderWillBeAdded").AddToolVersion("ToolWillBeAdded", "5.0.0")
        $nextInstalledSoftware.AddHeader("Header2").AddToolVersion("ToolWillBeMovedToAnotherHeader", "3.0.0")

        # Compare reports
        $comparer = [SoftwareReportDifferenceCalculator]::new($prevSoftwareReport, $nextSoftwareReport)
        $comparer.CompareReports()
        $comparer.GetMarkdownReport() | Should -BeExactly @'
# :desktop_computer: Actions Runner Image: macOS 11
- Image Version: 20220922.0

## :mega: What's changed?

### Added :heavy_plus_sign:

<table>
    <thead>
        <th>Category</th>
        <th>Tool name</th>
        <th>Current (20220922.0)</th>
    </thead>
    <tbody>
        <tr>
            <td rowspan="1">HeaderWillBeAdded ><br> SubheaderWillBeAdded</td>
            <td>ToolWillBeAdded</td>
            <td>5.0.0</td>
        </tr>
        <tr>
            <td rowspan="1">Header2</td>
            <td>ToolWillBeMovedToAnotherHeader</td>
            <td>3.0.0</td>
        </tr>
    </tbody>
</table>

### Deleted :heavy_minus_sign:

<table>
    <thead>
        <th>Category</th>
        <th>Tool name</th>
        <th>Previous (20220918.1)</th>
    </thead>
    <tbody>
        <tr>
            <td rowspan="1">HeaderWillBeRemoved ><br> SubheaderWillBeRemoved</td>
            <td>ToolWillBeRemoved</td>
            <td>1.0.0</td>
        </tr>
        <tr>
            <td rowspan="1">Header1</td>
            <td>ToolWillBeMovedToAnotherHeader</td>
            <td>3.0.0</td>
        </tr>
    </tbody>
</table>


'@
    }

    It "Tables are added and removed" {
        # Previous report
        $prevSoftwareReport = [SoftwareReport]::new("macOS 11")
        $prevSoftwareReport.Root.AddToolVersion("Image Version:", "20220918.1")
        $prevInstalledSoftware = $prevSoftwareReport.Root.AddHeader("Installed Software")
        $prevInstalledSoftware.AddHeader("HeaderWillExist").AddTable(@(
            [PSCustomObject]@{TableInExistingHeaderWillBeRemoved = "Q"; Value = "25"},
            [PSCustomObject]@{TableInExistingHeaderWillBeRemoved = "O"; Value = "24"}
        ))
            
        $prevTools = $prevInstalledSoftware.AddHeader("Tools")
        $prevTools.AddHeader("HeaderWillBeRemoved").AddTable(@(
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "Z"; Value = "30"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "W"; Value = "29"}
        ))

        # Next report
        $nextSoftwareReport = [SoftwareReport]::new("macOS 11")
        $nextSoftwareReport.Root.AddToolVersion("Image Version:", "20220922.1")
        $nextInstalledSoftware = $nextSoftwareReport.Root.AddHeader("Installed Software")
        $nextInstalledSoftware.AddHeader("HeaderWillExist")
        $nextTools = $nextInstalledSoftware.AddHeader("Tools")
        $nextTools.AddToolVersion("ToolWillBeAdded", "3.0.1")
        $nextTools.AddTable(@(
            [PSCustomObject]@{NewTableInExistingHeader = "A"; Value = "1"},
            [PSCustomObject]@{NewTableInExistingHeader = "B"; Value = "2"}
        ))
        $nextTools.AddHeader("NewHeaderWithTable").AddTable(@(
            [PSCustomObject]@{NewTableInNewHeader = "C"; Value = "3"},
            [PSCustomObject]@{NewTableInNewHeader = "D"; Value = "4"}
        ))

        # Compare reports
        $comparer = [SoftwareReportDifferenceCalculator]::new($prevSoftwareReport, $nextSoftwareReport)
        $comparer.CompareReports()
        $comparer.GetMarkdownReport() | Should -BeExactly @'
# :desktop_computer: Actions Runner Image: macOS 11
- Image Version: 20220922.1

## :mega: What's changed?

### Added :heavy_plus_sign:

<table>
    <thead>
        <th>Category</th>
        <th>Tool name</th>
        <th>Current (20220922.1)</th>
    </thead>
    <tbody>
        <tr>
            <td rowspan="1">Tools</td>
            <td>ToolWillBeAdded</td>
            <td>3.0.1</td>
        </tr>
    </tbody>
</table>

#### Tools
| NewTableInExistingHeader | Value |
| ------------------------ | ----- |
| A                        | 1     |
| B                        | 2     |

#### Tools > NewHeaderWithTable
| NewTableInNewHeader | Value |
| ------------------- | ----- |
| C                   | 3     |
| D                   | 4     |

### Deleted :heavy_minus_sign:

#### HeaderWillExist
| TableInExistingHeaderWillBeRemoved | Value  |
| ---------------------------------- | ------ |
| ~~Q~~                              | ~~25~~ |
| ~~O~~                              | ~~24~~ |

#### Tools > HeaderWillBeRemoved
| TableWillBeRemovedWithHeader | Value  |
| ---------------------------- | ------ |
| ~~Z~~                        | ~~30~~ |
| ~~W~~                        | ~~29~~ |


'@
    }

    It "Tables are changed" {
        # Previous report
        $prevSoftwareReport = [SoftwareReport]::new("macOS 11")
        $prevSoftwareReport.Root.AddToolVersion("Image Version:", "20220918.1")
        $prevInstalledSoftware = $prevSoftwareReport.Root.AddHeader("Installed Software")
        $prevTools = $prevInstalledSoftware.AddHeader("Tools")
        $prevTools.AddHeader("TableWithAddedRows").AddTable(@(
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "AA"; Value = "10"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "AB"; Value = "11"}
        ))
        $prevTools.AddHeader("TableWithRemovedRows").AddTable(@(
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "BA"; Value = "32"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "BB"; Value = "33"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "BC"; Value = "34"}
        ))
        $prevTools.AddHeader("TableWithUpdatedRow").AddTable(@(
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "CA"; Value = "42"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "CB"; Value = "43"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "CC"; Value = "44"}
        ))
        $prevTools.AddHeader("TableWithUpdatedRows").AddTable(@(
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "DA"; Value = "50"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "DB"; Value = "51"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "DC"; Value = "52"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "DD"; Value = "53"}
        ))
        $prevTools.AddHeader("TableWithComplexChanges").AddTable(@(
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "EA"; Value = "62"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "EB"; Value = "63"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "EC"; Value = "64"}
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "ED"; Value = "65"}
        ))

        $prevTools.AddHeader("TableWithOnlyHeaderChanged").AddTable(@(
            [PSCustomObject]@{TableWithOnlyHeaderChanged = "FA"; Value = "72"},
            [PSCustomObject]@{TableWithOnlyHeaderChanged = "FB"; Value = "73"}
        ))

        $prevTools.AddHeader("TableWithHeaderAndRowsChanges").AddTable(@(
            [PSCustomObject]@{TableWithHeaderAndRowsChanges = "GA"; Value = "82"},
            [PSCustomObject]@{TableWithHeaderAndRowsChanges = "GB"; Value = "83"},
            [PSCustomObject]@{TableWithHeaderAndRowsChanges = "GC"; Value = "84"}
        ))

        # Next report
        $nextSoftwareReport = [SoftwareReport]::new("macOS 11")
        $nextSoftwareReport.Root.AddToolVersion("Image Version:", "20220922.1")
        $nextInstalledSoftware = $nextSoftwareReport.Root.AddHeader("Installed Software")
        $nextTools = $nextInstalledSoftware.AddHeader("Tools")
        $nextTools.AddHeader("TableWithAddedRows").AddTable(@(
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "AA"; Value = "10"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "AB"; Value = "11"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "AC"; Value = "12"}
        ))
        $nextTools.AddHeader("TableWithRemovedRows").AddTable(@(
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "BB"; Value = "33"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "BC"; Value = "34"}
        ))
        $nextTools.AddHeader("TableWithUpdatedRow").AddTable(@(
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "CA"; Value = "42"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "CB"; Value = "500"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "CC"; Value = "44"}
        ))
        $nextTools.AddHeader("TableWithUpdatedRows").AddTable(@(
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "DA"; Value = "50"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "DB"; Value = "5100"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "DC"; Value = "5200"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "DD"; Value = "53"}
        ))
        $nextTools.AddHeader("TableWithComplexChanges").AddTable(@(
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "EB"; Value = "63"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "EC"; Value = "640"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "ED"; Value = "65"},
            [PSCustomObject]@{TableWillBeRemovedWithHeader = "EE"; Value = "66"}
        ))

        $nextTools.AddHeader("TableWithOnlyHeaderChanged").AddTable(@(
            [PSCustomObject]@{TableWithOnlyHeaderChanged2 = "FA"; Value = "72"},
            [PSCustomObject]@{TableWithOnlyHeaderChanged2 = "FB"; Value = "73"}
        ))

        $nextTools.AddHeader("TableWithHeaderAndRowsChanges").AddTable(@(
            [PSCustomObject]@{TableWithHeaderAndRowsChanges2 = "GA"; Value = "82"},
            [PSCustomObject]@{TableWithHeaderAndRowsChanges2 = "GE"; Value = "850"},
            [PSCustomObject]@{TableWithHeaderAndRowsChanges2 = "GC"; Value = "840"}
        ))

        # Compare reports
        $comparer = [SoftwareReportDifferenceCalculator]::new($prevSoftwareReport, $nextSoftwareReport)
        $comparer.CompareReports()
        $comparer.GetMarkdownReport() | Should -BeExactly @'
# :desktop_computer: Actions Runner Image: macOS 11
- Image Version: 20220922.1

## :mega: What's changed?

### Added :heavy_plus_sign:

#### Tools > TableWithAddedRows
| TableWillBeRemovedWithHeader | Value |
| ---------------------------- | ----- |
| AC                           | 12    |

#### Tools > TableWithHeaderAndRowsChanges
| TableWithHeaderAndRowsChanges2 | Value |
| ------------------------------ | ----- |
| GA                             | 82    |
| GE                             | 850   |
| GC                             | 840   |

### Deleted :heavy_minus_sign:

#### Tools > TableWithRemovedRows
| TableWillBeRemovedWithHeader | Value  |
| ---------------------------- | ------ |
| ~~BA~~                       | ~~32~~ |

#### Tools > TableWithHeaderAndRowsChanges
| TableWithHeaderAndRowsChanges | Value  |
| ----------------------------- | ------ |
| ~~GA~~                        | ~~82~~ |
| ~~GB~~                        | ~~83~~ |
| ~~GC~~                        | ~~84~~ |

### Updated

#### Tools > TableWithUpdatedRow
| TableWillBeRemovedWithHeader | Value  |
| ---------------------------- | ------ |
| ~~CB~~                       | ~~43~~ |
| CB                           | 500    |

#### Tools > TableWithUpdatedRows
| TableWillBeRemovedWithHeader | Value  |
| ---------------------------- | ------ |
| ~~DB~~                       | ~~51~~ |
| ~~DC~~                       | ~~52~~ |
| DB                           | 5100   |
| DC                           | 5200   |

#### Tools > TableWithComplexChanges
| TableWillBeRemovedWithHeader | Value  |
| ---------------------------- | ------ |
| ~~EA~~                       | ~~62~~ |
| ~~EC~~                       | ~~64~~ |
| EC                           | 640    |
| EE                           | 66     |


'@
    }

    It "Reports are identical" {
        # Previous report
        $prevSoftwareReport = [SoftwareReport]::new("macOS 11")
        $prevSoftwareReport.Root.AddToolVersion("OS Version:", "macOS 11.7.1 (20G817)")
        $prevSoftwareReport.Root.AddToolVersion("Image Version:", "20220918.1")
        $prevInstalledSoftware = $prevSoftwareReport.Root.AddHeader("Installed Software")
        $prevTools = $prevInstalledSoftware.AddHeader("Tools")
        $prevTools.AddToolVersion("ToolA", "1.0.0")
        $prevTools.AddToolVersion("ToolB", "3.0.1")

        # Next report
        $nextSoftwareReport = [SoftwareReport]::new("macOS 11")
        $nextSoftwareReport.Root.AddToolVersion("OS Version:", "macOS 11.7.1 (20G817)")
        $nextSoftwareReport.Root.AddToolVersion("Image Version:", "20220922.1")
        $nextInstalledSoftware = $nextSoftwareReport.Root.AddHeader("Installed Software")
        $nextTools = $nextInstalledSoftware.AddHeader("Tools")
        $nextTools.AddToolVersion("ToolA", "1.0.0")
        $nextTools.AddToolVersion("ToolB", "3.0.1")

        # Compare reports
        $comparer = [SoftwareReportDifferenceCalculator]::new($prevSoftwareReport, $nextSoftwareReport)
        $comparer.CompareReports()
        $comparer.GetMarkdownReport() | Should -BeExactly @'
# :desktop_computer: Actions Runner Image: macOS 11
- OS Version: macOS 11.7.1 (20G817)
- Image Version: 20220922.1

## :mega: What's changed?


'@
    }
}