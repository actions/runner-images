Describe "PipxPackages" {
    $pipxToolset = (Get-ToolsetContent).pipx
    foreach($tool in $pipxToolset) {
        It "${tool.package}" {
            "${tool.cmd}" | Should -ReturnZeroExitCode
        }
    }
}