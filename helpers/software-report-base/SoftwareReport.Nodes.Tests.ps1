using module ./SoftwareReport.Nodes.psm1

Describe "ToolNode" {
    It "ToMarkdown" {
        $node = [ToolNode]::new("Ruby", "2.7.3")
        $node.ToMarkdown(1) | Should -Be "- Ruby 2.7.3"
    }

    It "GetValue" {
        $node = [ToolNode]::new("Ruby", "2.7.3")
        $node.GetValue() | Should -Be "2.7.3"
    }

    It "Serialization" {
        $node = [ToolNode]::new("Ruby", "2.7.3")
        $json = $node.ToJsonObject()
        $json.NodeType | Should -Be "ToolNode"
        $json.ToolName | Should -Be "Ruby"
        $json.Version | Should -Be "2.7.3"
    }

    It "Serialization + Deserialization" {
        $node = [ToolNode]::new("Ruby", "2.7.3")
        $json = $node.ToJsonObject()
        $node2 = [ToolNode]::FromJsonObject($json)
        $json2 = $node2.ToJsonObject()
        $($json | ConvertTo-Json) | Should -Be $($json2 | ConvertTo-Json)
    }

    Describe "IsSimilarTo" {
        
    }
}

Describe "ToolVersionsNode" {
    Describe "ToMarkdown" {
        It "List" {
            $node = [ToolVersionsNode]::new("Ruby", @("2.7.7", "3.0.5", "3.1.3"))
            $expected = @(
                "",
                "# Ruby"
                "- 2.7.7"
                "- 3.0.5"
                "- 3.1.3"
            ) -join "`n"
            $node.ToMarkdown(1) | Should -Be $expected
        }
    }

    It "GetValue" {
        $node = [ToolVersionsNode]::new("Ruby", @("2.7.7", "3.0.5", "3.1.3"))
        $node.GetValue() | Should -Be "2.7.7, 3.0.5, 3.1.3"
    }

    It "Serialization" {
        $node = [ToolVersionsNode]::new("Ruby", @("2.7.7", "3.0.5", "3.1.3"))
        $json = $node.ToJsonObject()
        $json.NodeType | Should -Be "ToolVersionsNode"
        $json.ToolName | Should -Be "Ruby"
        $json.Versions | Should -HaveCount 3
        $json.Versions[0] | Should -Be "2.7.7"
        $json.Versions[1] | Should -Be "3.0.5"
        $json.Versions[2] | Should -Be "3.1.3"
    }

    It "Serialization + Deserialization" {
        $node = [ToolVersionsNode]::new("Ruby", @("2.7.7", "3.0.5", "3.1.3"))
        $json = $node.ToJsonObject()
        $node2 = [ToolVersionsNode]::FromJsonObject($json)
        $json2 = $node2.ToJsonObject()
        $($json | ConvertTo-Json) | Should -Be $($json2 | ConvertTo-Json)
    }

    <#
    Describe "Inline" {
        It "ToMarkdown" {
            $node = [ToolVersionsNode]::new("Ruby", @("2.7.7", "3.0.5", "3.1.3"))
            $node.ToMarkdown(1) | Should -Be "- Ruby 2.7.7, 3.0.5, 3.1.3"
        }
    }
    #>
}

Describe "NoteNode" {

}