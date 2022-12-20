using module ./SoftwareReport.psm1
using module ./SoftwareReport.BaseNodes.psm1
using module ./SoftwareReport.Nodes.psm1

class SoftwareReportDifferenceRender {
    [String] GenerateMarkdownReport([SoftwareReport] $CurrentReport, [SoftwareReport] $PreviousReport, [ReportDifferenceItem[]] $AddedItems, [ReportDifferenceItem[]] $ChangedItems, [ReportDifferenceItem[]] $DeletedItems) {
        $sb = [System.Text.StringBuilder]::new()

        $rootNode = $CurrentReport.Root
        $imageVersion = $CurrentReport.GetImageVersion()
        $previousImageVersion = $PreviousReport.GetImageVersion()

        #############################
        ### Render report header ####
        #############################

        $sb.AppendLine("# :desktop_computer: Actions Runner Image: $($rootNode.Title)")

        # ToolVersionNodes on root level contains main image description so just copy-paste them to final report
        $rootNode.Children | Where-Object { $_ -is [ToolVersionNode] } | ForEach-Object {
            $sb.AppendLine($_.ToMarkdown())
        }
        $sb.AppendLine()

        $sb.AppendLine("## :mega: What's changed?").AppendLine()

        ###########################
        ### Render added items ####
        ###########################

        [ReportDifferenceItem[]] $addedItemsBaseTools = $AddedItems | Where-Object { $_.IsBaseToolNode() }
        [ReportDifferenceItem[]] $addedItemsTables = $AddedItems | Where-Object { $_.IsTableNode() }
        if ($addedItemsBaseTools.Count + $addedItemsTables.Count -gt 0) {
            $sb.AppendLine("### Added :heavy_plus_sign:").AppendLine()
        }
        if ($addedItemsBaseTools.Count -gt 0) {
            $tableItems = $addedItemsBaseTools | ForEach-Object {
                [PSCustomObject]@{
                    "Category" = $this.RenderCategory($_.Headers, $true);
                    "Tool name" = $this.RenderToolName($_.CurrentReportNode.ToolName);
                    "Current ($imageVersion)" = $_.CurrentReportNode.GetValue();
                }
            }
            $sb.AppendLine($this.RenderHtmlTable($tableItems, "Category"))
        }
        if ($addedItemsTables.Count -gt 0) {
            $addedItemsTables | ForEach-Object {
                $sb.AppendLine($this.RenderTableNodesDiff($_))
            }
        }

        #############################
        ### Render deleted items ####
        #############################

        [ReportDifferenceItem[]] $deletedItemsBaseTools = $DeletedItems | Where-Object { $_.IsBaseToolNode() }
        [ReportDifferenceItem[]] $deletedItemsTables = $DeletedItems | Where-Object { $_.IsTableNode() }
        if ($deletedItemsBaseTools.Count + $deletedItemsTables.Count -gt 0) {
            $sb.AppendLine("### Deleted :heavy_minus_sign:").AppendLine()
        }
        if ($deletedItemsBaseTools.Count -gt 0) {
            $tableItems = $deletedItemsBaseTools | ForEach-Object {
                [PSCustomObject]@{
                    "Category" = $this.RenderCategory($_.Headers, $true);
                    "Tool name" = $this.RenderToolName($_.PreviousReportNode.ToolName);
                    "Previous ($previousImageVersion)" = $_.PreviousReportNode.GetValue();
                }
            }
            $sb.AppendLine($this.RenderHtmlTable($tableItems, "Category"))
        }
        if ($deletedItemsTables.Count -gt 0) {
            $deletedItemsTables | ForEach-Object {
                $sb.AppendLine($this.RenderTableNodesDiff($_))
            }
        }

        #############################
        ### Render updated items ####
        #############################

        [ReportDifferenceItem[]] $changedItemsBaseTools = $ChangedItems | Where-Object { $_.IsBaseToolNode() }
        [ReportDifferenceItem[]] $changedItemsTables = $ChangedItems | Where-Object { $_.IsTableNode() }
        if ($changedItemsBaseTools.Count + $changedItemsTables.Count -gt 0) {
            $sb.AppendLine("### Updated").AppendLine()
        }
        if ($changedItemsBaseTools.Count -gt 0) {
            $tableItems = $changedItemsBaseTools | ForEach-Object {
                [PSCustomObject]@{
                    "Category" = $this.RenderCategory($_.Headers, $true);
                    "Tool name" = $this.RenderToolName($_.CurrentReportNode.ToolName);
                    "Previous ($previousImageVersion)" = $_.PreviousReportNode.GetValue();
                    "Current ($imageVersion)" = $_.CurrentReportNode.GetValue();
                }
            }
            $sb.AppendLine($this.RenderHtmlTable($tableItems, "Category"))
        }
        if ($changedItemsTables.Count -gt 0) {
            $changedItemsTables | ForEach-Object {
                $sb.AppendLine($this.RenderTableNodesDiff($_))
            }
        }

        return $sb.ToString()
    }

    [String] RenderHtmlTable([PSCustomObject[]] $Table, [String] $RowSpanColumnName) {
        $headers = $Table[0].PSObject.Properties.Name

        $sb = [System.Text.StringBuilder]::new()
        $sb.AppendLine("<table>")
        $sb.AppendLine("    <thead>")
        $headers | ForEach-Object {
            $sb.AppendLine("        <th>$_</th>")
        }
        $sb.AppendLine("    </thead>")
        $sb.AppendLine("    <tbody>")

        $tableRowSpans = $this.CalculateHtmlTableRowSpan($Table, $RowSpanColumnName)
        for ($rowIndex = 0; $rowIndex -lt $Table.Count; $rowIndex++) {
            $row = $Table[$rowIndex]

            $sb.AppendLine("        <tr>")
            $headers | ForEach-Object {
                if ($_ -eq $RowSpanColumnName) {
                    if ($tableRowSpans[$rowIndex] -gt 0) {
                        $sb.AppendLine("            <td rowspan=`"$($tableRowSpans[$rowIndex])`">$($row.$_)</td>")
                    } else {
                        # Skip rendering this cell at all
                    }
                } else {
                    $sb.AppendLine("            <td>$($row.$_)</td>")
                }
            }
            $sb.AppendLine("        </tr>")
        }
        $sb.AppendLine("    </tbody>")
        $sb.AppendLine("</table>")

        return $sb.ToString()
    }

    [int[]] CalculateHtmlTableRowSpan([PSCustomObject[]] $Table, [String] $keyColumn) {
        $result = @(0) * $Table.Count

        for ($rowIndex = $Table.Count - 1; $rowIndex -ge 0; $rowIndex--) {
            if (($rowIndex -lt ($Table.Count - 1)) -and ($Table[$rowIndex].$keyColumn -eq $Table[$rowIndex + 1].$keyColumn)) {
                # If the current row is the same as the next row
                # Then rowspan of current row should be equal to rowspan of the next row + 1
                # And rowspan of the next row should be 0 because it is already included in the rowspan of the current row
                $result[$rowIndex] = $result[$rowIndex + 1] + 1
                $result[$rowIndex + 1] = 0
            } else {
                $result[$rowIndex] = 1
            }
        }

        return $result
    }

    [String] RenderTableNodesDiff([ReportDifferenceItem] $DiffItem) {
        # Use the simplest approach for now: first, print all removed lines. Then print added lines
        # It will work well for most cases like changing existing rows, adding new rows and removing rows
        # But can produce not so pretty results for cases when some rows are changed and some rows are added at the same time
        # Let's see how it works in practice and improve it later if needed

        [String] $tableHeaders = ($DiffItem.CurrentReportNode ?? $DiffItem.PreviousReportNode).Headers
        [Collections.Generic.List[String]] $tableRows = @()
        $DiffItem.PreviousReportNode.Rows ?? @() | Where-Object { $_ -notin $DiffItem.CurrentReportNode.Rows } | ForEach-Object {
            $tableRows.Add($this.StrikeTableRow($_))
        }
        $DiffItem.CurrentReportNode.Rows ?? @() | Where-Object { $_ -notin $DiffItem.PreviousReportNode.Rows } | ForEach-Object {
            $tableRows.Add($_)
        }

        $sb = [System.Text.StringBuilder]::new()
        $sb.AppendLine("#### $($this.RenderCategory($DiffItem.Headers, $false))")
        $sb.AppendLine([TableNode]::new($tableHeaders, $tableRows).ToMarkdown())
        return $sb.ToString()
    }

    [String] RenderCategory([String[]] $Headers, [Boolean] $AddLineSeparator) {
        # Always skip the first header because it is "Installed Software"
        [String[]] $takeHeaders = $Headers | Select-Object -Skip 1
        if ($takeHeaders.Count -eq 0) {
            return ""
        }

        $lineSeparator = $AddLineSeparator ? "<br>": ""
        return [String]::Join(" >$lineSeparator ", $takeHeaders)
    }

    [String] RenderToolName([String] $ToolName) {
        return $ToolName.TrimEnd(":")
    }

    [String] StrikeTableRow([String] $Row) {
        # Convert "a|b|c" to "~~a~~|~~b~~|~~c~~
        $cells = $Row.Split("|")
        $strikedCells = $cells | ForEach-Object { "~~$($_)~~"}
        return [String]::Join("|", $strikedCells)
    }
}

# Temporary structure to store the single difference between two reports
class ReportDifferenceItem {
    [BaseNode] $PreviousReportNode
    [BaseNode] $CurrentReportNode
    [String[]] $Headers

    ReportDifferenceItem([BaseNode] $PreviousReportNode, [BaseNode] $CurrentReportNode, [String[]] $Headers) {
        $this.PreviousReportNode = $PreviousReportNode
        $this.CurrentReportNode = $CurrentReportNode
        $this.Headers = $Headers
    }

    [Boolean] IsBaseToolNode() {
        $node = $this.CurrentReportNode ?? $this.PreviousReportNode
        return $node -is [BaseToolNode]
    }

    [Boolean] IsTableNode() {
        $node = $this.CurrentReportNode ?? $this.PreviousReportNode
        return $node -is [TableNode]
    }
}