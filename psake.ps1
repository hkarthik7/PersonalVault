# Ins some system tests won't run if TLS version isn't set.
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Install dependencies
$RequiredModules = @("psake", "Pester", "BuildHelpers", "PSScriptAnalyzer", "platyPS", "PSSQlite")
$RequiredModules | ForEach-Object {
    if (-not (Get-Module -ListAvailable $_)) {
        Write-Output "Installing module $($_)"
        Install-Module -Name $_ -SkipPublisherCheck -Scope CurrentUser -Force -Repository PSGallery -AllowClobber
    }
}

# create folders if not exists
if (!(Test-Path "$($PWD.Path)\PersonalVault")) {
    $null = New-Item -Path $PWD.Path -ItemType Directory -Name "PersonalVault"
}
if (!(Test-Path "$($PWD.Path)\Tests\results")) {
    $null = New-Item -Path "$($PWD.Path)\Tests" -ItemType Directory -Name "results"
}

Invoke-psake (Join-Path -Path $PWD.Path -ChildPath "build.ps1") Clean, Build, UpdateManifest, Analyze, Test -nologo