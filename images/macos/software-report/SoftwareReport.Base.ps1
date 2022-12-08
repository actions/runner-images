class SoftwareReport {
    [HeaderNode] $Root

    SoftwareReport([String] $Title) {
        $this.Root = [HeaderNode]::new($Title)
    }

    SoftwareReport([HeaderNode] $Root) {
        $this.Root = $Root
    }

    [String] ToJson() {
        return $this.Root.ToJsonObject() | ConvertTo-Json -Depth 10
    }

    static [SoftwareReport] FromJson($jsonString) {
        $jsonObj = $jsonString | ConvertFrom-Json
        $rootNode = [SoftwareReport]::ParseNodeFromObject($jsonObj)
        return [SoftwareReport]::new($rootNode)
    }

    [String] ToMarkdown() {
        return $this.Root.ToMarkdown(1).Trim()
    }

    # This method is Nodes factory that simplifies parsing different types of notes
    # Every node has own logic of parsing and this method just invokes "FromJsonObject" of correct node type
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

# class BaseNode doesn't really have any business logic or functionality
# We just create it to unite all types of Nodes and differ them from "object" type
class BaseNode {}

# It is a node type to describe headers: "# Node.js"
# Header has Title and children nodes (HeaderNode is the single node type who has children)
class HeaderNode: BaseNode {
    [String] $Title
    [System.Collections.ArrayList] $Children

    HeaderNode([String] $Title) {
        $this.Title = $Title
        $this.Children = @()
    }

    [void] AddNode([BaseNode] $node) {
        if ($node.GetType() -eq [TableNode]) {
            $existingTableNodesCount = $this.Children.Where({ $_.GetType() -eq [TableNode] }).Count
            if ($existingTableNodesCount -gt 0) {
                throw "Having multiple TableNode on the same header level is not supported"
            }
        }

        $this.Children.Add($node)
    }

    [void] AddNodes([Array] $nodes) {
        $nodes | ForEach-Object { $this.AddNode($_) }
    }

    [HeaderNode] AddHeaderNode([String] $Title) {
        $node = [HeaderNode]::new($Title)
        $this.AddNode($node)
        return $node
    }

    [void] AddToolNode([String] $ToolName, [String] $Version) {
        $this.AddNode([ToolNode]::new($ToolName, $Version))
    }

    [void] AddToolVersionsNode([String] $ToolName, [Array] $Version) {
        $this.AddNode([ToolVersionsNode]::new($ToolName, $Version))
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
        $jsonObj.Children | Where-Object { $_ } | ForEach-Object { $node.AddNode([SoftwareReport]::ParseNodeFromObject($_)) }
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
}

# It is a node type to describe the single tool "Bash 5.1.16(1)-release"
class ToolNode: BaseNode {
    [String] $ToolName
    [String] $Version

    ToolNode([String] $ToolName, [String] $Version) {
        $this.ToolName = $ToolName
        $this.Version = $Version
    }

    [String] ToMarkdown($level) {
        return "- $($this.ToolName) $($this.Version)"
    }

    [String] ToString() {
        return "$($this.ToolName) $($this.Version)"
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

    [Boolean] IsSimilarTo([BaseNode] $OtherNode) {
        if ($OtherNode.GetType() -ne [ToolNode]) {
            return $false
        }

        # Don't compare by Version in SimilarTo method
        # It is necessary to treat changing of tool version as "ChangedNodes" rather than "RemovedNodes" + "AddedNodes"
        return $this.ToolName -eq $OtherNode.ToolName
    }

    [Boolean] IsIdenticalTo([BaseNode] $OtherNode) {
        return $this.IsSimilarTo($OtherNode) -and $this.Version -eq $OtherNode.Version
    }
}

# It is a node type to describe the single tool "Toolcache Node.js 14.17.6 16.2.0 18.2.3"
class ToolVersionsNode: BaseNode {
    [String] $ToolName
    [Array] $Versions

    ToolVersionsNode([String] $ToolName, [Array] $Versions) {
        $this.ToolName = $ToolName
        $this.Versions = $Versions
    }

    [String] ToMarkdown($level) {
        $sb = [System.Text.StringBuilder]::new()
        $sb.AppendLine()
        $sb.AppendLine("$("#" * $level) $($this.ToolName)")
        $this.Versions | ForEach-Object {
            $sb.AppendLine("- $_")
        }

        return $sb.ToString().TrimEnd()
    }

    [String] ToString() {
        return "$($this.ToolName) $($this.Versions -join ', ')"
    }

    [PSCustomObject] ToJsonObject() {
        return [PSCustomObject]@{
            NodeType = $this.GetType().Name
            ToolName = $this.ToolName
            Versions = $this.Versions
        }
    }

    static [ToolVersionsNode] FromJsonObject($jsonObj) {
        return [ToolVersionsNode]::new($jsonObj.ToolName, $jsonObj.Versions)
    }

    [Boolean] IsSimilarTo([BaseNode] $OtherNode) {
        if ($OtherNode.GetType() -ne [ToolVersionsNode]) {
            return $false
        }

        return $this.ToolName -eq $OtherNode.ToolName
    }

    [Boolean] IsIdenticalTo([BaseNode] $OtherNode) {
        if (-not $this.IsSimilarTo($OtherNode)) {
            return $false
        }

        return ($this.Versions -join " ") -eq ($OtherNode.Versions -join " ")
    }
}

# It is a node type to describe tables
class TableNode: BaseNode {
    # It is easier to store the table as rendered lines because we will simplify finding differences in rows later
    [String] $Headers
    [System.Collections.ArrayList] $Rows

    TableNode($Headers, $Rows) {
        $this.Headers = $Headers
        $this.Rows = $Rows
    }

    static [TableNode] FromObjectsArray([Array] $Table) {
        # take column names from the first row in table because all rows that should have the same columns
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