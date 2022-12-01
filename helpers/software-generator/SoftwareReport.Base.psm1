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
        return $this.Root.ToMarkdown(1)
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
        $this.Children.Add($node)
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
       $this.AddNode([TableNode]::new($Table))
    }

    [void] AddNoteNode([String] $Content) {
        $this.AddNode([NoteNode]::new($Content))
    }

    [String] ToMarkdown($level) {
        $sb = [System.Text.StringBuilder]::new()
        $sb.AppendLine("$("#" * $level) $($this.Title)")
        $this.Children  | ForEach-Object {
            $sb.AppendLine($_.ToMarkdown($level + 1))
        }

        # Preserve only one new line symbol at the end
        return $sb.ToString().TrimEnd() + "`n"
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
        $sb.AppendLine("$("#" * $level) $($this.ToolName)")
        $this.Versions | ForEach-Object {
            $sb.AppendLine("- $_")
        }

        # Preserve only one new line symbol at the end
        return $sb.ToString().TrimEnd() + "`n"
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
    [System.Collections.ArrayList] $Rows

    TableNode() {}

    TableNode([Array] $Table) {
        # It is easier to store the table as rendered lines because we will simplify finding differences in rows later
        # So we render table right now

        # take column names from the first row in table because all rows that should have the same columns
        $headers = $Table[0].PSObject.Properties.Name

        $this.Rows = @()
        $this.Rows.Add($this.ArrayToTableRow($headers))
        $this.Rows.Add($this.ArrayToTableRow(@("-") * $headers.Count))
        $Table | ForEach-Object {
            $this.Rows.Add($this.ArrayToTableRow($_.PSObject.Properties.Value))
        }
    }

    hidden [String] ArrayToTableRow([Array] $Values) {
        return "| " + [String]::Join(" | ", $Values) + " |"
    }

    [String] ToMarkdown($level) {
        return $this.Rows -join "`n"
    }

    [PSCustomObject] ToJsonObject() {
        return [PSCustomObject]@{
            NodeType = $this.GetType().Name
            Rows = $this.Rows
        }
    }

    static [TableNode] FromJsonObject($jsonObj) {
        $node = [TableNode]::new()
        $node.Rows = $jsonObj.Rows
        return $node
    }

    [Boolean] IsSimilarTo([BaseNode] $OtherNode) {
        if ($OtherNode.GetType() -ne [TableNode]) {
            return $false
        }

        return $true
    }

    [Boolean] IsIdenticalTo([BaseNode] $OtherNode) {
        return $this.IsSimilarTo($OtherNode)
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
