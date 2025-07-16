class GithubApi
{
    [string] $Repository
    [object] hidden $AuthHeader

    GithubApi(
        [string] $Repository,
        [string] $AccessToken
    ) {
        $this.Repository = $Repository
        $this.AuthHeader = $this.BuildAuth($AccessToken)
    }

    [object] hidden BuildAuth([string]$AccessToken) {
        if ([string]::IsNullOrEmpty($AccessToken)) {
            return $null
        }
        $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("'':${AccessToken}"))
        return @{
            Authorization = "Basic ${base64AuthInfo}"
        }
    }

    [string] hidden BuildBaseUrl([string]$Repository, [string]$ApiPrefix) {
        return "https://$ApiPrefix.github.com/repos/$Repository"
    }

    [object] GetWorkflowRuns([string]$WorkflowId) {
        $url = "actions/workflows/$WorkflowId/runs"
        $response =  $this.InvokeRestMethod($url, 'GET', $null, $null)
        return $response
    }

    [object] GetWorkflowRun([string]$WorkflowRunId) {
        $url = "actions/runs/$WorkflowRunId"
        $response =  $this.InvokeRestMethod($url, 'GET', $null, $null)
        return $response
    }

    [object] DispatchWorkflow([string]$EventType, [object]$EventPayload) {
        $url = "dispatches"
        $body = @{
            "event_type"     = $EventType
            "client_payload" = $EventPayload
        } | ConvertTo-Json
        $response =  $this.InvokeRestMethod($url, 'POST', $null, $body)
        return $response
    }

    [object] CancelWorkflowRun([string]$workflowRunId) {
        $url = "actions/runs/$workflowRunId/cancel"
        $response =  $this.InvokeRestMethod($url, 'POST', $null, $null)
        return $response
    }

    [string] hidden BuildUrl([string]$url, [string]$RequestParams, [string]$ApiPrefix) {
        $baseUrl = $this.BuildBaseUrl($this.Repository, $ApiPrefix)
        if ([string]::IsNullOrEmpty($RequestParams)) {
            return "$($baseUrl)/$($url)"
        } else {
            return "$($baseUrl)/$($url)?$($requestParams)"
        }
    }

    [object] hidden InvokeRestMethod(
        [string] $url,
        [string] $Method,
        [string] $RequestParams,
        [string] $body
    ) {
        $requestUrl = $this.BuildUrl($url, $RequestParams, "api")
        $params = @{
            Method      = $Method
            ContentType = "application/json"
            Uri         = $requestUrl
            Headers     = @{}
        }
        if ($this.AuthHeader) {
            $params.Headers += $this.AuthHeader
        }
        if (![string]::IsNullOrEmpty($body)) {
            $params.Body = $body
        }

        $response = Invoke-RestMethod @params
        return $response
    }
}

function Get-GithubApi {
    param (
        [string] $Repository,
        [string] $AccessToken
    )

    return [GithubApi]::New($Repository, $AccessToken)
}
