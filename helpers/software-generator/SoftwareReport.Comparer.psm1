using module ./SoftwareReport.Base.psm1

class SoftwareReportComparer {
    hidden [SoftwareReport] $PreviousReport
    hidden [SoftwareReport] $CurrentReport

    hidden [System.Collections.ArrayList] $AddedItems
    hidden [System.Collections.ArrayList] $ChangedItems
    hidden [System.Collections.ArrayList] $DeletedItems

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
        $currentReportPointer.Children | Where-Object { $_ } | ForEach-Object {
            $currentReportNode = $_

            if ($currentReportNode.GetType() -eq [NoteNode]) {
                # Ignore NoteNode changes from diff
                return
            }

            $sameNodeInPreviousReport = $this.FindSimilarNode($previousReportPointer, $currentReportNode)
            if ($currentReportNode.GetType() -eq [HeaderNode]) {
                $this.CompareInternal($sameNodeInPreviousReport, $currentReportNode, $Headers + $currentReportNode.Title)
            } else {
                if ($sameNodeInPreviousReport -and ($currentReportNode.IsIdenticalTo($sameNodeInPreviousReport))) {
                    # Nodes are identical, nothing changed, just ignore it
                } elseif ($sameNodeInPreviousReport) {
                    # Nodes are equal but not identical, so something was changed
                    $this.ChangedItems.Add([DiffItem]::new($sameNodeInPreviousReport, $currentReportNode, $currentReportPointer, $Headers))
                } else {
                    # Node was not found in previous report, new node was added
                    $this.AddedItems.Add([DiffItem]::new($null, $currentReportNode, $currentReportPointer, $Headers))
                }
            }
        }

        # Detecting nodes that were removed
        $previousReportPointer.Children | Where-Object { $_ } | ForEach-Object {
            $previousReportNode = $_
            $sameNodeInCurrentReport = $this.FindSimilarNode($currentReportPointer, $previousReportNode)

            if (-not $sameNodeInCurrentReport) {
                if ($previousReportNode.GetType() -eq [HeaderNode]) {
                    $this.CompareInternal($previousReportNode, $null, $Headers + $previousReportNode.Title)
                } else {
                    $this.DeletedItems.Add([DiffItem]::new($previousReportNode, $null, $currentReportPointer, $Headers))
                }
                
            }
        }
    }

    [String] GetMarkdownResults() {
        $sb = [System.Text.StringBuilder]::new()

        $rootNode = $this.CurrentReport.Root
        $imageVersion = $this.GetImageVersion()

        $sb.AppendLine("# :desktop_computer: $($rootNode.Title)")
        $rootNode.Children | Where-Object { $_.GetType() -ne [HeaderNode] } | ForEach-Object {
            $sb.AppendLine($_.ToMarkdown(0))
        }
        $sb.AppendLine()

        $sb.AppendLine("## :mega: What's changed?")

        # Render updated items
        $sb.AppendLine("### Updated")
        $sb.AppendLine("| Category | Previous ($imageVersion) | Current ($imageVersion) |")
        $sb.AppendLine("| --- | --- | --- |")
        $this.ChangedItems | Where-Object { $this.FilterReportItems($_) } | ForEach-Object {
            $sb.AppendLine("| $($this.RenderCategory($_.Headers)) | $($_.OldNode.ToString()) | $($_.NewNode.ToString()) |")
        }
        $sb.AppendLine()

        # Render updated tables separately
        $this.ChangedItems | Where-Object { $_.NewNode.GetType() -eq [TableNode] } | ForEach-Object {
            $sb.AppendLine($this.RenderTableDiff($_.OldNode, $_.NewNode, $_.ParentNode))
        }
        
        # Render added items
        $sb.AppendLine("### Added :heavy_plus_sign:")
        $sb.AppendLine("| Category | Current ($imageVersion) |")
        $sb.AppendLine("| --- | --- |")
        $this.AddedItems | Where-Object { $this.FilterReportItems($_) } | ForEach-Object {
            $sb.AppendLine("| $($this.RenderCategory($_.Headers)) | $($_.NewNode.ToString()) |")
        }
        $sb.AppendLine()

        # Render added tables separately
        $this.AddedItems | Where-Object { $_.NewNode.GetType() -eq [TableNode] } | ForEach-Object {
            $sb.AppendLine($this.RenderTableDiff($_.OldNode, $_.NewNode, $_.ParentNode))
        }

        # Render deleted items
        $sb.AppendLine("### Deleted :heavy_minus_sign:")
        $sb.AppendLine("| Category | Previous ($imageVersion) |")
        $sb.AppendLine("| --- | --- |")
        $this.DeletedItems | Where-Object { $this.FilterReportItems($_) } | ForEach-Object {
            $sb.AppendLine("| $($this.RenderCategory($_.Headers)) | $($_.OldNode.ToString()) |")
        }

        # Render deleted tables separately
        $this.DeletedItems | Where-Object { $_.OldNode.GetType() -eq [TableNode] } | ForEach-Object {
            $sb.AppendLine($this.RenderTableDiff($_.OldNode, $_.NewNode, $_.ParentNode))
        }

        return $sb.ToString()
    }

    hidden [BaseNode] FindSimilarNode([HeaderNode] $Node, [BaseNode] $Find) {
        if ($null -eq $Node) {
            return $null
        }

        foreach ($childNode in $Node.Children) {
            if ($childNode.IsSimilarTo($Find)) {
                return $childNode
            }
        }

        return $null
    }

    hidden [String] RenderCategory([Array] $Headers) {
        # Skip the first header because it is 
        [Array] $takeHeaders = $Headers | Select-Object -Skip 1

        if ($takeHeaders.Count -eq 0) {
            return ""
        }

        return [String]::Join(" ><br>", $takeHeaders)
    }

    hidden [String] RenderTableDiff([TableNode] $OldNode, [TableNode] $NewNode, [HeaderNode] $ParentNode) {
        # Use the simplest approach for now - First, print all removed lines. Then print added lines
        # It will work well for most cases like changing existing rows, adding new rows and removing rows
        # But can produce not so pretty results for cases when some rows are changed and some rows are added at the same time
        # Let's see how it works in practice and improve it later if needed

        [String] $tableHeaders = $NewNode.Headers ?? $OldNode.Headers
        [System.Collections.ArrayList] $tableRows = @()
        $OldNode.Rows | Where-Object { $_ } | ForEach-Object {
            if ($_ -notin $NewNode.Rows) {
                $tableRows.Add($this.StrikeTableRow($_))
            }
        }
        $NewNode.Rows | Where-Object { $_ } | ForEach-Object {
            if ($_ -notin $OldNode.Rows) {
                $tableRows.Add($_)
            }
        }
        $tableNode = [TableNode]::new($tableHeaders, $tableRows)

        $sb = [System.Text.StringBuilder]::new()
        $sb.AppendLine("#### $($ParentNode.Title)")
        $sb.AppendLine($tableNode.ToMarkdown(0))
        return $sb.ToString()
    }

    hidden [String] StrikeTableRow([String] $Row) {
        $cells = $Row.Split("|")
        $strikedCells = $cells | ForEach-Object { "~~$($_)~~"}
        return [String]::Join("|", $strikedCells)
    }

    hidden [String] GetImageVersion() {
        $rootNode = $this.CurrentReport.Root
        $imageVersionNode = $rootNode.Children | Where-Object { 
            ($_.GetType() -eq [ToolNode]) -and ($_.ToolName -match "Image Version")
        } | Select-Object -First 1
        
        return $imageVersionNode.Version ?? "Unknown version"
    }

    hidden [Boolean] FilterReportItems([DiffItem] $DiffItem) {
        $node = $DiffItem.NewNode ?? $DiffItem.OldNode
        if ($node.GetType() -eq [TableNode]) { return $False } # Ignore table nodes because we will render them separately
        if (($node.GetType() -eq [ToolNode]) -and ($node.ToolName -eq "Image version:")) { return $False } # Ignore because we already show image version in column headers 
        return $True
    }

    hidden [String] FormatTableRowForCompare([String] $String) {
        return $String.ToLower()[-1..-$string.Length] -join ''
    }
}

class DiffItem {
    [BaseNode] $OldNode
    [BaseNode] $NewNode
    [HeaderNode] $ParentNode
    [Array] $Headers

    DiffItem([BaseNode] $OldNode, [BaseNode] $NewNode, [HeaderNode] $ParentNode, [Array] $Headers) {
        $this.OldNode = $OldNode
        $this.NewNode = $NewNode
        $this.ParentNode = $ParentNode
        $this.Headers = $Headers
    }
}