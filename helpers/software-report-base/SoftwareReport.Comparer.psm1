using module ./SoftwareReport.psm1
using module ./SoftwareReport.BaseNodes.psm1
using module ./SoftwareReport.Nodes.psm1


# SoftwareReportComparer is used to calculate differences between two SoftwareReport objects
class SoftwareReportComparer {
    hidden [SoftwareReport] $PreviousReport
    hidden [SoftwareReport] $CurrentReport

    hidden [Collections.Generic.List[ReportDifferenceItem]] $AddedItems
    hidden [Collections.Generic.List[ReportDifferenceItem]] $ChangedItems
    hidden [Collections.Generic.List[ReportDifferenceItem]] $DeletedItems

    SoftwareReportComparer([SoftwareReport] $PreviousReport, [SoftwareReport] $CurrentReport) {
        $this.PreviousReport = $PreviousReport
        $this.CurrentReport = $CurrentReport
    }

    [void] CompareReports() {
        $this.AddedItems = @()
        $this.ChangedItems = @()
        $this.DeletedItems = @()

        $this.CompareInternal($this.PreviousReport.Root, $this.CurrentReport.Root, @())
    }

    hidden [void] CompareInternal([HeaderNode] $previousReportPointer, [HeaderNode] $currentReportPointer, [Array] $Headers) {
        $currentReportPointer.Children ?? @() | Where-Object { $_.ShouldBeIncludedToDiff() -and $this.FilterExcludedNodes($_) } | ForEach-Object {
            $currentReportNode = $_
            $sameNodeInPreviousReport = $previousReportPointer ? $previousReportPointer.FindSimilarChildNode($currentReportNode) : $null

            if ($currentReportNode -is [HeaderNode]) {
                $this.CompareInternal($sameNodeInPreviousReport, $currentReportNode, $Headers + $currentReportNode.Title)
            } else {
                if ($sameNodeInPreviousReport -and ($currentReportNode.IsIdenticalTo($sameNodeInPreviousReport))) {
                    # Nodes are identical, nothing changed, just ignore it
                } elseif ($sameNodeInPreviousReport) {
                    # Nodes are equal but not identical, so something was changed
                    if ($currentReportNode -is [TableNode]) {
                        $this.CompareSimilarTableNodes($sameNodeInPreviousReport, $currentReportNode, $Headers)
                    } elseif ($currentReportNode -is [ToolVersionsNode]) {
                        $this.CompareSimilarToolVersionsListNodes($sameNodeInPreviousReport, $currentReportNode, $Headers)
                    } else {
                        $this.ChangedItems.Add([ReportDifferenceItem]::new($sameNodeInPreviousReport, $currentReportNode, $Headers))
                    }
                } else {
                    # Node was not found in previous report, new node was added
                    $this.AddedItems.Add([ReportDifferenceItem]::new($null, $currentReportNode, $Headers))
                }
            }
        }

        # Detecting nodes that were removed
        $previousReportPointer.Children ?? @() | Where-Object { $_.ShouldBeIncludedToDiff() -and $this.FilterExcludedNodes($_) } | ForEach-Object {
            $previousReportNode = $_
            $sameNodeInCurrentReport = $currentReportPointer ? $currentReportPointer.FindSimilarChildNode($previousReportNode) : $null

            if (-not $sameNodeInCurrentReport) {
                if ($previousReportNode -is [HeaderNode]) {
                    $this.CompareInternal($previousReportNode, $null, $Headers + $previousReportNode.Title)
                } else {
                    $this.DeletedItems.Add([ReportDifferenceItem]::new($previousReportNode, $null, $Headers))
                }
            }
        }
    }

    hidden [void] CompareSimilarTableNodes([TableNode] $PreviousReportNode, [TableNode] $CurrentReportNode, [Array] $Headers) {
        $addedRows = $CurrentReportNode.Rows | Where-Object { $_ -notin $PreviousReportNode.Rows }
        $deletedRows = $PreviousReportNode.Rows | Where-Object { $_ -notin $CurrentReportNode.Rows }

        if (($addedRows.Count -gt 0) -and ($deletedRows.Count -eq 0)) {
            $this.AddedItems.Add([ReportDifferenceItem]::new($PreviousReportNode, $CurrentReportNode, $Headers))
        } elseif (($deletedRows.Count -gt 0) -and ($addedRows.Count -eq 0)) {
            $this.DeletedItems.Add([ReportDifferenceItem]::new($PreviousReportNode, $CurrentReportNode, $Headers))
        } else {
            $this.ChangedItems.Add([ReportDifferenceItem]::new($PreviousReportNode, $CurrentReportNode, $Headers))
        }
    }

    hidden [void] CompareSimilarToolVersionsListNodes([ToolVersionsNode] $PreviousReportNode, [ToolVersionsNode] $CurrentReportNode, [Array] $Headers) {
        $previousReportMajorVersions = $PreviousReportNode.Versions | ForEach-Object { $PreviousReportNode.ExtractMajorVersion($_) }
        $currentReportMajorVersion = $CurrentReportNode.Versions | ForEach-Object { $CurrentReportNode.ExtractMajorVersion($_) }

        $addedVersions = $CurrentReportNode.Versions | Where-Object { $CurrentReportNode.ExtractMajorVersion($_) -notin $previousReportMajorVersions }
        $deletedVersions = $PreviousReportNode.Versions | Where-Object { $PreviousReportNode.ExtractMajorVersion($_) -notin $currentReportMajorVersion }
        $changedPreviousVersions = $PreviousReportNode.Versions | Where-Object { ($PreviousReportNode.ExtractMajorVersion($_) -in $currentReportMajorVersion) -and ($_ -notin $CurrentReportNode.Versions) }
        $changedCurrentVersions = $CurrentReportNode.Versions | Where-Object { ($CurrentReportNode.ExtractMajorVersion($_) -in $previousReportMajorVersions) -and ($_ -notin $PreviousReportNode.Versions) }

        if ($addedVersions.Count -gt 0) {
            $this.AddedItems.Add([ReportDifferenceItem]::new($null, [ToolVersionsNode]::new($CurrentReportNode.ToolName, $addedVersions, $CurrentReportNode.MajorVersionRegex, $True), $Headers))
        }

        if ($deletedVersions.Count -gt 0) {
            $this.DeletedItems.Add([ReportDifferenceItem]::new([ToolVersionsNode]::new($PreviousReportNode.ToolName, $deletedVersions, $PreviousReportNode.MajorVersionRegex, $True), $null, $Headers))
        }

        $previousChangedNode = ($changedPreviousVersions.Count -gt 0) ? [ToolVersionsNode]::new($PreviousReportNode.ToolName, $changedPreviousVersions, $PreviousReportNode.MajorVersionRegex, $True) : $null
        $currentChangedNode = ($changedCurrentVersions.Count -gt 0) ? [ToolVersionsNode]::new($CurrentReportNode.ToolName, $changedCurrentVersions, $CurrentReportNode.MajorVersionRegex, $True) : $null
        if ($previousChangedNode -and $currentChangedNode) {
            $this.ChangedItems.Add([ReportDifferenceItem]::new($previousChangedNode, $currentChangedNode, $Headers))
        }
    }

    [String] GetMarkdownReport() {
        $reporter = [SoftwareReportComparerReport]::new()
        $report = $reporter.GenerateMarkdownReport($this.CurrentReport, $this.PreviousReport, $this.AddedItems, $this.ChangedItems, $this.DeletedItems)
        return $report
    }

    hidden [Boolean] FilterExcludedNodes([BaseNode] $Node) {
        # We shouldn't show "Image Version" diff because it is already shown in report header
        if (($Node -is [ToolNode]) -and ($Node.ToolName -eq "Image Version:")) {
            return $False
        }

        return $True
    }
}

# SoftwareReportComparerReport is used to render results of SoftwareReportComparer in markdown format
class SoftwareReportComparerReport {
    [String] GenerateMarkdownReport([SoftwareReport] $CurrentReport, [SoftwareReport] $PreviousReport, [ReportDifferenceItem[]] $AddedItems, [ReportDifferenceItem[]] $ChangedItems, [ReportDifferenceItem[]] $DeletedItems) {
        $sb = [System.Text.StringBuilder]::new()

        $rootNode = $CurrentReport.Root
        $imageVersion = $this.GetImageVersion($CurrentReport)
        $previousImageVersion = $this.GetImageVersion($PreviousReport)

        #############################
        ### Render report header ####
        #############################

        $sb.AppendLine("# :desktop_computer: Actions Runner Image: $($rootNode.Title)")

        # ToolNodes on root level contains main image description so just copy-paste them to final report
        $rootNode.Children | Where-Object { $_ -is [BaseToolNode] } | ForEach-Object {
            $sb.AppendLine($_.ToMarkdown(0))
        }
        $sb.AppendLine()

        $sb.AppendLine("## :mega: What's changed?")

        ###########################
        ### Render added items ####
        ###########################

        [ReportDifferenceItem[]] $addedItemsExcludeTables = $AddedItems | Where-Object { $_.IsBaseToolNode() }
        if ($addedItemsExcludeTables.Count -gt 0) {
            $tableItems = $addedItemsExcludeTables | ForEach-Object {
                [PSCustomObject]@{
                    "Category" = $this.RenderCategory($_.Headers, $True);
                    "Tool name" = $this.RenderToolName($_.CurrentReportNode.ToolName);
                    "Current ($imageVersion)" = $_.CurrentReportNode.GetValue();
                }
            }

            $sb.AppendLine("### Added :heavy_plus_sign:")
            $sb.AppendLine($this.RenderHtmlTable($tableItems, "Category"))
        }

        # Render added tables separately
        $AddedItems | Where-Object { $_.IsTableNode() } | ForEach-Object {
            $sb.AppendLine($this.RenderTableNodesDiff($_))
        }

        #############################
        ### Render deleted items ####
        #############################

        [ReportDifferenceItem[]] $deletedItemsExcludeTables = $DeletedItems | Where-Object { $_.IsBaseToolNode() }
        if ($deletedItemsExcludeTables.Count -gt 0) {
            $tableItems = $deletedItemsExcludeTables | ForEach-Object {
                [PSCustomObject]@{
                    "Category" = $this.RenderCategory($_.Headers, $True);
                    "Tool name" = $this.RenderToolName($_.PreviousReportNode.ToolName);
                    "Previous ($previousImageVersion)" = $_.PreviousReportNode.GetValue();
                }
            }

            $sb.AppendLine("### Deleted :heavy_minus_sign:")
            $sb.AppendLine($this.RenderHtmlTable($tableItems, "Category"))
        }

        # Render deleted tables separately
        $DeletedItems | Where-Object { $_.IsTableNode() } | ForEach-Object {
            $sb.AppendLine($this.RenderTableNodesDiff($_))
        }

        #############################
        ### Render updated items ####
        #############################

        [ReportDifferenceItem[]] $changedItemsExcludeTables = $ChangedItems | Where-Object { $_.IsBaseToolNode() }
        if ($changedItemsExcludeTables.Count -gt 0) {
            $tableItems = $changedItemsExcludeTables | ForEach-Object {
                [PSCustomObject]@{
                    "Category" = $this.RenderCategory($_.Headers, $True);
                    "Tool name" = $this.RenderToolName($_.CurrentReportNode.ToolName);
                    "Previous ($previousImageVersion)" = $_.PreviousReportNode.GetValue();
                    "Current ($imageVersion)" = $_.CurrentReportNode.GetValue();
                }
            }

            $sb.AppendLine("### Updated")
            $sb.AppendLine($this.RenderHtmlTable($tableItems, "Category"))
        }

        # Render updated tables separately
        $ChangedItems | Where-Object { $_.IsTableNode() } | ForEach-Object {
            $sb.AppendLine($this.RenderTableNodesDiff($_))
        }

        return $sb.ToString()
    }

    [String] RenderHtmlTable([PSCustomObject[]] $Table, $RowSpanColumnName) {
        $headers = $Table[0].PSObject.Properties.Name

        $sb = [System.Text.StringBuilder]::new()
        $sb.AppendLine("<table>")
        $sb.AppendLine("  <thead>")
        $headers | ForEach-Object {
            $sb.AppendLine("    <th>$_</th>")
        }
        $sb.AppendLine("  </thead>")
        $sb.AppendLine("  <tbody>")

        $tableRowSpans = $this.CalculateHtmlTableRowSpan($Table, $RowSpanColumnName)
        for ($rowIndex = 0; $rowIndex -lt $Table.Count; $rowIndex++) {
            $row = $Table[$rowIndex]

            $sb.AppendLine("    <tr>")
            $headers | ForEach-Object {
                if ($_ -eq $RowSpanColumnName) {
                    if ($tableRowSpans[$rowIndex] -gt 0) {
                        $sb.AppendLine("      <td rowspan=$($tableRowSpans[$rowIndex])>$($row.$_)</td>")
                    } else {
                        # Skip rendering this cell at all
                    }
                } else {
                    $sb.AppendLine("      <td>$($row.$_)</td>")
                }
            }
            $sb.AppendLine("    </tr>")
        }
        $sb.AppendLine("  </tbody>")
        $sb.AppendLine("</table>")

        return $sb.ToString()
    }

    [int[]] CalculateHtmlTableRowSpan([PSCustomObject[]] $Table, $keyColumn) {
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
        [System.Collections.ArrayList] $tableRows = @()
        $DiffItem.PreviousReportNode.Rows ?? @() | Where-Object { $_ -notin $DiffItem.CurrentReportNode.Rows } | ForEach-Object {
            $tableRows.Add($this.StrikeTableRow($_))
        }
        $DiffItem.CurrentReportNode.Rows ?? @() | Where-Object { $_ -notin $DiffItem.PreviousReportNode.Rows } | ForEach-Object {
            $tableRows.Add($_)
        }

        $sb = [System.Text.StringBuilder]::new()
        $sb.AppendLine("#### $($this.RenderCategory($DiffItem.Headers, $False))")
        $sb.AppendLine([TableNode]::new($tableHeaders, $tableRows).ToMarkdown(0))
        return $sb.ToString()
    }

    [String] RenderCategory([Array] $Headers, [Boolean] $AddLineSeparator) {
        # Always skip the first header because it is "Installed Software"
        [Array] $takeHeaders = $Headers | Select-Object -Skip 1
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

    [String] GetImageVersion([SoftwareReport] $Report) {
        $imageVersionNode = $Report.Root.Children ?? @() | Where-Object { ($_ -is [ToolNode]) -and ($_.ToolName -eq "Image Version:") } | Select-Object -First 1
        return $imageVersionNode.Version ?? "Unknown version"
    }
}

# Temporary structure to store the single difference between two reports
class ReportDifferenceItem {
    [BaseNode] $PreviousReportNode
    [BaseNode] $CurrentReportNode
    [Array] $Headers

    ReportDifferenceItem([BaseNode] $PreviousReportNode, [BaseNode] $CurrentReportNode, [Array] $Headers) {
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