function Remove-PSPersonalVault {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param (
        [switch] $Force
    )
    
    process {
        if ($Force.IsPresent -or $PSCmdlet.ShouldProcess("Peronal Vault", "Remove-PSPersonalVault")) {
            _clearPersonalVault
        }
    }
}