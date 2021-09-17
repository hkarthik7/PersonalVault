function Update-PSSecret {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param (
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ArgumentCompleter([NameCompleter])]
        [ValidateNotNullOrEmpty()]
        [string] $Name,

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Value,

        [ValidateNotNullOrEmpty()]
        [string] $Key = (Get-PSKey -WarningAction SilentlyContinue),

        [switch] $Force
    )
    
    process {
        if (_isValidConnection (_getConnectionObject)) {
            _isHacked $Value
        
            if (!(_isNameExists $Name)) { Write-Warning "Couldn't find the value for given Name '$Name'; Pass the correct value and try again." }

            else {
                if ($Force -or $PSCmdlet.ShouldProcess($Value, "Update-Secret")) {    
                    $encryptedValue = _encrypt -plainText $Value -key $Key
    
                    Invoke-SqliteQuery `
                        -DataSource (_getDbPath) `
                        -Query "UPDATE _ SET Value = '$encryptedValue' WHERE Name = '$Name'"
                
                    # cleaning up
                    _clearHistory $MyInvocation.MyCommand.Name
                }
            }
        } else { _connectionWarning }
    }    
}