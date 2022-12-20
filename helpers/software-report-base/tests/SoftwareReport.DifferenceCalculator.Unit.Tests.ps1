using module ../SoftwareReport.Nodes.psm1
using module ../SoftwareReport.DifferenceCalculator.psm1

BeforeDiscovery {
    Import-Module $(Join-Path $PSScriptRoot "TestHelpers.psm1") -DisableNameChecking
}

Describe "Comparer.UnitTests" {
    Describe "Headers Tree" {
        It "Add Node to existing header" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader")

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddToolVersion("MyTool1", "2.1.3")
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 1
            $comparer.ChangedItems | Should -HaveCount 0
            $comparer.DeletedItems | Should -HaveCount 0

            $comparer.AddedItems[0].PreviousReportNode | Should -BeNullOrEmpty
            $comparer.AddedItems[0].CurrentReportNode | Should -BeOfType ([ToolVersionNode])
            $comparer.AddedItems[0].CurrentReportNode.ToolName | Should -Be "MyTool1"
            $comparer.AddedItems[0].CurrentReportNode.Version | Should -Be "2.1.3"
            $comparer.AddedItems[0].Headers | Should -BeArray @("MyHeader")
        }

        It "Add new header with Node" {
            $prevReport = [HeaderNode]::new("Version 1")

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddHeader("MySubHeader").AddToolVersion("MyTool1", "2.1.3")
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 1
            $comparer.ChangedItems | Should -HaveCount 0
            $comparer.DeletedItems | Should -HaveCount 0

            $comparer.AddedItems[0].PreviousReportNode | Should -BeNullOrEmpty
            $comparer.AddedItems[0].CurrentReportNode | Should -BeOfType ([ToolVersionNode])
            $comparer.AddedItems[0].CurrentReportNode.ToolName | Should -Be "MyTool1"
            $comparer.AddedItems[0].CurrentReportNode.Version | Should -Be "2.1.3"
            $comparer.AddedItems[0].Headers | Should -BeArray @("MyHeader", "MySubHeader")
        }

        It "Remove Node from existing header" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddToolVersion("MyTool1", "2.1.3")

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader")
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 0
            $comparer.ChangedItems | Should -HaveCount 0
            $comparer.DeletedItems | Should -HaveCount 1

            $comparer.DeletedItems[0].PreviousReportNode | Should -BeOfType ([ToolVersionNode])
            $comparer.DeletedItems[0].PreviousReportNode.ToolName | Should -Be "MyTool1"
            $comparer.DeletedItems[0].PreviousReportNode.Version | Should -Be "2.1.3"
            $comparer.DeletedItems[0].CurrentReportNode | Should -BeNullOrEmpty
            $comparer.DeletedItems[0].Headers | Should -BeArray @("MyHeader")
        }

        It "Remove header with Node" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddHeader("MySubheader").AddToolVersion("MyTool1", "2.1.3")

            $nextReport = [HeaderNode]::new("Version 2")
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 0
            $comparer.ChangedItems | Should -HaveCount 0
            $comparer.DeletedItems | Should -HaveCount 1

            $comparer.DeletedItems[0].PreviousReportNode | Should -BeOfType ([ToolVersionNode])
            $comparer.DeletedItems[0].PreviousReportNode.ToolName | Should -Be "MyTool1"
            $comparer.DeletedItems[0].PreviousReportNode.Version | Should -Be "2.1.3"
            $comparer.DeletedItems[0].CurrentReportNode | Should -BeNullOrEmpty
            $comparer.DeletedItems[0].Headers | Should -BeArray @("MyHeader", "MySubheader")
        }

        It "Node with minor changes" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddHeader("MySubheader").AddToolVersion("MyTool1", "2.1.3")

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddHeader("MySubheader").AddToolVersion("MyTool1", "2.1.4")
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 0
            $comparer.ChangedItems | Should -HaveCount 1
            $comparer.DeletedItems | Should -HaveCount 0

            $comparer.ChangedItems[0].PreviousReportNode | Should -BeOfType ([ToolVersionNode])
            $comparer.ChangedItems[0].PreviousReportNode.ToolName | Should -Be "MyTool1"
            $comparer.ChangedItems[0].PreviousReportNode.Version | Should -Be "2.1.3"
            $comparer.ChangedItems[0].CurrentReportNode | Should -BeOfType ([ToolVersionNode])
            $comparer.ChangedItems[0].CurrentReportNode.ToolName | Should -Be "MyTool1"
            $comparer.ChangedItems[0].CurrentReportNode.Version | Should -Be "2.1.4"
            $comparer.ChangedItems[0].Headers | Should -BeArray @("MyHeader", "MySubHeader")
        }

        It "Node without changes" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddHeader("MySubheader").AddToolVersion("MyTool1", "2.1.3")

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddHeader("MySubheader").AddToolVersion("MyTool1", "2.1.3")
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 0
            $comparer.ChangedItems | Should -HaveCount 0
            $comparer.DeletedItems | Should -HaveCount 0
        }

        It "Node is moved to different header" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddHeader("MySubheader").AddToolVersion("MyTool1", "2.1.3")

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddHeader("MySubheader2").AddToolVersion("MyTool1", "2.1.3")
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 1
            $comparer.ChangedItems | Should -HaveCount 0
            $comparer.DeletedItems | Should -HaveCount 1

            $comparer.AddedItems[0].PreviousReportNode | Should -BeNullOrEmpty
            $comparer.AddedItems[0].CurrentReportNode | Should -BeOfType ([ToolVersionNode])
            $comparer.AddedItems[0].CurrentReportNode.ToolName | Should -Be "MyTool1"
            $comparer.AddedItems[0].CurrentReportNode.Version | Should -Be "2.1.3"
            $comparer.AddedItems[0].Headers | Should -BeArray @("MyHeader", "MySubheader2")

            $comparer.DeletedItems[0].PreviousReportNode | Should -BeOfType ([ToolVersionNode])
            $comparer.DeletedItems[0].PreviousReportNode.ToolName | Should -Be "MyTool1"
            $comparer.DeletedItems[0].PreviousReportNode.Version | Should -Be "2.1.3"
            $comparer.DeletedItems[0].CurrentReportNode | Should -BeNullOrEmpty
            $comparer.DeletedItems[0].Headers | Should -BeArray @("MyHeader", "MySubheader")
        }

        It "Complex structure" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevSubHeader = $prevReport.AddHeader("MyHeader").AddHeader("MySubheader")
            $prevSubHeader.AddToolVersion("MyTool1", "2.1.3")
            $prevSubHeader.AddHeader("MySubSubheader").AddToolVersion("MyTool2", "2.9.1")
            $prevReport.AddHeader("MyHeader2")
            $prevReport.AddHeader("MyHeader3").AddHeader("MySubheader3").AddToolVersion("MyTool3", "14.2.1")

            $nextReport = [HeaderNode]::new("Version 2")
            $nextSubHeader = $nextReport.AddHeader("MyHeader").AddHeader("MySubheader")
            $nextSubHeader.AddToolVersion("MyTool1", "2.1.4")
            $nextSubSubHeader = $nextSubHeader.AddHeader("MySubSubheader")
            $nextSubSubHeader.AddToolVersion("MyTool2", "2.9.1")
            $nextSubSubHeader.AddToolVersion("MyTool4", "2.7.6")
            $nextReport.AddHeader("MyHeader2")
            $nextReport.AddHeader("MyHeader3")

            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 1
            $comparer.ChangedItems | Should -HaveCount 1
            $comparer.DeletedItems | Should -HaveCount 1

            $comparer.AddedItems[0].PreviousReportNode | Should -BeNullOrEmpty
            $comparer.AddedItems[0].CurrentReportNode | Should -BeOfType ([ToolVersionNode])
            $comparer.AddedItems[0].CurrentReportNode.ToolName | Should -Be "MyTool4"
            $comparer.AddedItems[0].CurrentReportNode.Version | Should -Be "2.7.6"
            $comparer.AddedItems[0].Headers | Should -BeArray @("MyHeader", "MySubheader", "MySubSubheader")

            $comparer.ChangedItems[0].PreviousReportNode | Should -BeOfType ([ToolVersionNode])
            $comparer.ChangedItems[0].PreviousReportNode.ToolName | Should -Be "MyTool1"
            $comparer.ChangedItems[0].PreviousReportNode.Version | Should -Be "2.1.3"
            $comparer.ChangedItems[0].CurrentReportNode | Should -BeOfType ([ToolVersionNode])
            $comparer.ChangedItems[0].CurrentReportNode.ToolName | Should -Be "MyTool1"
            $comparer.ChangedItems[0].CurrentReportNode.Version | Should -Be "2.1.4"
            $comparer.ChangedItems[0].Headers | Should -BeArray @("MyHeader", "MySubheader")

            $comparer.DeletedItems[0].PreviousReportNode | Should -BeOfType ([ToolVersionNode])
            $comparer.DeletedItems[0].PreviousReportNode.ToolName | Should -Be "MyTool3"
            $comparer.DeletedItems[0].PreviousReportNode.Version | Should -Be "14.2.1"
            $comparer.DeletedItems[0].CurrentReportNode | Should -BeNullOrEmpty
            $comparer.DeletedItems[0].Headers | Should -BeArray @("MyHeader3", "MySubheader3")
        }
    }

    Describe "ToolVersionNode" {
        It "ToolVersionNode is updated" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddToolVersion("MyTool1", "2.1.3")

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddToolVersion("MyTool1", "2.1.4")
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 0
            $comparer.ChangedItems | Should -HaveCount 1
            $comparer.DeletedItems | Should -HaveCount 0

            $comparer.ChangedItems[0].PreviousReportNode | Should -BeOfType ([ToolVersionNode])
            $comparer.ChangedItems[0].PreviousReportNode.ToolName | Should -Be "MyTool1"
            $comparer.ChangedItems[0].PreviousReportNode.Version | Should -Be "2.1.3"
            $comparer.ChangedItems[0].CurrentReportNode | Should -BeOfType ([ToolVersionNode])
            $comparer.ChangedItems[0].CurrentReportNode.ToolName | Should -Be "MyTool1"
            $comparer.ChangedItems[0].CurrentReportNode.Version | Should -Be "2.1.4"
            $comparer.ChangedItems[0].Headers | Should -BeArray @("MyHeader")
        }
    }

    Describe "ToolVersionsListNode" {
        It "Single version is not changed" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddToolVersionsList("MyTool1", @("2.1.3"), "^.+")

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddToolVersionsList("MyTool1", @("2.1.3"), "^.+")
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 0
            $comparer.ChangedItems | Should -HaveCount 0
            $comparer.DeletedItems | Should -HaveCount 0
        }

        It "Single version is changed" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddToolVersionsList("MyTool1", @("2.1.3"), "^\d+")

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddToolVersionsList("MyTool1", @("2.1.4"), "^\d+")
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 0
            $comparer.ChangedItems | Should -HaveCount 1
            $comparer.DeletedItems | Should -HaveCount 0

            $comparer.ChangedItems[0].PreviousReportNode | Should -BeOfType ([ToolVersionsListNode])
            $comparer.ChangedItems[0].PreviousReportNode.ToolName | Should -Be "MyTool1"
            $comparer.ChangedItems[0].PreviousReportNode.Versions | Should -BeArray @("2.1.3")
            $comparer.ChangedItems[0].CurrentReportNode | Should -BeOfType ([ToolVersionsListNode])
            $comparer.ChangedItems[0].CurrentReportNode.ToolName | Should -Be "MyTool1"
            $comparer.ChangedItems[0].CurrentReportNode.Versions | Should -BeArray @("2.1.4")
        }

        It "Major version is added" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddToolVersionsList("MyTool1", @("2.1.3"), "^\d+")

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddToolVersionsList("MyTool1", @("2.1.3", "3.1.4"), "^\d+")
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 1
            $comparer.ChangedItems | Should -HaveCount 0
            $comparer.DeletedItems | Should -HaveCount 0

            $comparer.AddedItems[0].PreviousReportNode | Should -BeNullOrEmpty
            $comparer.AddedItems[0].CurrentReportNode | Should -BeOfType ([ToolVersionsListNode])
            $comparer.AddedItems[0].CurrentReportNode.ToolName | Should -Be "MyTool1"
            $comparer.AddedItems[0].CurrentReportNode.Versions | Should -BeArray @("3.1.4")
        }

        It "Major version is removed" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddToolVersionsList("MyTool1", @("2.1.3", "3.1.4"), "^\d+")

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddToolVersionsList("MyTool1", @("3.1.4"), "^\d+")
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 0
            $comparer.ChangedItems | Should -HaveCount 0
            $comparer.DeletedItems | Should -HaveCount 1

            $comparer.DeletedItems[0].PreviousReportNode | Should -BeOfType ([ToolVersionsListNode])
            $comparer.DeletedItems[0].PreviousReportNode.ToolName | Should -Be "MyTool1"
            $comparer.DeletedItems[0].PreviousReportNode.Versions | Should -BeArray @("2.1.3")
            $comparer.DeletedItems[0].CurrentReportNode | Should -BeNullOrEmpty
        }

        It "Major version is changed" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddToolVersionsList("MyTool1", @("3.1.4"), "^\d+")

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddToolVersionsList("MyTool1", @("3.2.0"), "^\d+")
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 0
            $comparer.ChangedItems | Should -HaveCount 1
            $comparer.DeletedItems | Should -HaveCount 0

            $comparer.ChangedItems[0].PreviousReportNode | Should -BeOfType ([ToolVersionsListNode])
            $comparer.ChangedItems[0].PreviousReportNode.ToolName | Should -Be "MyTool1"
            $comparer.ChangedItems[0].PreviousReportNode.Versions | Should -BeArray @("3.1.4")
            $comparer.ChangedItems[0].CurrentReportNode | Should -BeOfType ([ToolVersionsListNode])
            $comparer.ChangedItems[0].CurrentReportNode.ToolName | Should -Be "MyTool1"
            $comparer.ChangedItems[0].CurrentReportNode.Versions | Should -BeArray @("3.2.0")
        }

        It "Major version is added, removed and updated at the same time" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddToolVersionsList("MyTool1", @("1.0.0", "2.1.3", "3.1.4", "4.0.2"), "^\d+")

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddToolVersionsList("MyTool1", @("2.1.3", "3.2.0", "4.0.2", "5.1.0"), "^\d+")
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 1
            $comparer.ChangedItems | Should -HaveCount 1
            $comparer.DeletedItems | Should -HaveCount 1

            $comparer.AddedItems[0].PreviousReportNode | Should -BeNullOrEmpty
            $comparer.AddedItems[0].CurrentReportNode | Should -BeOfType ([ToolVersionsListNode])
            $comparer.AddedItems[0].CurrentReportNode.ToolName | Should -Be "MyTool1"
            $comparer.AddedItems[0].CurrentReportNode.Versions | Should -BeArray @("5.1.0")

            $comparer.ChangedItems[0].PreviousReportNode | Should -BeOfType ([ToolVersionsListNode])
            $comparer.ChangedItems[0].PreviousReportNode.ToolName | Should -Be "MyTool1"
            $comparer.ChangedItems[0].PreviousReportNode.Versions | Should -BeArray @("3.1.4")
            $comparer.ChangedItems[0].CurrentReportNode | Should -BeOfType ([ToolVersionsListNode])
            $comparer.ChangedItems[0].CurrentReportNode.ToolName | Should -Be "MyTool1"
            $comparer.ChangedItems[0].CurrentReportNode.Versions | Should -BeArray @("3.2.0")

            $comparer.DeletedItems[0].PreviousReportNode | Should -BeOfType ([ToolVersionsListNode])
            $comparer.DeletedItems[0].PreviousReportNode.ToolName | Should -Be "MyTool1"
            $comparer.DeletedItems[0].PreviousReportNode.Versions | Should -BeArray @("1.0.0")
            $comparer.DeletedItems[0].CurrentReportNode | Should -BeNullOrEmpty
        }

        It "Minor version is added, removed and updated at the same time" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddToolVersionsList("MyTool1", @("2.3.8", "2.4.9", "2.5.3", "2.6.0", "2.7.4", "2.8.0"), "^\d+\.\d+")

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddToolVersionsList("MyTool1", @("2.5.3", "2.6.2", "2.7.5", "2.8.0", "2.9.2", "2.10.3"), "^\d+\.\d+")
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 1
            $comparer.ChangedItems | Should -HaveCount 1
            $comparer.DeletedItems | Should -HaveCount 1

            $comparer.AddedItems[0].PreviousReportNode | Should -BeNullOrEmpty
            $comparer.AddedItems[0].CurrentReportNode | Should -BeOfType ([ToolVersionsListNode])
            $comparer.AddedItems[0].CurrentReportNode.ToolName | Should -Be "MyTool1"
            $comparer.AddedItems[0].CurrentReportNode.Versions | Should -BeArray @("2.9.2", "2.10.3")

            $comparer.ChangedItems[0].PreviousReportNode | Should -BeOfType ([ToolVersionsListNode])
            $comparer.ChangedItems[0].PreviousReportNode.ToolName | Should -Be "MyTool1"
            $comparer.ChangedItems[0].PreviousReportNode.Versions | Should -BeArray @("2.6.0", "2.7.4")
            $comparer.ChangedItems[0].CurrentReportNode | Should -BeOfType ([ToolVersionsListNode])
            $comparer.ChangedItems[0].CurrentReportNode.ToolName | Should -Be "MyTool1"
            $comparer.ChangedItems[0].CurrentReportNode.Versions | Should -BeArray @("2.6.2", "2.7.5")

            $comparer.DeletedItems[0].PreviousReportNode | Should -BeOfType ([ToolVersionsListNode])
            $comparer.DeletedItems[0].PreviousReportNode.ToolName | Should -Be "MyTool1"
            $comparer.DeletedItems[0].PreviousReportNode.Versions | Should -BeArray @("2.3.8", "2.4.9")
            $comparer.DeletedItems[0].CurrentReportNode | Should -BeNullOrEmpty
        }

        It "Patch version is added, removed and updated at the same time" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddToolVersionsList("MyTool1", @("2.3.8", "2.4.9", "2.5.3", "2.6.0", "2.7.4"), "^\d+\.\d+\.\d+")

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddToolVersionsList("MyTool1", @("2.4.9", "2.5.4", "2.6.0", "2.7.5", "2.8.2"), "^\d+\.\d+\.\d+")
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 1
            $comparer.ChangedItems | Should -HaveCount 0
            $comparer.DeletedItems | Should -HaveCount 1

            $comparer.AddedItems[0].PreviousReportNode | Should -BeNullOrEmpty
            $comparer.AddedItems[0].CurrentReportNode | Should -BeOfType ([ToolVersionsListNode])
            $comparer.AddedItems[0].CurrentReportNode.ToolName | Should -Be "MyTool1"
            $comparer.AddedItems[0].CurrentReportNode.Versions | Should -BeArray @("2.5.4", "2.7.5", "2.8.2")

            $comparer.DeletedItems[0].PreviousReportNode | Should -BeOfType ([ToolVersionsListNode])
            $comparer.DeletedItems[0].PreviousReportNode.ToolName | Should -Be "MyTool1"
            $comparer.DeletedItems[0].PreviousReportNode.Versions | Should -BeArray @("2.3.8", "2.5.3", "2.7.4")
            $comparer.DeletedItems[0].CurrentReportNode | Should -BeNullOrEmpty
        }
    }

    Describe "TableNode" {
        It "Rows are added" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddNode([TableNode]::new("Name|Value", @("A1|A2", "B1|B2")))

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddNode([TableNode]::new("Name|Value", @("A1|A2", "B1|B2", "C1|C2", "D1|D2")))
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 1
            $comparer.ChangedItems | Should -HaveCount 0
            $comparer.DeletedItems | Should -HaveCount 0

            $comparer.AddedItems[0].PreviousReportNode | Should -BeOfType ([TableNode])
            $comparer.AddedItems[0].PreviousReportNode.Headers | Should -Be "Name|Value"
            $comparer.AddedItems[0].PreviousReportNode.Rows | Should -BeArray @("A1|A2", "B1|B2")
            $comparer.AddedItems[0].CurrentReportNode | Should -BeOfType ([TableNode])
            $comparer.AddedItems[0].CurrentReportNode.Headers | Should -Be "Name|Value"
            $comparer.AddedItems[0].CurrentReportNode.Rows | Should -BeArray @("A1|A2", "B1|B2", "C1|C2", "D1|D2")
        }

        It "Rows are deleted" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddNode([TableNode]::new("Name|Value", @("A1|A2", "B1|B2", "C1|C2", "D1|D2")))

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddNode([TableNode]::new("Name|Value", @("C1|C2", "D1|D2")))
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 0
            $comparer.ChangedItems | Should -HaveCount 0
            $comparer.DeletedItems | Should -HaveCount 1

            $comparer.DeletedItems[0].PreviousReportNode | Should -BeOfType ([TableNode])
            $comparer.DeletedItems[0].PreviousReportNode.Headers | Should -Be "Name|Value"
            $comparer.DeletedItems[0].PreviousReportNode.Rows | Should -BeArray @("A1|A2", "B1|B2", "C1|C2", "D1|D2")
            $comparer.DeletedItems[0].CurrentReportNode | Should -BeOfType ([TableNode])
            $comparer.DeletedItems[0].CurrentReportNode.Headers | Should -Be "Name|Value"
            $comparer.DeletedItems[0].CurrentReportNode.Rows | Should -BeArray @("C1|C2", "D1|D2")
        }

        It "Rows are changed" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddNode([TableNode]::new("Name|Value", @("A1|A2", "B1|B2")))

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddNode([TableNode]::new("Name|Value", @("A1|A2", "B3|B4")))
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 0
            $comparer.ChangedItems | Should -HaveCount 1
            $comparer.DeletedItems | Should -HaveCount 0

            $comparer.ChangedItems[0].PreviousReportNode | Should -BeOfType ([TableNode])
            $comparer.ChangedItems[0].PreviousReportNode.Headers | Should -Be "Name|Value"
            $comparer.ChangedItems[0].PreviousReportNode.Rows | Should -BeArray @("A1|A2", "B1|B2")
            $comparer.ChangedItems[0].CurrentReportNode | Should -BeOfType ([TableNode])
            $comparer.ChangedItems[0].CurrentReportNode.Headers | Should -Be "Name|Value"
            $comparer.ChangedItems[0].CurrentReportNode.Rows | Should -BeArray @("A1|A2", "B3|B4")
        }

        It "Rows are changed and updated at the same time" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddNode([TableNode]::new("Name|Value", @("A1|A2", "B1|B2")))

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddNode([TableNode]::new("Name|Value", @("A1|A2", "B3|B4", "C1|C2")))
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 0
            $comparer.ChangedItems | Should -HaveCount 1
            $comparer.DeletedItems | Should -HaveCount 0

            $comparer.ChangedItems[0].PreviousReportNode | Should -BeOfType ([TableNode])
            $comparer.ChangedItems[0].PreviousReportNode.Headers | Should -Be "Name|Value"
            $comparer.ChangedItems[0].PreviousReportNode.Rows | Should -BeArray @("A1|A2", "B1|B2")
            $comparer.ChangedItems[0].CurrentReportNode | Should -BeOfType ([TableNode])
            $comparer.ChangedItems[0].CurrentReportNode.Headers | Should -Be "Name|Value"
            $comparer.ChangedItems[0].CurrentReportNode.Rows | Should -BeArray @("A1|A2", "B3|B4", "C1|C2")
        }

        It "Rows are changed and removed at the same time" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddNode([TableNode]::new("Name|Value", @("A1|A2", "B1|B2", "C1|C2")))

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddNode([TableNode]::new("Name|Value", @("A1|A2", "B3|B4")))
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 0
            $comparer.ChangedItems | Should -HaveCount 1
            $comparer.DeletedItems | Should -HaveCount 0

            $comparer.ChangedItems[0].PreviousReportNode | Should -BeOfType ([TableNode])
            $comparer.ChangedItems[0].PreviousReportNode.Headers | Should -Be "Name|Value"
            $comparer.ChangedItems[0].PreviousReportNode.Rows | Should -BeArray @("A1|A2", "B1|B2", "C1|C2")
            $comparer.ChangedItems[0].CurrentReportNode | Should -BeOfType ([TableNode])
            $comparer.ChangedItems[0].CurrentReportNode.Headers | Should -Be "Name|Value"
            $comparer.ChangedItems[0].CurrentReportNode.Rows | Should -BeArray @("A1|A2", "B3|B4")
        }

        It "Rows are not changed" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddNode([TableNode]::new("Name|Value", @("A1|A2", "B1|B2")))

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddNode([TableNode]::new("Name|Value", @("A1|A2", "B1|B2")))
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 0
            $comparer.ChangedItems | Should -HaveCount 0
            $comparer.DeletedItems | Should -HaveCount 0
        }

        It "Rows are not changed but header is changed" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddNode([TableNode]::new("Name|Value", @("A1|A2", "B1|B2")))

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddNode([TableNode]::new("Name|Value2", @("A1|A2", "B1|B2")))
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 0
            $comparer.ChangedItems | Should -HaveCount 0
            $comparer.DeletedItems | Should -HaveCount 0
        }

        It "Rows are changed and header is changed at the same time" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddHeader("MyHeader").AddNode([TableNode]::new("Name|Value", @("A1|A2", "B1|B2")))

            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddHeader("MyHeader").AddNode([TableNode]::new("Name|Value2", @("A1|A2", "B1|B2", "C1|C2")))
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()

            $comparer.AddedItems | Should -HaveCount 1
            $comparer.ChangedItems | Should -HaveCount 0
            $comparer.DeletedItems | Should -HaveCount 1

            $comparer.AddedItems[0].PreviousReportNode | Should -BeNullOrEmpty
            $comparer.AddedItems[0].CurrentReportNode | Should -BeOfType ([TableNode])
            $comparer.AddedItems[0].CurrentReportNode.Headers | Should -Be "Name|Value2"
            $comparer.AddedItems[0].CurrentReportNode.Rows | Should -BeArray @("A1|A2", "B1|B2", "C1|C2")

            $comparer.DeletedItems[0].PreviousReportNode | Should -BeOfType ([TableNode])
            $comparer.DeletedItems[0].PreviousReportNode.Headers | Should -Be "Name|Value"
            $comparer.DeletedItems[0].PreviousReportNode.Rows | Should -BeArray @("A1|A2", "B1|B2")
            $comparer.DeletedItems[0].CurrentReportNode | Should -BeNullOrEmpty
        }
    }

    Describe "NoteNode" {
        It "NoteNode is ignored from report" {
            $prevReport = [HeaderNode]::new("Version 1")
            $prevReport.AddNote("MyFirstNote")
            $prevReport.AddHeader("MyFirstHeader").AddNote("MyFirstSubNote")
    
            $nextReport = [HeaderNode]::new("Version 2")
            $nextReport.AddNote("MySecondNote")
            $nextReport.AddHeader("MySecondHeader").AddNote("MySecondSubNote")
            
            $comparer = [SoftwareReportDifferenceCalculator]::new($prevReport, $nextReport)
            $comparer.CompareReports()
    
            $comparer.AddedItems | Should -HaveCount 0
            $comparer.ChangedItems | Should -HaveCount 0
            $comparer.DeletedItems | Should -HaveCount 0
        }
    }
}