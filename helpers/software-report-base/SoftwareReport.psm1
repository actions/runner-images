using module ./SoftwareReport.BaseNodes.psm1
using module ./SoftwareReport.Nodes.psm1

class SoftwareReport {
    [ValidateNotNullOrEmpty()]
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

    static [SoftwareReport] FromJson([String] $JsonString) {
        $jsonObj = $JsonString | ConvertFrom-Json
        $rootNode = [NodesFactory]::ParseNodeFromObject($jsonObj)
        return [SoftwareReport]::new($rootNode)
    }

    [String] ToMarkdown() {
        return $this.Root.ToMarkdown().Trim()
    }

    [String] GetImageVersion() {
        $imageVersionNode = $this.Root.Children ?? @() | Where-Object { ($_ -is [ToolVersionNode]) -and ($_.ToolName -eq "Image Version:") } | Select-Object -First 1
        return $imageVersionNode.Version ?? "Unknown version"
    }
}