<#
    .SYNOPSIS

    Get all branches of repo.

    .DESCRIPTION

    Given project name and repo name, fetches all branches for that repo.

    .EXAMPLE
    Get-Branches -Username <> -Password <> -Environment <> -Repo <>
#>


function Get-Branches
{
    Param(
        [Parameter(Mandatory=$true)][System.Management.Automation.PSCredential]$Credentials,
        [Parameter(Mandatory=$true)][string]$GithubProject,
        [Parameter(Mandatory=$true)][string]$GithubRepo
    )

    $Server  = "https://api.github.com/repos"

    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    $Auth64Encoded = Get-Base64Auth -Credentials $Credentials

    $Rest_Url = "{0}/{1}/{2}/branches" -f $Server,$GithubProject,$GithubRepo
    $Request = Invoke-RestMethod -Uri $Rest_Url -Method Get -Headers @{'Authorization'= $Auth64Encoded} -DisableKeepAlive

    ($Request).Name
}