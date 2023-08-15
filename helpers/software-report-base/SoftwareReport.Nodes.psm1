using module ./SoftwareReport.BaseNodes.psm1

#########################################
### Nodes to describe image software ####
#########################################

# NodesFactory is used to simplify parsing different types of notes
# Every node has own logic of parsing and this method just invokes "FromJsonObject" of correct node type
class NodesFactory {
    static [BaseNode] ParseNodeFromObject([object] $JsonObj) {
        if ($JsonObj.NodeType -eq [HeaderNode].Name) {
            return [HeaderNode]::FromJsonObject($JsonObj)
        } elseif ($JsonObj.NodeType -eq [ToolVersionNode].Name) {
            return [ToolVersionNode]::FromJsonObject($JsonObj)
        } elseif ($JsonObj.NodeType -eq [ToolVersionsListNode].Name) {
            return [ToolVersionsListNode]::FromJsonObject($JsonObj)
        } elseif ($JsonObj.NodeType -eq [TableNode].Name) {
            return [TableNode]::FromJsonObject($JsonObj)
        } elseif ($JsonObj.NodeType -eq [NoteNode].Name) {
            return [NoteNode]::FromJsonObject($JsonObj)
        }

        throw "Unknown node type in ParseNodeFromObject '$($JsonObj.NodeType)'"
    }
}

class HeaderNode: BaseNode {
    [ValidateNotNullOrEmpty()]
    [String] $Title
    [Collections.Generic.List[BaseNode]] $Children

    HeaderNode([String] $Title) {
        $this.Title = $Title
        $this.Children = @()
    }

    [Boolean] ShouldBeIncludedToDiff() {
        return $true
    }

    [void] AddNode([BaseNode] $node) {
        $similarNode = $this.FindSimilarChildNode($node)
        if ($similarNode) {
            throw "This HeaderNode already contains the similar child node. It is not allowed to add the same node twice.`nFound node: $($similarNode.ToJsonObject() | ConvertTo-Json)`nNew node: $($node.ToJsonObject() | ConvertTo-Json)"
        }

        if (-not $this.IsNodeHasMarkdownHeader($node)) {
            # If the node doesn't print own header to markdown, we should check that there is no other nodes that print header to markdown before it.
            # It is done to avoid unexpected situation like this:
            #
            # HeaderNode A                 -> # A
            #   HeaderNode B               -> ## B
            #   ToolVersionNode C          -> - C
            # ToolVersionNode D            -> - D
            # 
            # In this example, we add 'HeaderNode B" to 'HeaderNode A' and add 'ToolVersionNode C' to 'HeaderNode B'.
            # Then we add 'ToolVersionNode D' to 'HeaderNode A'.
            # But the result markdown will look like 'ToolVersionNode D' belongs to 'HeaderNode B' instead of 'HeaderNode A'.
            $this.Children | Where-Object { $this.IsNodeHasMarkdownHeader($_) } | ForEach-Object {
                throw "It is not allowed to add the non-header node after the header node. Consider adding the separate HeaderNode for this node"
            }
        }

        $this.Children.Add($node)
    }

    [void] AddNodes([BaseNode[]] $nodes) {
        $nodes | ForEach-Object {
            $this.AddNode($_)
        }
    }

    [HeaderNode] AddHeader([String] $Title) {
        $node = [HeaderNode]::new($Title)
        $this.AddNode($node)
        return $node
    }

    [void] AddToolVersion([String] $ToolName, [String] $Version) {
        $this.AddNode([ToolVersionNode]::new($ToolName, $Version))
    }

    [void] AddToolVersionsList([String] $ToolName, [String[]] $Version, [String] $MajorVersionRegex) {
        $this.AddNode([ToolVersionsListNode]::new($ToolName, $Version, $MajorVersionRegex, "List"))
    }

    [void] AddToolVersionsListInline([String] $ToolName, [String[]] $Version, [String] $MajorVersionRegex) {
        $this.AddNode([ToolVersionsListNode]::new($ToolName, $Version, $MajorVersionRegex, "Inline"))
    }
     
    [void] AddTable([PSCustomObject[]] $Table) {
       $this.AddNode([TableNode]::FromObjectsArray($Table))
    }

    [void] AddNote([String] $Content) {
        $this.AddNode([NoteNode]::new($Content))
    }

    [String] ToMarkdown([Int32] $Level) {
        $sb = [System.Text.StringBuilder]::new()
        $sb.AppendLine()
        $sb.AppendLine("$("#" * $Level) $($this.Title)")
        $this.Children  | ForEach-Object {
            $sb.AppendLine($_.ToMarkdown($Level + 1))
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

    static [HeaderNode] FromJsonObject([Object] $JsonObj) {
        $node = [HeaderNode]::new($JsonObj.Title)
        $JsonObj.Children | Where-Object { $_ } | ForEach-Object { $node.AddNode([NodesFactory]::ParseNodeFromObject($_)) }
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

    hidden [Boolean] IsNodeHasMarkdownHeader([BaseNode] $node) {
        if ($node -is [HeaderNode]) {
            return $true
        }

        if (($node -is [ToolVersionsListNode]) -and ($node.ListType -eq "List")) {
            return $true
        }

        return $false
    }
}

class ToolVersionNode: BaseToolNode {
    [ValidateNotNullOrEmpty()]
    [String] $Version

    ToolVersionNode([String] $ToolName, [String] $Version): base($ToolName) {
        $this.Version = $Version
    }

    [String] ToMarkdown([Int32] $Level) {
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

    static [BaseNode] FromJsonObject([Object] $JsonObj) {
        return [ToolVersionNode]::new($JsonObj.ToolName, $JsonObj.Version)
    }
}

class ToolVersionsListNode: BaseToolNode {
    [ValidateNotNullOrEmpty()]
    [String[]] $Versions

    [Regex] $MajorVersionRegex

    [ValidateSet("List", "Inline")]
    [String] $ListType

    ToolVersionsListNode([String] $ToolName, [String[]] $Versions, [String] $MajorVersionRegex, [String] $ListType): base($ToolName) {
        $this.Versions = $Versions
        $this.MajorVersionRegex = [Regex]::new($MajorVersionRegex)
        $this.ListType = $ListType
        $this.ValidateMajorVersionRegex()
    }

    [String] ToMarkdown([Int32] $Level) {
        if ($this.ListType -eq "Inline") {
            return "- $($this.ToolName): $($this.Versions -join ', ')"
        }

        $sb = [System.Text.StringBuilder]::new()
        $sb.AppendLine()
        $sb.AppendLine("$("#" * $Level) $($this.ToolName)")
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
        if (($match.Success -ne $true) -or [String]::IsNullOrEmpty($match.Groups[0].Value)) {
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

    static [ToolVersionsListNode] FromJsonObject([Object] $JsonObj) {
        return [ToolVersionsListNode]::new($JsonObj.ToolName, $JsonObj.Versions, $JsonObj.MajorVersionRegex, $JsonObj.ListType)
    }

    hidden [void] ValidateMajorVersionRegex() {
        $this.Versions | Group-Object { $this.ExtractMajorVersion($_) } | ForEach-Object {
            if ($_.Count -gt 1) {
                throw "Multiple versions from list '$($this.GetValue())' return the same result from regex '$($this.MajorVersionRegex)': $($_.Name)"
            }
        }
    }
}

class TableNode: BaseNode {
    # It is easier to store the table as rendered lines because it will simplify finding differences in rows later
    [ValidateNotNullOrEmpty()]
    [String] $Headers
    [ValidateNotNullOrEmpty()]
    [String[]] $Rows

    TableNode([String] $Headers, [String[]] $Rows) {
        $this.Headers = $Headers
        $this.Rows = $Rows
        
        $columnsCount = $this.Headers.Split("|").Count
        $this.Rows | ForEach-Object {
            if ($_.Split("|").Count -ne $columnsCount) {
                throw "Table has different number of columns in different rows"
            }
        }
    }

    [Boolean] ShouldBeIncludedToDiff() {
        return $true
    }

    [String] ToMarkdown([Int32] $Level) {
        $maxColumnWidths = $this.CalculateColumnsWidth()
        $columnsCount = $maxColumnWidths.Count

        $delimiterLine = [String]::Join("|", @("-") * $columnsCount)

        $sb = [System.Text.StringBuilder]::new()
        @($this.Headers) + @($delimiterLine) + $this.Rows | ForEach-Object {
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

    hidden [Int32[]] CalculateColumnsWidth() {
        $maxColumnWidths = $this.Headers.Split("|") | ForEach-Object { $_.Length }
        $columnsCount = $maxColumnWidths.Count

        $this.Rows | ForEach-Object {
            $columnWidths = $_.Split("|") | ForEach-Object { $_.Length }
            for ($colIndex = 0; $colIndex -lt $columnsCount; $colIndex++) {
                $maxColumnWidths[$colIndex] = [Math]::Max($maxColumnWidths[$colIndex], $columnWidths[$colIndex])
            }
        }

        return $maxColumnWidths
    }

    [PSCustomObject] ToJsonObject() {
        return [PSCustomObject]@{
            NodeType = $this.GetType().Name
            Headers = $this.Headers
            Rows = $this.Rows
        }
    }

    static [TableNode] FromJsonObject([Object] $JsonObj) {
        return [TableNode]::new($JsonObj.Headers, $JsonObj.Rows)
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

        # We don't compare $this.Headers intentionally
        # It is fine to ignore the tables where headers are changed but rows are not changed

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

    static [TableNode] FromObjectsArray([PSCustomObject[]] $Table) {
        if ($Table.Count -eq 0) {
            throw "Failed to create TableNode from empty objects array"
        }

        [String] $tableHeaders = [TableNode]::ArrayToTableRow($Table[0].PSObject.Properties.Name)
        [Collections.Generic.List[String]] $tableRows = @()

        $Table | ForEach-Object {
            $rowHeaders = [TableNode]::ArrayToTableRow($_.PSObject.Properties.Name)
            if (($rowHeaders -ne $tableHeaders)) {
                throw "Failed to create TableNode from objects array because objects have different properties"
            }

            $tableRows.Add([TableNode]::ArrayToTableRow($_.PSObject.Properties.Value))
        }

        return [TableNode]::new($tableHeaders, $tableRows)
    }

    hidden static [String] ArrayToTableRow([String[]] $Values) {
        if ($Values.Count -eq 0) {
            throw "Failed to create TableNode because some objects are empty"
        }
        $Values | ForEach-Object {
            if ($_.Contains("|")) {
                throw "Failed to create TableNode because some cells '$_' contains forbidden symbol '|'"
            }
        }

        return [String]::Join("|", $Values)
    }
}

class NoteNode: BaseNode {
    [ValidateNotNullOrEmpty()]
    [String] $Content

    NoteNode([String] $Content) {
        $this.Content = $Content
    }

    [String] ToMarkdown([Int32] $Level) {
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

    static [NoteNode] FromJsonObject([Object] $JsonObj) {
        return [NoteNode]::new($JsonObj.Content)
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
