function Remove-PSPersonalVaultConnection {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param (        
        [switch] $Force
    )
    
    process {
        if (_isValidConnection (_getConnectionObject)) {
            if ($Force.IsPresent -or $PSCmdlet.ShouldProcess("Connection", "Remove-PSPersonalVaultConnection")) {
                _clearConnection
            }
        } else { _connectionWarning }
    }
}