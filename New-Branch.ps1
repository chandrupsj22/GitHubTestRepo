<#
    .SYNOPSIS

    Creates a new branch.

    .DESCRIPTION

    Creates a new branch from an exsisting branch. Requires the name of the branch to branch from.

    .EXAMPLE
    New-Branch -Username <> -Password <> -Environment <> -Repo <> -BranchName <> -BrachFrom <>
#>

function New-Branch
{

Param(
        [Parameter(Mandatory=$true)][System.Management.Automation.PSCredential]$Credentials,
        [Parameter(Mandatory=$true)][string]$GithubProject,
        [Parameter(Mandatory=$true)][string]$GithubRepo,
        [Parameter(Mandatory=$true)][string]$NewBranchName,
        [Parameter(Mandatory=$true)][string]$BranchFrom
    )

    Write-Host "Checking existing branches, via New-Branch function"
    $ExistingBranches = Get-Branches -Credentials $Credentials -GithubProject $GithubProject -GithubRepo $GithubRepo
     
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    if($ExistingBranches -contains "refs/heads/$BranchFrom")
    {
        $Server = "https://api.github.com/repos"
           
        $Auth64Encoded = Get-Base64Auth -Credentials $Credentials

        $PostBody = @{'name'=$NewBranchName;'startPoint'="refs/heads/"+$BranchFrom}
        $PostBody = ConvertTo-Json $PostBody
        $Rest_Url = "{0}/{1}/{2}/branches" -f $Server,$GithubProject,$GithubRepo

        $Request = Invoke-RestMethod -Uri $Rest_Url -Method POST -Headers @{'Authorization'= $Auth64Encoded} -Body $PostBody -ContentType "application/json" -DisableKeepAlive

        ($Request).Name
    }
    else{
        throw "Source Branch not found"
    }
}