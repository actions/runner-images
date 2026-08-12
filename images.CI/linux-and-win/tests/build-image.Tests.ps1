Describe "build-image.ps1 parameter sets" {
    BeforeAll {
        $scriptPath = (Resolve-Path (Join-Path $PSScriptRoot "..\build-image.ps1")).Path
        $command = Get-Command -Name $scriptPath
    }

    It "defines exactly two parameter sets" {
        $command.ParameterSets | Should -HaveCount 2
    }

    It "requires temp resource group parameters in TempResourceGroup set" {
        $tempSet = $command.ParameterSets | Where-Object Name -eq "TempResourceGroup"
        $tempSet | Should -Not -BeNullOrEmpty

        ($tempSet.Parameters | Where-Object Name -eq "Location") | Should -Not -BeNullOrEmpty
        ($tempSet.Parameters | Where-Object Name -eq "Location").IsMandatory | Should -BeTrue

        ($tempSet.Parameters | Where-Object Name -eq "TempResourceGroupName") | Should -Not -BeNullOrEmpty
        ($tempSet.Parameters | Where-Object Name -eq "TempResourceGroupName").IsMandatory | Should -BeTrue

        $tempSet.Parameters.Name | Should -Not -Contain "ExistingResourceGroupName"
    }

    It "requires existing resource group parameter in ExistingResourceGroup set" {
        $existingSet = $command.ParameterSets | Where-Object Name -eq "ExistingResourceGroup"
        $existingSet | Should -Not -BeNullOrEmpty

        ($existingSet.Parameters | Where-Object Name -eq "ExistingResourceGroupName") | Should -Not -BeNullOrEmpty
        ($existingSet.Parameters | Where-Object Name -eq "ExistingResourceGroupName").IsMandatory | Should -BeTrue

        $existingSet.Parameters.Name | Should -Not -Contain "Location"
        $existingSet.Parameters.Name | Should -Not -Contain "TempResourceGroupName"
    }
}

Describe "build-image.ps1 switch" {
    BeforeAll {
        $scriptPath = (Resolve-Path (Join-Path $PSScriptRoot "..\build-image.ps1")).Path

        Mock -CommandName Write-Host

        $global:packerInvocations = @()
        Mock -CommandName packer -MockWith {
            param(
                [Parameter(ValueFromRemainingArguments = $true)]
                [string[]] $arguments
            )

            $global:packerInvocations += ,$arguments
            "mocked packer output"
        }
    }

    Context "TempResourceGroup" {
        It "calls packer build with temp resource group parameters" {

            & $scriptPath   -TemplatePath ".\" `
                            -BuildTemplateName "template.TestBuild" `
                            -TempResourceGroupName "TestTempRG" `
                            -ClientId "TestClientId" `
                            -Location "TestLocation" `
                            -ImageName "TestImage" `
                            -ImageResourceGroupName "TestImageRG" `
                            -SubscriptionId "TestSubId" `
                            -TenantId "TestTenantId" `
                            -ImageOS "TestOS" | Out-Null

            Should -Invoke -CommandName Write-Host -Times 1 -Exactly -ParameterFilter {
                $Object -eq "Use temporary resource group TestTempRG"
            }

            Should -Invoke -CommandName packer -Times 1 -Exactly -ParameterFilter {
                $arguments -contains "temp_resource_group_name=TestTempRG" -and
                $arguments -contains "location=TestLocation" -and
                $arguments -contains "-var"
            }
        }
    }

    Context "ExistingResourceGroup" {
        It "calls packer build with existing resource group parameters" {

            & $scriptPath   -TemplatePath ".\" `
                            -BuildTemplateName "template.TestBuild" `
                            -ExistingResourceGroupName "TestExistingRG" `
                            -ClientId "TestClientId" `
                            -ImageName "TestImage" `
                            -ImageResourceGroupName "TestImageRG" `
                            -SubscriptionId "TestSubId" `
                            -TenantId "TestTenantId" `
                            -ImageOS "TestOS" | Out-Null

            Should -Invoke -CommandName Write-Host -Times 1 -Exactly -ParameterFilter {
                $Object -eq "Use existing resource group TestExistingRG"
            }

            Should -Invoke -CommandName packer -Times 1 -Exactly -ParameterFilter {
                $arguments -contains "build_resource_group_name=TestExistingRG" -and
                $arguments -contains "-var"
            }
        }
    }
}
