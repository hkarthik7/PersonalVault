function Update-Help {
    
    [CmdletBinding()]
    param (
        [string]
        $ModuleName = ".\$(Get-ProjectName)",

        [string]
        $Directory = ".\docs",

        [string]
        $OutputDirectory = (".\$(Get-ProjectName)\en-US"),

        [switch]
        $CreateMarkDown,

        [switch]
        $UpdateMarkDown,

        [switch]
        $ExternalHelp
    )

    #import module
    Import-Module $ModuleName -Force

    if ($CreateMarkDown) {
        Write-Output "Generating Markdown help files"
        New-MarkdownHelp -Module $ModuleName -OutputFolder $Directory -ErrorAction SilentlyContinue | Out-Null
    }

    if ($UpdateMarkDown) {
        Write-Output "Updating Markdown help files"
        Update-MarkdownHelp -Path $Directory | Out-Null
    }

    if ($ExternalHelp) {
        Write-Output "Generating External help files"
        New-ExternalHelp -Path $Directory -OutputPath $OutputDirectory -Force | Out-Null
    }
}