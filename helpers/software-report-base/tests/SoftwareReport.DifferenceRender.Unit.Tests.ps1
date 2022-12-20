using module ../SoftwareReport.Nodes.psm1
using module ../SoftwareReport.DifferenceRender.psm1

BeforeDiscovery {
    Import-Module $(Join-Path $PSScriptRoot "TestHelpers.psm1") -DisableNameChecking
}

Describe "ComparerReport.UnitTests" {
    BeforeAll {
        $script:DifferenceRender = [SoftwareReportDifferenceRender]::new()
    }

    Context "CalculateHtmlTableRowSpan" {
        It "Without the equal cells" {
            $table = @(
                [PSCustomObject]@{ Key = "A"; Value = "1" }
                [PSCustomObject]@{ Key = "B"; Value = "2" }
                [PSCustomObject]@{ Key = "C"; Value = "3" }
            )
            
            $actual = $DifferenceRender.CalculateHtmlTableRowSpan($table, "Key")
            $actual | Should -BeArray @(1, 1, 1)
        }

        It "Only equal cells" {
            $table = @(
                [PSCustomObject]@{ Key = "A"; Value = "D" }
                [PSCustomObject]@{ Key = "B"; Value = "D" }
                [PSCustomObject]@{ Key = "C"; Value = "D" }
            )
            
            $actual = $DifferenceRender.CalculateHtmlTableRowSpan($table, "Value")
            $actual | Should -BeArray @(3, 0, 0)
        }

        It "Single row" {
            $table = @(
                [PSCustomObject]@{ Key = "A"; Value = "1" }
            )
            
            $actual = $DifferenceRender.CalculateHtmlTableRowSpan($table, "Key")
            $actual | Should -BeArray @(1)
        }

        It "Different cells" {
            $table = @(
                [PSCustomObject]@{ Key = "A"; Value = "1" }
                [PSCustomObject]@{ Key = "B"; Value = "2" }
                [PSCustomObject]@{ Key = "B"; Value = "3" }
                [PSCustomObject]@{ Key = "C"; Value = "4" }
                [PSCustomObject]@{ Key = "C"; Value = "5" }
                [PSCustomObject]@{ Key = "C"; Value = "6" }
                [PSCustomObject]@{ Key = "D"; Value = "7" }
                [PSCustomObject]@{ Key = "E"; Value = "8" }
                [PSCustomObject]@{ Key = "E"; Value = "9" }
                [PSCustomObject]@{ Key = "F"; Value = "10" }
            )
            
            $actual = $DifferenceRender.CalculateHtmlTableRowSpan($table, "Key")
            $actual | Should -BeArray @(1, 2, 0, 3, 0, 0, 1, 2, 0, 1)
        }
    }

    Context "RenderCategory" {
        It "With line separator" {
            $actual = $DifferenceRender.RenderCategory(@("Header 1", "Header 2", "Header 3"), $true)
            $actual | Should -Be "Header 2 ><br> Header 3"
        }

        It "Without line separator" {
            $actual = $DifferenceRender.RenderCategory(@("Header 1", "Header 2", "Header 3"), $false)
            $actual | Should -Be "Header 2 > Header 3"
        }

        It "One header" {
            $actual = $DifferenceRender.RenderCategory(@("Header 1"), $false)
            $actual | Should -Be ""
        }

        It "Empty headers" {
            $actual = $DifferenceRender.RenderCategory(@(), $false)
            $actual | Should -Be ""
        }
    }

    Context "RenderToolName" {
        It "Clear tool name" {
            $actual = $DifferenceRender.RenderToolName("My Tool 1")
            $actual | Should -Be "My Tool 1"
        }

        It "Name with colon symbol" {
            $actual = $DifferenceRender.RenderToolName("My Tool 1:")
            $actual | Should -Be "My Tool 1"
        }
    }

    Context "StrikeTableRow" {
        It "Simple row" {
            $actual = $DifferenceRender.StrikeTableRow("Test1|Test2|Test3")
            $actual | Should -Be "~~Test1~~|~~Test2~~|~~Test3~~"
        }

        It "Row with spaces" {
            $actual = $DifferenceRender.StrikeTableRow("Test 1|Test 2|Test 3")
            $actual | Should -Be "~~Test 1~~|~~Test 2~~|~~Test 3~~"
        }
    }

    Context "RenderHtmlTable" {
        It "Simple table" {
            $table = @(
                [PSCustomObject]@{ "Category" = "A"; "Tool name" = "My Tool 1"; "Version" = "1.0" },
                [PSCustomObject]@{ "Category" = "B"; "Tool name" = "My Tool 2"; "Version" = "2.0" },
                [PSCustomObject]@{ "Category" = "C"; "Tool name" = "My Tool 3"; "Version" = "3.0" }
            )

            $renderedTable = $DifferenceRender.RenderHtmlTable($table, "Category")
            $renderedTable | Should -Be @'
<table>
    <thead>
        <th>Category</th>
        <th>Tool name</th>
        <th>Version</th>
    </thead>
    <tbody>
        <tr>
            <td rowspan="1">A</td>
            <td>My Tool 1</td>
            <td>1.0</td>
        </tr>
        <tr>
            <td rowspan="1">B</td>
            <td>My Tool 2</td>
            <td>2.0</td>
        </tr>
        <tr>
            <td rowspan="1">C</td>
            <td>My Tool 3</td>
            <td>3.0</td>
        </tr>
    </tbody>
</table>

'@

        }

        It "Table with the same category" {
            $table = @(
                [PSCustomObject]@{ "Category" = "A"; "Tool name" = "My Tool 1"; "Version" = "1.0" },
                [PSCustomObject]@{ "Category" = "A"; "Tool name" = "My Tool 2"; "Version" = "2.0" },
                [PSCustomObject]@{ "Category" = "A"; "Tool name" = "My Tool 3"; "Version" = "3.0" },
                [PSCustomObject]@{ "Category" = "B"; "Tool name" = "My Tool 4"; "Version" = "4.0" }
            )

            $renderedTable = $DifferenceRender.RenderHtmlTable($table, "Category")
            $renderedTable | Should -Be @'
<table>
    <thead>
        <th>Category</th>
        <th>Tool name</th>
        <th>Version</th>
    </thead>
    <tbody>
        <tr>
            <td rowspan="3">A</td>
            <td>My Tool 1</td>
            <td>1.0</td>
        </tr>
        <tr>
            <td>My Tool 2</td>
            <td>2.0</td>
        </tr>
        <tr>
            <td>My Tool 3</td>
            <td>3.0</td>
        </tr>
        <tr>
            <td rowspan="1">B</td>
            <td>My Tool 4</td>
            <td>4.0</td>
        </tr>
    </tbody>
</table>

'@

        }
    }

    Context "RenderTableNodesDiff" {
        It "Add new table" {
            $previousNode = $null
            $currentNode = [TableNode]::new("Name|Value", @("A|1", "B|2"))
            $reportItem = [ReportDifferenceItem]::new($previousNode, $currentNode, @("Header 1", "Header 2", "Header 3"))

            $actual = $DifferenceRender.RenderTableNodesDiff($reportItem)
            $actual | Should -Be @'
#### Header 2 > Header 3
| Name | Value |
| ---- | ----- |
| A    | 1     |
| B    | 2     |

'@
        }

        It "Remove existing table" {
            $previousNode = [TableNode]::new("Name|Value", @("A|1", "B|2"))
            $currentNode = $null
            $reportItem = [ReportDifferenceItem]::new($previousNode, $currentNode, @("Header 1", "Header 2", "Header 3"))

            $actual = $DifferenceRender.RenderTableNodesDiff($reportItem)
            $actual | Should -Be @'
#### Header 2 > Header 3
| Name  | Value |
| ----- | ----- |
| ~~A~~ | ~~1~~ |
| ~~B~~ | ~~2~~ |

'@
        }

        It "Add new rows to existing table" {
            $previousNode = [TableNode]::new("Name|Value", @("A|1", "B|2"))
            $currentNode = [TableNode]::new("Name|Value", @("A|1", "B|2", "C|3", "D|4"))
            $reportItem = [ReportDifferenceItem]::new($previousNode, $currentNode, @("Header 1", "Header 2", "Header 3"))

            $actual = $DifferenceRender.RenderTableNodesDiff($reportItem)
            $actual | Should -Be @'
#### Header 2 > Header 3
| Name | Value |
| ---- | ----- |
| C    | 3     |
| D    | 4     |

'@
        }

        It "Remove rows from existing table" {
            $previousNode = [TableNode]::new("Name|Value", @("A|1", "B|2", "C|3", "D|4"))
            $currentNode = [TableNode]::new("Name|Value", @("C|3", "D|4"))
            $reportItem = [ReportDifferenceItem]::new($previousNode, $currentNode, @("Header 1", "Header 2", "Header 3"))

            $actual = $DifferenceRender.RenderTableNodesDiff($reportItem)
            $actual | Should -Be @'
#### Header 2 > Header 3
| Name  | Value |
| ----- | ----- |
| ~~A~~ | ~~1~~ |
| ~~B~~ | ~~2~~ |

'@
        }

        It "Row is changed in existing table" {
            $previousNode = [TableNode]::new("Name|Value", @("A|1", "B|2"))
            $currentNode = [TableNode]::new("Name|Value", @("A|1", "B|3"))
            $reportItem = [ReportDifferenceItem]::new($previousNode, $currentNode, @("Header 1", "Header 2", "Header 3"))

            $actual = $DifferenceRender.RenderTableNodesDiff($reportItem)
            $actual | Should -Be @'
#### Header 2 > Header 3
| Name  | Value |
| ----- | ----- |
| ~~B~~ | ~~2~~ |
| B     | 3     |

'@
        }

        It "Row is changed, added and removed at the same time in existing table" {
            $previousNode = [TableNode]::new("Name|Value", @("A|1", "B|2", "C|3", "D|4"))
            $currentNode = [TableNode]::new("Name|Value", @("B|2", "C|4", "D|4", "E|5"))
            $reportItem = [ReportDifferenceItem]::new($previousNode, $currentNode, @("Header 1", "Header 2", "Header 3"))

            $actual = $DifferenceRender.RenderTableNodesDiff($reportItem)
            $actual | Should -Be @'
#### Header 2 > Header 3
| Name  | Value |
| ----- | ----- |
| ~~A~~ | ~~1~~ |
| ~~C~~ | ~~3~~ |
| C     | 4     |
| E     | 5     |

'@
        }
    }
}