Param (
    [Parameter(Mandatory)]
    [string] $WorkflowRunId,
    [Parameter(Mandatory)]
    [string] $Repository,
    [Parameter(Mandatory)]
    [string] $AccessToken,
    [int] $RetryIntervalSeconds = 300,
    [int] $MaxRetryCount = 0
)

Import-Module (Join-Path $PSScriptRoot "GitHubApi.psm1")

function Wait-ForWorkflowCompletion($WorkflowRunId, $RetryIntervalSeconds) {
    do {
        Start-Sleep -Seconds $RetryIntervalSeconds
        $workflowRun = $gitHubApi.GetWorkflowRun($WorkflowRunId)
    } until ($workflowRun.status -eq "completed")

    return $workflowRun
}

$gitHubApi = Get-GithubApi -Repository $Repository -AccessToken $AccessToken

$attempt = 1
do {
    $finishedWorkflowRun = Wait-ForWorkflowCompletion -WorkflowRunId $WorkflowRunId -RetryIntervalSeconds $RetryIntervalSeconds
    Write-Host "Workflow run finished with result: $($finishedWorkflowRun.conclusion)"
    if ($finishedWorkflowRun.conclusion -in ("success", "cancelled", "timed_out")) {
        break
    } elseif ($finishedWorkflowRun.conclusion -eq "failure") {
        if ($attempt -le $MaxRetryCount) {
            Write-Host "Workflow run will be restarted. Attempt $attempt of $MaxRetryCount"
            $gitHubApi.ReRunFailedJobs($WorkflowRunId)
            $attempt += 1
        } else {
            break
        }
    }
} while ($true)

Write-Host "Last result: $($finishedWorkflowRun.conclusion)."
"CI_WORKFLOW_RUN_RESULT=$($finishedWorkflowRun.conclusion)" | Out-File -Append -FilePath $env:GITHUB_ENV

if ($finishedWorkflowRun.conclusion -in ("failure", "cancelled", "timed_out")) {
    exit 1
}
