function Remove-PSSecret {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ArgumentCompleter([NameCompleter])]
        [ValidateNotNullOrEmpty()]
        [string] $Name,

        [switch] $Force
    )
    
    process {
        if (_isValidConnection (_getConnectionObject)) {
            if (!(_isNameExists $Name)) { Write-Warning "Couldn't find the value for given Name '$Name'; Pass the correct value and try again." }

            else {
                if ($Force -or $PSCmdlet.ShouldProcess($Name, "Remove-Secret")) {
                    Invoke-SqliteQuery -DataSource (_getDbPath) -Query "DELETE FROM _ WHERE Name = '$Name'"
                }
            }
        } else { _connectionWarning }
    }
}