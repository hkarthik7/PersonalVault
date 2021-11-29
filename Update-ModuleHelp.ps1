function Update-ModuleHelp {
    
    [CmdletBinding()]
    param (
        [string]
        $ModuleName = (Join-Path -Path $PWD.Path -ChildPath (Get-ProjectName)),

        [string]
        $Directory = (Join-Path -Path $PWD.Path -ChildPath "docs"),

        [string]
        $OutputDirectory = (Join-Path -Path $PWD.Path -ChildPath "en-US"),

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