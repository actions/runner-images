$pipxToolset = (Get-ToolsetContent).pipx
foreach($tool in $pipxToolset) {
    if ($tool.python) {
        $pythonPath = (Get-Item  -Path "${env:AGENT_TOOLSDIRECTORY}\Python\${tool.python}.*\x64\python-${tool.python}*").FullName
        Write-Host "Install ${tool.package} into python ${tool.python}"
        pipx install $tool.package --python $pythonPath
    } else {
        Write-Host "Install ${tool.package} into default python"
        pipx install $tool.package
    }
}
Invoke-PesterTests -TestFile "PipxPackages"