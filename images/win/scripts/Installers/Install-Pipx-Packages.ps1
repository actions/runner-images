$pipxToolset = (Get-ToolsetContent).pipx
foreach($tool in $pipxToolset) {
    if ($tool.python) {
        $pythonPath =  "${env:AGENT_TOOLSDIRECTORY}\Python\${tool.python}*\${env:AGENT_OSARCHITECTURE}\python-${tool.python}*"
        Write-Host "Install ${tool.package} into python ${tool.python}"
        pipx install $tool.package --python $python_path
    } else {
        Write-Host "Install ${tool.package} into default python"
        pipx install $tool.package
    }
    Invoke-PesterTests -TestFile "PipxPackages" -TestName $tool.package
}