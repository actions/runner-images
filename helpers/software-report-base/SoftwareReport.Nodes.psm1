using module ./SoftwareReport.BaseNodes.psm1

#########################################
### Nodes to describe image software ####
#########################################

# NodesFactory is used to simplify parsing different types of notes
# Every node has own logic of parsing and this method just invokes "FromJsonObject" of correct node type
class NodesFactory {
    static [BaseNode] ParseNodeFromObject($jsonObj) {
        if ($jsonObj.NodeType -eq [HeaderNode].Name) {
            return [HeaderNode]::FromJsonObject($jsonObj)
        } elseif ($jsonObj.NodeType -eq [ToolNode].Name) {
            return [ToolNode]::FromJsonObject($jsonObj)
        } elseif ($jsonObj.NodeType -eq [ToolVersionsNode].Name) {
            return [ToolVersionsNode]::FromJsonObject($jsonObj)
        } elseif ($jsonObj.NodeType -eq [TableNode].Name) {
            return [TableNode]::FromJsonObject($jsonObj)
        } elseif ($jsonObj.NodeType -eq [NoteNode].Name) {
            return [NoteNode]::FromJsonObject($jsonObj)
        }

        throw "Unknown node type in ParseNodeFromObject '$($jsonObj.NodeType)'"
    }
}

# Node type to describe headers: "## Installed software"
class HeaderNode: BaseNode {
    [String] $Title
    [System.Collections.ArrayList] $Children

    HeaderNode([String] $Title) {
        $this.Title = $Title
        $this.Children = @()
    }

    [Boolean] ShouldBeIncludedToDiff() {
        return $True
    }

    [void] AddNode([BaseNode] $node) {
        $similarNode = $this.FindSimilarChildNode($node)
        if ($similarNode) {
            throw "This HeaderNode already contains the similar child node. It is not allowed to add the same node twice.`nFound node: $($similarNode.ToJsonObject() | ConvertTo-Json)`nNew node: $($node.ToJsonObject() | ConvertTo-Json)"
        }

        $this.Children.Add($node)
    }

    [void] AddNodes([Array] $nodes) {
        $nodes | ForEach-Object {
            $this.AddNode($_)
        }
    }

    [HeaderNode] AddHeaderNode([String] $Title) {
        $node = [HeaderNode]::new($Title)
        $this.AddNode($node)
        return $node
    }

    [void] AddToolNode([String] $ToolName, [String] $Version) {
        $this.AddNode([ToolNode]::new($ToolName, $Version))
    }

    [void] AddToolVersionsNode([String] $ToolName, [Array] $Version, [String] $MajorVersionRegex, [Boolean] $InlineList) {
        $this.AddNode([ToolVersionsNode]::new($ToolName, $Version, $MajorVersionRegex, $InlineList))
    }
     
    [void] AddTableNode([Array] $Table) {
       $this.AddNode([TableNode]::FromObjectsArray($Table))
    }

    [void] AddNoteNode([String] $Content) {
        $this.AddNode([NoteNode]::new($Content))
    }

    [String] ToMarkdown($level) {
        $sb = [System.Text.StringBuilder]::new()
        $sb.AppendLine()
        $sb.AppendLine("$("#" * $level) $($this.Title)")
        $this.Children  | ForEach-Object {
            $sb.AppendLine($_.ToMarkdown($level + 1))
        }

        return $sb.ToString().TrimEnd()
    }

    [PSCustomObject] ToJsonObject() {
        return [PSCustomObject]@{
            NodeType = $this.GetType().Name
            Title = $this.Title
            Children = $this.Children | ForEach-Object { $_.ToJsonObject() }
        }
    }

    static [HeaderNode] FromJsonObject($jsonObj) {
        $node = [HeaderNode]::new($jsonObj.Title)
        $jsonObj.Children | Where-Object { $_ } | ForEach-Object { $node.AddNode([NodesFactory]::ParseNodeFromObject($_)) }
        return $node
    }

    [Boolean] IsSimilarTo([BaseNode] $OtherNode) {
        if ($OtherNode.GetType() -ne [HeaderNode]) {
            return $false
        }

        return $this.Title -eq $OtherNode.Title
    }

    [Boolean] IsIdenticalTo([BaseNode] $OtherNode) {
        return $this.IsSimilarTo($OtherNode)
    }

    [BaseNode] FindSimilarChildNode([BaseNode] $Find) {
        foreach ($childNode in $this.Children) {
            if ($childNode.IsSimilarTo($Find)) {
                return $childNode
            }
        }

        return $null
    }
}

# Node type to describe the tool with single version: "Bash 5.1.16"
class ToolNode: BaseToolNode {
    [String] $Version

    ToolNode([String] $ToolName, [String] $Version): base($ToolName) {
        $this.Version = $Version
    }

    [String] ToMarkdown($level) {
        return "- $($this.ToolName) $($this.Version)"
    }

    [String] GetValue() {
        return $this.Version
    }

    [PSCustomObject] ToJsonObject() {
        return [PSCustomObject]@{
            NodeType = $this.GetType().Name
            ToolName = $this.ToolName
            Version = $this.Version
        }
    }

    static [BaseNode] FromJsonObject($jsonObj) {
        return [ToolNode]::new($jsonObj.ToolName, $jsonObj.Version)
    }
}

# Node type to describe the tool with multiple versions "Toolcache Node.js 14.17.6 16.2.0 18.2.3"
class ToolVersionsNode: BaseToolNode {
    [Array] $Versions
    [Regex] $MajorVersionRegex
    [String] $ListType

    ToolVersionsNode([String] $ToolName, [Array] $Versions, [String] $MajorVersionRegex, [Boolean] $InlineList): base($ToolName) {
        $this.Versions = $Versions
        $this.MajorVersionRegex = [Regex]::new($MajorVersionRegex)
        $this.ListType = $InlineList ? "Inline" : "List"
        $this.ValidateMajorVersionRegex()
    }

    [String] ToMarkdown($level) {
        if ($this.ListType -eq "Inline") {
            return "- $($this.ToolName): $($this.Versions -join ', ')"
        }

        $sb = [System.Text.StringBuilder]::new()
        $sb.AppendLine()
        $sb.AppendLine("$("#" * $level) $($this.ToolName)")
        $this.Versions | ForEach-Object {
            $sb.AppendLine("- $_")
        }

        return $sb.ToString().TrimEnd()
    }

    [String] GetValue() {
        return $this.Versions -join ', '
    }

    [String] ExtractMajorVersion([String] $Version) {
        $match = $this.MajorVersionRegex.Match($Version)
        if ($match.Success -ne $True) {
            throw "Version '$Version' doesn't match regex '$($this.PrimaryVersionRegex)'"
        }

        return $match.Groups[0].Value
    }

    [PSCustomObject] ToJsonObject() {
        return [PSCustomObject]@{
            NodeType = $this.GetType().Name
            ToolName = $this.ToolName
            Versions = $this.Versions
            MajorVersionRegex = $this.MajorVersionRegex.ToString()
            ListType = $this.ListType
        }
    }

    static [ToolVersionsNode] FromJsonObject($jsonObj) {
        return [ToolVersionsNode]::new($jsonObj.ToolName, $jsonObj.Versions, $jsonObj.MajorVersionRegex, $jsonObj.ListType -eq "Inline")
    }

    hidden [void] ValidateMajorVersionRegex() {
        $this.Versions | Group-Object { $this.ExtractMajorVersion($_) } | ForEach-Object {
            if ($_.Count -gt 1) {
                throw "Multiple versions from list $($this.GetValue()) return the same result from regex '$($this.MajorVersionRegex)': $($_.Name)"
            }
        }
    }
}

# Node type to describe tables
class TableNode: BaseNode {
    # It is easier to store the table as rendered lines because it will simplify finding differences in rows later
    [String] $Headers
    [System.Collections.ArrayList] $Rows

    TableNode($Headers, $Rows) {
        $this.Headers = $Headers
        $this.Rows = $Rows
    }

    [Boolean] ShouldBeIncludedToDiff() {
        return $True
    }

    static [TableNode] FromObjectsArray([Array] $Table) {
        # take column names from the first row in table because we expect all rows to have the same columns
        [String] $tableHeaders = [TableNode]::ArrayToTableRow($Table[0].PSObject.Properties.Name)
        [System.Collections.ArrayList] $tableRows = @()

        $Table | ForEach-Object {
            $tableRows.Add([TableNode]::ArrayToTableRow($_.PSObject.Properties.Value))
        }

        return [TableNode]::new($tableHeaders, $tableRows)
    }

    [String] ToMarkdown($level) {
        $maxColumnWidths = $this.Headers.Split("|") | ForEach-Object { $_.Length }
        $columnsCount = $maxColumnWidths.Count

        $this.Rows | ForEach-Object {
            $columnWidths = $_.Split("|") | ForEach-Object { $_.Length }
            for ($colIndex = 0; $colIndex -lt $columnsCount; $colIndex++) {
                $maxColumnWidths[$colIndex] = [Math]::Max($maxColumnWidths[$colIndex], $columnWidths[$colIndex])
            }
        }

        $delimeterLine = [String]::Join("|", @("-") * $columnsCount)

        $sb = [System.Text.StringBuilder]::new()
        @($this.Headers) + @($delimeterLine) + $this.Rows | ForEach-Object {
            $sb.Append("|")
            $row = $_.Split("|")

            for ($colIndex = 0; $colIndex -lt $columnsCount; $colIndex++) {
                $padSymbol = $row[$colIndex] -eq "-" ? "-" : " "
                $cellContent = $row[$colIndex].PadRight($maxColumnWidths[$colIndex], $padSymbol)
                $sb.Append(" $($cellContent) |")
            }
            
            $sb.AppendLine()
        }

        return $sb.ToString().TrimEnd()
    }

    [PSCustomObject] ToJsonObject() {
        return [PSCustomObject]@{
            NodeType = $this.GetType().Name
            Headers = $this.Headers
            Rows = $this.Rows
        }
    }

    static [TableNode] FromJsonObject($jsonObj) {
        return [TableNode]::new($jsonObj.Headers, $jsonObj.Rows)
    }

    [Boolean] IsSimilarTo([BaseNode] $OtherNode) {
        if ($OtherNode.GetType() -ne [TableNode]) {
            return $false
        }

        # We don't support having multiple TableNode instances on the same header level so such check is fine
        return $true
    }

    [Boolean] IsIdenticalTo([BaseNode] $OtherNode) {
        if (-not $this.IsSimilarTo($OtherNode)) {
            return $false
        }

        if ($this.Headers -ne $OtherNode.Headers) {
            return $false
        }

        if ($this.Rows.Count -ne $OtherNode.Rows.Count) {
            return $false
        }

        for ($rowIndex = 0; $rowIndex -lt $this.Rows.Count; $rowIndex++) {
            if ($this.Rows[$rowIndex] -ne $OtherNode.Rows[$rowIndex]) {
                return $false
            }
        }

        return $true
    }

    hidden static [String] ArrayToTableRow([Array] $Values) {
        # TO-DO: Add validation for the case when $Values contains "|"
        return [String]::Join("|", $Values)
    }
}

class NoteNode: BaseNode {
    [String] $Content

    NoteNode([String] $Content) {
        $this.Content = $Content
    }

    [String] ToMarkdown($level) {
        return @(
            '```',
            $this.Content,
            '```'
        ) -join "`n"
    }

    [PSCustomObject] ToJsonObject() {
        return [PSCustomObject]@{
            NodeType = $this.GetType().Name
            Content = $this.Content
        }
    }

    static [NoteNode] FromJsonObject($jsonObj) {
        return [NoteNode]::new($jsonObj.Content)
    }

    [Boolean] IsSimilarTo([BaseNode] $OtherNode) {
        if ($OtherNode.GetType() -ne [NoteNode]) {
            return $false
        }

        return $this.Content -eq $OtherNode.Content
    }

    [Boolean] IsIdenticalTo([BaseNode] $OtherNode) {
        return $this.IsSimilarTo($OtherNode)
    }
}
