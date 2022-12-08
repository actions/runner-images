using module ./SoftwareReport.BaseNodes.psm1
using module ./SoftwareReport.Nodes.psm1

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
        $rootNode = [NodesFactory]::ParseNodeFromObject($jsonObj)
        return [SoftwareReport]::new($rootNode)
    }

    [String] ToMarkdown() {
        return $this.Root.ToMarkdown(1).Trim()
    }
}