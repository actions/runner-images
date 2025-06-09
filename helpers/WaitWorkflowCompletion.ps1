Param (
    [Parameter(Mandatory)]
    [string] $WorkflowFileName,
    [Parameter(Mandatory)]
    [string] $WorkflowSearchPattern,
    [Parameter(Mandatory)]
    [string] $Repository,
    [Parameter(Mandatory)]
    [string] $AccessToken,
    [int] $AttemptTimeoutInMinutes = 340,
    [int] $RetryIntervalSeconds = 300,
    [int] $MaxRetryCount = 1
)

Import-Module (Join-Path $PSScriptRoot "GitHubApi.psm1")

function Find-TriggeredWorkflow($WorkflowFileName, $WorkflowSearchPattern) {
    $workflowRuns = $gitHubApi.GetWorkflowRuns($WorkflowFileName).workflow_runs
    $workflowRunId = ($workflowRuns | Where-Object {$_.display_title -match $WorkflowSearchPattern}).id | Select-Object -First 1

    if ([string]::IsNullOrEmpty($workflowRunId)) {
        throw "Failed to find a workflow run for '$WorkflowSearchPattern'."
    } else {
        return $workflowRunId
    }
}

function Wait-ForWorkflowCompletion($WorkflowRunId, $RetryIntervalSeconds) {
    $attemptEndTime = (Get-Date).AddMinutes($AttemptTimeoutInMinutes)
    do {
        Start-Sleep -Seconds $RetryIntervalSeconds
        $workflowRun = $gitHubApi.GetWorkflowRun($WorkflowRunId)
        if ((Get-Date) -gt $attemptEndTime) {
            "CI_WORKFLOW_RUN_RESULT=$($workflowRun.status)/timeout" | Out-File -Append -FilePath $env:GITHUB_ENV
            "CI_WORKFLOW_RUN_URL=$($workflowRun.html_url)" | Out-File -Append -FilePath $env:GITHUB_ENV
            $gitHubApi.CancelWorkflowRun($workflowRunId)
            throw "The workflow run is still in the '$($workflowRun.status)' state for $AttemptTimeoutInMinutes minutes. Cancelling the run."
        }
    } until ($workflowRun.status -eq "completed")

    return $workflowRun
}

$gitHubApi = Get-GithubApi -Repository $Repository -AccessToken $AccessToken

$workflowRunId = Find-TriggeredWorkflow -WorkflowFileName $WorkflowFileName -WorkflowSearchPattern $WorkflowSearchPattern
$workflowRun = $gitHubApi.GetWorkflowRun($workflowRunId)
Write-Host "Found the workflow run with ID $workflowRunId. Workflow run link: $($workflowRun.html_url)"
"ci_workflow_run_id=$workflowRunId" | Out-File -Append -FilePath $env:GITHUB_OUTPUT

$attempt = 1
do {
    $finishedWorkflowRun = Wait-ForWorkflowCompletion -WorkflowRunId $workflowRunId -RetryIntervalSeconds $RetryIntervalSeconds
    Write-Host "Workflow run finished with result: $($finishedWorkflowRun.conclusion)"
    if ($finishedWorkflowRun.conclusion -in ("success", "cancelled")) {
        break
    } elseif ($finishedWorkflowRun.conclusion -eq "failure") {
        if ($attempt -lt $MaxRetryCount) {
            Write-Host "Workflow run will be restarted. Attempt $attempt of $MaxRetryCount"
            $gitHubApi.ReRunFailedJobs($workflowRunId)
            $attempt += 1
        } else {
            break
        }
    }
} while ($true)

Write-Host "Last result: $($finishedWorkflowRun.conclusion)."
"CI_WORKFLOW_RUN_RESULT=$($finishedWorkflowRun.conclusion)" | Out-File -Append -FilePath $env:GITHUB_ENV
"CI_WORKFLOW_RUN_URL=$($workflowRun.html_url)" | Out-File -Append -FilePath $env:GITHUB_ENV

if ($finishedWorkflowRun.conclusion -eq "success") {
    exit 0
} elseif ($finishedWorkflowRun.conclusion -in ("failure", "cancelled")) {
    exit 1
}
