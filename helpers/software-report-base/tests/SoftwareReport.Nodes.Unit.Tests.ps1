using module ../SoftwareReport.Nodes.psm1

BeforeDiscovery {
    Import-Module $(Join-Path $PSScriptRoot "TestHelpers.psm1") -DisableNameChecking
}

Describe "Nodes.UnitTests" {
    Context "ToolVersionNode" {
        It "ToMarkdown" {
            $node = [ToolVersionNode]::new("MyTool", "2.1.3")
            $node.ToMarkdown() | Should -Be "- MyTool 2.1.3"
        }

        It "GetValue" {
            $node = [ToolVersionNode]::new("MyTool", "2.1.3")
            $node.GetValue() | Should -Be "2.1.3"
        }

        It "Serialization" {
            $node = [ToolVersionNode]::new("MyTool", "2.1.3")
            $json = $node.ToJsonObject()
            $json.NodeType | Should -Be "ToolVersionNode"
            $json.ToolName | Should -Be "MyTool"
            $json.Version | Should -Be "2.1.3"
        }

        It "Deserialization" {
            { [ToolVersionNode]::FromJsonObject(@{ NodeType = "ToolVersionNode"; ToolName = ""; Version = "2.1.3" }) } | Should -Throw '*Exception setting "ToolName": "The argument is null or empty.*'
            { [ToolVersionNode]::FromJsonObject(@{ NodeType = "ToolVersionNode"; ToolName = "MyTool"; Version = "" }) } | Should -Throw 'ToolVersionNode ''MyTool'' has empty version'
            { [ToolVersionNode]::FromJsonObject(@{ NodeType = "ToolVersionNode"; ToolName = "MyTool"; Version = "2.1.3" }) } | Should -Not -Throw
        }

        It "Serialization + Deserialization" {
            $node = [ToolVersionNode]::new("MyTool", "2.1.3")
            $json = $node.ToJsonObject()
            $node2 = [ToolVersionNode]::FromJsonObject($json)
            $json2 = $node2.ToJsonObject()
            $($json | ConvertTo-Json) | Should -Be $($json2 | ConvertTo-Json)
        }

        It "IsSimilarTo" {
            [ToolVersionNode]::new("MyTool", "2.1.3").IsSimilarTo([ToolVersionNode]::new("MyTool", "2.1.3")) | Should -BeTrue
            [ToolVersionNode]::new("MyTool", "2.1.3").IsSimilarTo([ToolVersionNode]::new("MyTool", "1.0.0")) | Should -BeTrue
            [ToolVersionNode]::new("MyTool", "2.1.3").IsSimilarTo([ToolVersionNode]::new("MyTool2", "2.1.3")) | Should -BeFalse
        }

        It "IsIdenticalTo" {
            [ToolVersionNode]::new("MyTool", "2.1.3").IsIdenticalTo([ToolVersionNode]::new("MyTool", "2.1.3")) | Should -BeTrue
            [ToolVersionNode]::new("MyTool", "2.1.3").IsIdenticalTo([ToolVersionNode]::new("MyTool", "1.0.0")) | Should -BeFalse
            [ToolVersionNode]::new("MyTool", "2.1.3").IsIdenticalTo([ToolVersionNode]::new("MyTool2", "2.1.3")) | Should -BeFalse
        }
    }

    Context "ToolVersionsListNode" {
        It "ToMarkdown - List" {
            $node = [ToolVersionsListNode]::new("MyTool", @("2.7.7", "3.0.5", "3.1.3"), "^.+", "List")
            $expected = @(
                "",
                "# MyTool"
                "- 2.7.7"
                "- 3.0.5"
                "- 3.1.3"
            ) -join "`n"
            $node.ToMarkdown() | Should -Be $expected
        }

        It "ToMarkdown - Inline" {
            $node = [ToolVersionsListNode]::new("MyTool", @("2.7.7", "3.0.5", "3.1.3"), "^.+", "Inline")
            $node.ToMarkdown() | Should -Be "- MyTool: 2.7.7, 3.0.5, 3.1.3"
        }

        It "GetValue" {
            $node = [ToolVersionsListNode]::new("MyTool", @("2.7.7", "3.0.5", "3.1.3"), "^.+", "List")
            $node.GetValue() | Should -Be "2.7.7, 3.0.5, 3.1.3"
        }

        It "Serialization - List" {
            $node = [ToolVersionsListNode]::new("Ruby", @("2.7.7", "3.0.5", "3.1.3"), "^.+", "List")
            $json = $node.ToJsonObject()
            $json.NodeType | Should -Be "ToolVersionsListNode"
            $json.ToolName | Should -Be "Ruby"
            $json.Versions | Should -BeArray @("2.7.7", "3.0.5", "3.1.3")
            $json.MajorVersionRegex | Should -Be "^.+"
            $json.ListType | Should -Be "List"
        }

        It "Serialization - Inline" {
            $node = [ToolVersionsListNode]::new("Ruby", @("2.7.7", "3.0.5", "3.1.3"), "^.+", "Inline")
            $json = $node.ToJsonObject()
            $json.NodeType | Should -Be "ToolVersionsListNode"
            $json.ToolName | Should -Be "Ruby"
            $json.Versions | Should -BeArray @("2.7.7", "3.0.5", "3.1.3")
            $json.MajorVersionRegex | Should -Be "^.+"
            $json.ListType | Should -Be "Inline"
        }

        It "Deserialization" {
            { [ToolVersionsListNode]::FromJsonObject(@{ NodeType = "ToolVersionsListNode"; ToolName = ""; Versions = @("2.1.3", "3.1.4"); MajorVersionRegex = "^\d+"; ListType = "List" }) } | Should -Throw '*Exception setting "ToolName": "The argument is null or empty.*'
            { [ToolVersionsListNode]::FromJsonObject(@{ NodeType = "ToolVersionsListNode"; ToolName = "MyTool"; MajorVersionRegex = "^\d+"; ListType = "List" }) } | Should -Throw '*Exception setting "Versions": "The argument is null or empty.*'
            { [ToolVersionsListNode]::FromJsonObject(@{ NodeType = "ToolVersionsListNode"; ToolName = "MyTool"; Versions = @(); MajorVersionRegex = "^\d+"; ListType = "List" }) } | Should -Throw '*Exception setting "Versions": "The argument is null, empty,*'
            { [ToolVersionsListNode]::FromJsonObject(@{ NodeType = "ToolVersionsListNode"; ToolName = "MyTool"; Versions = @("2.1.3", '2.2.4'); MajorVersionRegex = "^\d+"; ListType = "List" }) } | Should -Throw 'Multiple versions from list * return the same result from regex *'
            { [ToolVersionsListNode]::FromJsonObject(@{ NodeType = "ToolVersionsListNode"; ToolName = "MyTool"; Versions = @("2.1.3", "3.1.4"); MajorVersionRegex = ""; ListType = "List" }) } | Should -Throw 'Version * doesn''t match regex *'
            { [ToolVersionsListNode]::FromJsonObject(@{ NodeType = "ToolVersionsListNode"; ToolName = "MyTool"; Versions = @("2.1.3", "3.1.4"); MajorVersionRegex = "^\d+"; ListType = "Fake" }) } | Should -Throw '*Exception setting "ListType": "The argument * does not belong to the set*'
            { [ToolVersionsListNode]::FromJsonObject(@{ NodeType = "ToolVersionsListNode"; ToolName = "MyTool"; Versions = @("2.1.3", "3.1.4"); MajorVersionRegex = "^\d+"; ListType = "List" }) } | Should -Not -Throw
            { [ToolVersionsListNode]::FromJsonObject(@{ NodeType = "ToolVersionsListNode"; ToolName = "MyTool"; Versions = @("2.1.3", "3.1.4"); MajorVersionRegex = "^\d+"; ListType = "Inline" }) } | Should -Not -Throw
        }

        It "Serialization + Deserialization" {
            $node = [ToolVersionsListNode]::new("Ruby", @("2.7.7", "3.0.5", "3.1.3"), "^.+", "List")
            $json = $node.ToJsonObject()
            $node2 = [ToolVersionsListNode]::FromJsonObject($json)
            $json2 = $node2.ToJsonObject()
            $($json | ConvertTo-Json) | Should -Be $($json2 | ConvertTo-Json)
        }

        It "IsSimilarTo" {
            [ToolVersionsListNode]::new("MyTool", @("2.1.3", "3.1.5", "4.0.0"), "^.+", "List").IsSimilarTo(
                [ToolVersionsListNode]::new("MyTool", @("2.1.3", "3.1.5", "4.0.0"), "^.+", "List")
            ) | Should -BeTrue
            [ToolVersionsListNode]::new("MyTool", @("2.1.3", "3.1.5", "4.0.0"), "^.+", "List").IsSimilarTo(
                [ToolVersionsListNode]::new("MyTool", @("2.1.5", "5.0.0"), "^.+", "List")
            ) | Should -BeTrue
            [ToolVersionsListNode]::new("MyTool", @("2.1.3", "3.1.5", "4.0.0"), "^.+", "List").IsSimilarTo(
                [ToolVersionsListNode]::new("MyTool2", @("2.1.3", "3.1.5", "4.0.0"), "^.+", "List")
            ) | Should -BeFalse
        }

        It "IsIdenticalTo" {
            [ToolVersionsListNode]::new("MyTool", @("2.1.3", "3.1.5", "4.0.0"), "^.+", "List").IsIdenticalTo(
                [ToolVersionsListNode]::new("MyTool", @("2.1.3", "3.1.5", "4.0.0"), "^.+", "List")
            ) | Should -BeTrue
            [ToolVersionsListNode]::new("MyTool", @("2.1.3", "3.1.5", "4.0.0"), "^.+", "List").IsIdenticalTo(
                [ToolVersionsListNode]::new("MyTool", @("2.1.5", "5.0.0"), "^.+", "List")
            ) | Should -BeFalse
            [ToolVersionsListNode]::new("MyTool", @("2.1.3", "3.1.5", "4.0.0"), "^.+", "List").IsIdenticalTo(
                [ToolVersionsListNode]::new("MyTool2", @("2.1.3", "3.1.5", "4.0.0"), "^.+", "List")
            ) | Should -BeFalse
        }

        It "ExtractMajorVersion" {
            $node = [ToolVersionsListNode]::new("MyTool", @("2.1.3", "3.1.5", "4.0.0"), "^\d+\.\d+", "List")
            $node.ExtractMajorVersion("2.1.3") | Should -Be "2.1"
            $node.ExtractMajorVersion("3.1.5") | Should -Be "3.1"
            $node.ExtractMajorVersion("4.0.0") | Should -Be "4.0"
        }

        Context "ValidateMajorVersionRegex" {
            It "Major version regex - unique versions" {
                $node = [ToolVersionsListNode]::new("MyTool", @("2.1.3", "3.1.5", "4.0.0"), "^\d+", "List")
                $node.Versions | Should -BeArray @("2.1.3", "3.1.5", "4.0.0")
            }

            It "Major version regex - non-unique versions" {
                { [ToolVersionsListNode]::new("MyTool", @("2.1.3", "3.1.5", "3.2.0", "4.0.0"), "^\d+", "List") } | Should -Throw "Multiple versions from list * return the same result from regex *"
            }

            It "Minor version regex - unique versions" {
                $node = [ToolVersionsListNode]::new("MyTool", @("2.1.3", "2.4.0", "3.1.2"), "^\d+\.\d+", "List")
                $node.Versions | Should -BeArray @("2.1.3", "2.4.0", "3.1.2")
            }

            It "Minor version regex - non-unique versions" {
                { [ToolVersionsListNode]::new("MyTool", @("2.1.3", "2.1.4", "3.1.2"), "^\d+\.\d+", "List") } | Should -Throw "Multiple versions from list * return the same result from regex *"
            }

            It "Patch version regex - unique versions" {
                $node = [ToolVersionsListNode]::new("MyTool", @("2.1.3", "2.1.4", "2.1.5"), "^\d+\.\d+\.\d+", "List")
                $node.Versions | Should -BeArray @("2.1.3", "2.1.4", "2.1.5")
            }

            It "Patch version regex - non-unique versions" {
                { [ToolVersionsListNode]::new("MyTool", @("2.1.3", "2.1.4", "2.1.4"), "^\d+\.\d+\.\d+", "List") } | Should -Throw "Multiple versions from list * return the same result from regex *"
            }

            It ".NET Core version regex - unique versions" {
                $node = [ToolVersionsListNode]::new("MyTool", @("2.1.100", "2.1.205", "2.1.303"), "^\d+\.\d+\.\d", "List")
                $node.Versions | Should -BeArray @("2.1.100", "2.1.205", "2.1.303")
            }

            It ".NET Core version regex - non-unique versions" {
                { [ToolVersionsListNode]::new("MyTool", @("2.1.100", "2.1.205", "2.1.230", "3.1.0"), "^\d+\.\d+\.\d", "List") } | Should -Throw "Multiple versions from list * return the same result from regex *"
            }
        }
    }

    Context "TableNode" {
        It "ToMarkdown (Simple table)" {
            $node = [TableNode]::new("Name|Value", @("A|B", "C|D"))
            $node.ToMarkdown() | Should -Be @'
| Name | Value |
| ---- | ----- |
| A    | B     |
| C    | D     |
'@
        }

        It "ToMarkdown (Wide cells)" {
            $node = [TableNode]::new("Name|Value", @("Very long value here|B", "C|And very long value here too"))
            $node.ToMarkdown() | Should -Be @'
| Name                 | Value                        |
| -------------------- | ---------------------------- |
| Very long value here | B                            |
| C                    | And very long value here too |
'@
        }

        It "CalculateColumnsWidth" {
            [TableNode]::new("Name|Value", @("A|B", "C|D")).CalculateColumnsWidth() | Should -BeArray @(4, 5)
            [TableNode]::new("Name|Value", @("Very long value here|B", "C|And very long value here too")).CalculateColumnsWidth() | Should -BeArray @(20, 28)
        }

        It "Serialization" {
            $node = [TableNode]::new("Name|Value", @("A|B", "C|D"))
            $json = $node.ToJsonObject()
            $json.NodeType | Should -Be "TableNode"
            $json.Headers | Should -Be "Name|Value"
            $json.Rows | Should -BeArray @("A|B", "C|D")
        }

        It "Deserialization" {
            { [TableNode]::FromJsonObject(@{ NodeType = "TableNode"; Headers = ""; Rows = @("A|1", "B|2") }) } | Should -Throw 'Exception setting "Headers": "The argument is null or empty. *'
            { [TableNode]::FromJsonObject(@{ NodeType = "TableNode"; Headers = "Name|Value"; Rows = @() }) } | Should -Throw 'Exception setting "Rows": "The argument is null, empty, *'
            { [TableNode]::FromJsonObject(@{ NodeType = "TableNode"; Headers = "Name|Value"; Rows = @("A|1", "B|2|T", "C|3") }) } | Should -Throw 'Table has different number of columns in different rows'
            { [TableNode]::FromJsonObject(@{ NodeType = "TableNode"; Headers = "Name|Value"; Rows = @("A|1", "B|2") }) } | Should -Not -Throw
        }

        It "Serialization + Deserialization" {
            $node = [TableNode]::new("Name|Value", @("A|B", "C|D"))
            $json = $node.ToJsonObject()
            $node2 = [TableNode]::FromJsonObject($json)
            $json2 = $node2.ToJsonObject()
            $($json | ConvertTo-Json) | Should -Be $($json2 | ConvertTo-Json)
        }

        It "IsSimilarTo" {
            [TableNode]::new("Name|Value", @("A|B", "C|D")).IsSimilarTo([TableNode]::new("Name|Value", @("A|B", "C|D"))) | Should -BeTrue
            [TableNode]::new("Name|Value", @("A|B", "C|D")).IsSimilarTo([TableNode]::new("Name|Value", @("A|B", "C|D", "F|W"))) | Should -BeTrue
            [TableNode]::new("Name|Value", @("A|B", "C|D")).IsSimilarTo([TableNode]::new("Name|Value", @("A|B", "C|E"))) | Should -BeTrue
            [TableNode]::new("Name|Value", @("A|B", "C|D")).IsSimilarTo([TableNode]::new("Name|Key", @("A|B", "C|D"))) | Should -BeTrue
        }

        It "IsIdenticalTo" {
            [TableNode]::new("Name|Value", @("A|B", "C|D")).IsIdenticalTo([TableNode]::new("Name|Value", @("A|B", "C|D"))) | Should -BeTrue
            [TableNode]::new("Name|Value", @("A|B", "C|D")).IsIdenticalTo([TableNode]::new("Name|Key", @("A|B", "C|D"))) | Should -BeTrue
            [TableNode]::new("Name|Value", @("A|B", "C|D")).IsIdenticalTo([TableNode]::new("Name|Value", @("A|B", "C|D", "F|W"))) | Should -BeFalse
            [TableNode]::new("Name|Value", @("A|B", "C|D")).IsIdenticalTo([TableNode]::new("Name|Value", @("A|B", "C|E"))) | Should -BeFalse
        }

        Context "FromObjectsArray" {
            It "Correct table" {
                $table = @(
                    [PSCustomObject]@{Name = "A"; Value = "B"}
                    [PSCustomObject]@{Name = "C"; Value = "D"}
                )

                $tableNode = [TableNode]::FromObjectsArray($table)
                $tableNode.Headers | Should -Be "Name|Value"
                $tableNode.Rows | Should -BeArray @("A|B", "C|D")
            }

            It "Correct table with spaces" {
                $table = @(
                    [PSCustomObject]@{Name = "A B"; "My Value" = "1 2"}
                    [PSCustomObject]@{Name = "C D"; "My Value" = "3 4"}
                )

                $tableNode = [TableNode]::FromObjectsArray($table)
                $tableNode.Headers | Should -Be "Name|My Value"
                $tableNode.Rows | Should -BeArray @("A B|1 2", "C D|3 4")
            }

            It "Throw on empty table" {
                { [TableNode]::FromObjectsArray(@()) } | Should -Throw "Failed to create TableNode from empty objects array"
            }

            It "Throw on table with different columns" {
                $table = @(
                    [PSCustomObject]@{Name = "A"; Value = "B"}
                    [PSCustomObject]@{Name = "C"; Value2 = "D"}
                )

                { [TableNode]::FromObjectsArray($table) } | Should -Throw "Failed to create TableNode from objects array because objects have different properties"
            }

            It "Throw on empty row" {
                $table = @(
                    [PSCustomObject]@{Name = "A"; Value = "B"},
                    [PSCustomObject]@{},
                    [PSCustomObject]@{Name = "C"; Value2 = "D"}
                )

                { [TableNode]::FromObjectsArray($table) } | Should -Throw "Failed to create TableNode because some objects are empty"
            }

            It "Throw on incorrect symbols in table column names" {
                $table = @(
                    [PSCustomObject]@{"Name|War" = "A"; Value = "B"}
                    [PSCustomObject]@{"Name|War" = "C"; Value = "D"}
                )

                { [TableNode]::FromObjectsArray($table) } | Should -Throw "Failed to create TableNode because some cells * contains forbidden symbol*"
            }

            It "Throw on incorrect symbols in table rows" {
                $table = @(
                    [PSCustomObject]@{Name = "A"; Value = "B|AA"}
                    [PSCustomObject]@{Name = "C"; Value = "D"}
                )

                { [TableNode]::FromObjectsArray($table) } | Should -Throw "Failed to create TableNode because some cells * contains forbidden symbol*"
            }
        }
    }

    Context "NoteNode" {
        It "ToMarkdown" {
            $node = [NoteNode]::new("Hello world`nGood Bye world")
            $node.ToMarkdown() | Should -Be @'
```
hello world
Good Bye world
```
'@
        }

        It "Serialization" {
            $node = [NoteNode]::new("MyContent`nMyContent2")
            $json = $node.ToJsonObject()
            $json.NodeType | Should -Be "NoteNode"
            $json.Content | Should -Be "MyContent`nMyContent2"
        }

        It "Deserialization" {
            { [NoteNode]::FromJsonObject(@{ NodeType = "NoteNode" }) } | Should -Throw '*Exception setting "Content": "The argument is null or empty.*'
            { [NoteNode]::FromJsonObject(@{ NodeType = "NoteNode"; Content = "" }) } | Should -Throw '*Exception setting "Content": "The argument is null or empty.*'
            { [NoteNode]::FromJsonObject(@{ NodeType = "NoteNode"; Content = "MyTool" }) } | Should -Not -Throw
        }

        It "Serialization + Deserialization" {
            $node = [NoteNode]::new("MyContent`nMyContent2")
            $json = $node.ToJsonObject()
            $node2 = [NoteNode]::FromJsonObject($json)
            $json2 = $node2.ToJsonObject()
            $($json | ConvertTo-Json) | Should -Be $($json2 | ConvertTo-Json)
        }

        It "IsSimilarTo" {
            [NoteNode]::new("MyContent").IsSimilarTo([NoteNode]::new("MyContent")) | Should -BeTrue
            [NoteNode]::new("MyContent").IsSimilarTo([NoteNode]::new("MyContent2")) | Should -BeFalse
        }

        It "IsIdenticalTo" {
            [NoteNode]::new("MyContent").IsIdenticalTo([NoteNode]::new("MyContent")) | Should -BeTrue
            [NoteNode]::new("MyContent").IsIdenticalTo([NoteNode]::new("MyContent2")) | Should -BeFalse
        }
    }

    Context "HeaderNode" {
        It "ToMarkdown" {
            $node = [HeaderNode]::new("MyHeader")
            $node.AddToolVersion("MyTool", "2.1.3")
            $node.ToMarkdown(1) | Should -Be @'

# MyHeader
- MyTool 2.1.3
'@
        }

        It "ToMarkdown (level 3)" {
            $node = [HeaderNode]::new("MyHeader")
            $node.AddToolVersion("MyTool", "2.1.3")
            $node.ToMarkdown(3) | Should -Be @'

### MyHeader
- MyTool 2.1.3
'@
        }

        It "ToMarkdown (multiple levels)" {
            $node = [HeaderNode]::new("MyHeader")
            $node.AddHeader("MyHeader 2").AddHeader("MyHeader 3").AddHeader("MyHeader 4").AddToolVersion("MyTool", "2.1.3")
            $node.ToMarkdown(1) | Should -Be @'

# MyHeader

## MyHeader 2

### MyHeader 3

#### MyHeader 4
- MyTool 2.1.3
'@
        }

        It "Serialization" {
            $node = [HeaderNode]::new("MyHeader")
            $node.AddToolVersion("MyTool", "2.1.3")
            $json = $node.ToJsonObject()
            $json.NodeType | Should -Be "HeaderNode"
            $json.Title | Should -Be "MyHeader"
            $json.Children | Should -HaveCount 1
        }

        It "Deserialization" {
            { [HeaderNode]::FromJsonObject(@{ NodeType = "HeaderNode" }) } | Should -Throw '*Exception setting "Title": "The argument is null or empty.*'
            { [HeaderNode]::FromJsonObject(@{ NodeType = "HeaderNode"; Title = "" }) } | Should -Throw '*Exception setting "Title": "The argument is null or empty.*'
            { [HeaderNode]::FromJsonObject(@{ NodeType = "HeaderNode"; Title = "MyHeader" }) } | Should -Not -Throw
        }

        It "Serialization + Deserialization" {
            $node = [HeaderNode]::new("MyHeader")
            $node.AddToolVersion("MyTool", "2.1.3")
            $json = $node.ToJsonObject()
            $node2 = [HeaderNode]::FromJsonObject($json)
            $json2 = $node2.ToJsonObject()
            $($json | ConvertTo-Json) | Should -Be $($json2 | ConvertTo-Json)
        }

        It "IsSimilarTo" {
            [HeaderNode]::new("MyHeader").IsSimilarTo([HeaderNode]::new("MyHeader")) | Should -BeTrue
            [HeaderNode]::new("MyHeader").IsSimilarTo([HeaderNode]::new("MyHeader2")) | Should -BeFalse
        }

        It "IsIdenticalTo" {
            [HeaderNode]::new("MyHeader").IsIdenticalTo([HeaderNode]::new("MyHeader")) | Should -BeTrue
            [HeaderNode]::new("MyHeader").IsIdenticalTo([HeaderNode]::new("MyHeader2")) | Should -BeFalse
        }

        It "FindSimilarChildNode" {
            $node = [HeaderNode]::new("MyHeader")
            $node.AddToolVersion("MyTool", "2.1.3")

            $node.FindSimilarChildNode([ToolVersionNode]::new("MyTool", "1.0.0")) | Should -Not -BeNullOrEmpty
            $node.FindSimilarChildNode([ToolVersionNode]::New("MyTool2", "1.0.0")) | Should -BeNullOrEmpty
        }

        Context "Detect node duplicates" {
            It "Similar HeaderNode on the same header" {
                $node = [HeaderNode]::new("MyHeader")
                $node.AddHeader("MySubHeader1")
                $node.AddHeader("MySubHeader2")
                { $node.AddHeader("MySubHeader1") } | Should -Throw "This HeaderNode already contains the similar child node. It is not allowed to add the same node twice.*"
            }

            It "Similar ToolVersionNode on the same header" {
                $node = [HeaderNode]::new("MyHeader")
                $node.AddToolVersion("MyTool", "2.1.3")
                $node.AddToolVersion("MyTool2", "2.1.3")
                { $node.AddToolVersion("MyTool", "2.1.3") } | Should -Throw "This HeaderNode already contains the similar child node. It is not allowed to add the same node twice.*"
            }

            It "Similar ToolVersionsListNode on the same header" {
                $node = [HeaderNode]::new("MyHeader")
                $node.AddToolVersionsListInline("MyTool", @("2.1.3", "3.0.0"), "^\d+")
                $node.AddToolVersionsListInline("MyTool2", @("2.1.3", "3.0.0"), "^\d+")
                { $node.AddToolVersionsList("MyTool", @("2.1.3", "3.0.0"), "^\d+") } | Should -Throw "This HeaderNode already contains the similar child node. It is not allowed to add the same node twice.*"
            }

            It "Similar TableNode on the same header" {
                $node = [HeaderNode]::new("MyHeader")
                $node.AddTable(@(
                    [PSCustomObject]@{Name = "Value1"},
                    [PSCustomObject]@{Name = "Value2"}
                ))
                {
                    $node.AddTable(@(
                        [PSCustomObject]@{Name = "Value1"},
                        [PSCustomObject]@{Name = "Value2"}
                    ))
                } | Should -Throw "This HeaderNode already contains the similar child node. It is not allowed to add the same node twice.*"
            }

            It "Similar NoteNode on the same header" {
                $node = [HeaderNode]::new("MyHeader")
                $node.AddNote("MyContent")
                $node.AddNote("MyContent2")
                { $node.AddNote("MyContent") } | Should -Throw "This HeaderNode already contains the similar child node. It is not allowed to add the same node twice.*"
            }

            It "AddNode detects duplicates" {
                $node = [HeaderNode]::new("MyHeader")
                $node.AddNode([ToolVersionNode]::new("MyTool", "2.1.3"))
                { $node.AddNode([ToolVersionNode]::new("MyTool", "2.1.3")) } | Should -Throw "This HeaderNode already contains the similar child node. It is not allowed to add the same node twice.*"
            }

            It "AddNodes detects duplicates" {
                $node = [HeaderNode]::new("MyHeader")
                $node.AddNodes(@(
                    [ToolVersionNode]::new("MyTool", "2.1.3"),
                    [ToolVersionNode]::new("MyTool2", "2.1.4")
                ))
                {
                    $node.AddNodes(@(
                        [ToolVersionNode]::new("MyTool3", "2.1.5"),
                        [ToolVersionNode]::new("MyTool", "2.1.3")
                    ))
                } | Should -Throw "This HeaderNode already contains the similar child node. It is not allowed to add the same node twice.*"
            }

            It "Doesn't allow adding non-header nodes after header node" {
                $node = [HeaderNode]::new("MyHeader")
                { $node.AddToolVersion("MyTool", "2.1.3") } | Should -Not -Throw
                { $node.AddHeader("MySubHeader") } | Should -Not -Throw
                { $node.AddToolVersion("MyTool2", "2.1.4") } | Should -Throw "It is not allowed to add the non-header node after the header node. Consider adding the separate HeaderNode for this node"
                { $node.AddHeader("MySubHeader2") } | Should -Not -Throw
                { $node.AddToolVersionsListInline("MyTool3", @("2.1.4", "2.1.5"), "^.+") } | Should -Throw "It is not allowed to add the non-header node after the header node. Consider adding the separate HeaderNode for this node"
                { $node.AddToolVersionsList("MyTool4", @("2.1.4", "2.1.5"), "^.+") } | Should -Not -Throw
            }
        }
    }
}