function Remove-PSPersonalVault {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param (        
        [switch] $Force
    )
    
    process {
        if (_isValidConnection (_getConnectionObject)) {
            if ($Force.IsPresent -or $PSCmdlet.ShouldProcess("Peronal Vault", "Remove-PSPersonalVault")) {
                _clearPersonalVault
            }
        } else { _connectionWarning }
    }
}