using module ./SoftwareReport.Base.psm1

class SoftwareReportComparer {
    hidden [SoftwareReport] $PreviousReport
    hidden [SoftwareReport] $CurrentReport

    hidden [System.Collections.ArrayList] $AddedNodes
    hidden [System.Collections.ArrayList] $ChangedNodes
    hidden [System.Collections.ArrayList] $RemovedNodes

    SoftwareReportComparer([SoftwareReport] $PreviousReport, [SoftwareReport] $CurrentReport) {
        $this.PreviousReport = $PreviousReport
        $this.CurrentReport = $CurrentReport
    }

    [void] CompareReports() {
        $this.AddedNodes = @()
        $this.ChangedNodes = @()
        $this.RemovedNodes = @()

        $this.CompareInternal($this.PreviousReport.Root, $this.CurrentReport.Root, @())
    }

    hidden [void] CompareInternal([HeaderNode] $previousReportPointer, [HeaderNode] $currentReportPointer, [Array] $Headers) {
        $currentReportPointer.Children | Where-Object { $_ } | ForEach-Object {
            $currentReportNode = $_

            if ($currentReportNode.GetType().Name -in @("TableNode", "NoteNode")) {
                # Ignore TableNode and NoteNode for now
                # Will implement later
                return
            }

            $sameNodeInPreviousReport = $this.FindSimilarNode($previousReportPointer, $currentReportNode)
            if ($currentReportNode.GetType() -eq [HeaderNode]) {
                $newHeaders = $Headers + $currentReportNode.Title
                $this.CompareInternal($sameNodeInPreviousReport, $currentReportNode, $newHeaders)
            } else {
                if ($sameNodeInPreviousReport -and ($currentReportNode.IsIdenticalTo($sameNodeInPreviousReport))) {
                    # Nodes are identical, nothing changed, just ignore it
                } elseif ($sameNodeInPreviousReport) {
                    # Nodes are equal but not identical, so something was changed
                    $this.ChangedNodes.Add([ComparerItem]::new($sameNodeInPreviousReport, $currentReportNode, $Headers))
                } else {
                    # Node was not found in previous report, new node was added
                    $this.AddedNodes.Add([ComparerItem]::new($null, $currentReportNode, $Headers))
                }
            }
        }

        # Detecting nodes that were removed
        $previousReportPointer.Children | Where-Object { $_ } | ForEach-Object {
            $previousReportNode = $_
            $sameNodeInCurrentReport = $this.FindSimilarNode($currentReportPointer, $previousReportNode)

            if (-not $sameNodeInCurrentReport) {
                if ($previousReportNode.GetType() -eq [HeaderNode]) {
                    $newHeaders = $Headers + $previousReportNode.Title
                    $this.CompareInternal($previousReportNode, $null, $newHeaders)
                } else {
                    $this.RemovedNodes.Add([ComparerItem]::new($previousReportNode, $null, $Headers))
                }
                
            }
        }
    }

    [String] GetMarkdownResults() {
        $sb = [System.Text.StringBuilder]::new()
        $sb.AppendLine("## Added")
        $sb.AppendLine("| Tool | Notes |")
        $sb.AppendLine("| --- | --- |")
        $this.AddedNodes | ForEach-Object {
            $headers = ($_.Headers | Select-Object -Skip 1) -join " > "
            $sb.AppendLine("| $($_.NewNode.ToString()) | $($headers) |")
        }
        $sb.AppendLine()

        $sb.AppendLine("## Changed")
        $sb.AppendLine("| Previous | Current | Notes |")
        $sb.AppendLine("| --- | --- | --- |")
        $this.ChangedNodes | ForEach-Object {
            $headers = ($_.Headers | Select-Object -Skip 1) -join " > "
            $sb.AppendLine("| $($_.OldNode.ToString()) | $($_.NewNode.ToString()) | $($headers) |")
        }
        $sb.AppendLine()

        $sb.AppendLine("## Removed")
        $sb.AppendLine("| Tool | Notes |")
        $sb.AppendLine("| --- | --- |")
        $this.RemovedNodes | ForEach-Object {
            $headers = ($_.Headers | Select-Object -Skip 1) -join " > "
            $sb.AppendLine("| $($_.OldNode.ToString()) | $($headers) |")
        }

        return $sb.ToString()
    }

    hidden [BaseNode] FindSimilarNode([HeaderNode] $Node, [BaseNode] $Find) {
        if ($null -eq $Node) {
            return $null
        }

        $result = $Node.Children | Where-Object { $_.IsSimilarTo($Find) }

        if ($result.Count -eq 0) {
            return $null
        }

        return $result[0]
    }
}

class ComparerItem {
    [BaseNode] $OldNode
    [BaseNode] $NewNode
    [Array] $Headers

    ComparerItem([BaseNode] $OldNode, [BaseNode] $NewNode, [Array] $Headers) {
        $this.OldNode = $OldNode
        $this.NewNode = $NewNode
        $this.Headers = $Headers
    }
}