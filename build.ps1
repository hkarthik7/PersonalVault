# Clean, build, analyze, test and publish test results. (CI)
# Publish module (CD)

[CmdletBinding()]
param (
    [Parameter(Mandatory = $false, Position = 0)]
    [string] $ModuleName = (Get-ProjectName),

    [Parameter(Mandatory = $false, Position = 1)]
    [ValidateSet("Major", "Minor", "Patch", "Build")]
    [string] $Version = "Patch"
)

$root = Split-Path $PSCommandPath

Task Clean {
    #region module refresh
    if (Get-Module $ModuleName) {
        Remove-Module $ModuleName
    }
    #endregion module refresh
}

Task Build {
    # import the merge function
    . .\Merge-Files.ps1

    # move all the functions to module file.
    Merge-Files -InputDirectory .\Classes -OutputDirectory .\PersonalVault\PersonalVault.classes.ps1 -Classes
    Merge-Files -InputDirectory .\Private\, .\Public\ -OutputDirectory .\PersonalVault\PersonalVault.functions.ps1 -Functions
    Copy-Item -Path ("$($PWD.Path)\PersonalVault.psm1", "$($PWD.Path)\PersonalVault.psd1") -Destination "$($PWD.Path)\PersonalVault\"
}

Task UpdateManifest {
    # import and copy only public functions to manifest file.
    Import-Module "$root\$ModuleName\$ModuleName.psm1" -Force
    $functions = (Get-Command -Module $ModuleName).Name | Where-Object {$_ -like "*-*"}

    # Bump the version of the module
    Step-ModuleVersion -Path (Get-PSModuleManifest) -By $Version
    Set-ModuleFunction -Name (Get-PSModuleManifest) -FunctionsToExport $functions
}

Task Analyze {
    # run PSScriptAnalyzer
    Write-Output "Running Static code analyzer"
    Invoke-ScriptAnalyzer -Path .\PersonalVault -Recurse -ReportSummary -ExcludeRule PSAvoidUsingConvertToSecureStringWithPlainText
}

Task Test {
    Write-Output "Running Pester tests"
    Invoke-Pester .\Tests -OutputFormat NUnitXml -OutputFile ".\Tests\results\test-results.xml" -Show All -WarningAction SilentlyContinue
}