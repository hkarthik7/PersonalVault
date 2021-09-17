function Import-PSPersonalVault {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [securestring] $RecoveryWord
    )
    
    process {
        if (_isValidConnection (_getConnectionObject)) {
            if (_isValidRecoveryWord $RecoveryWord) {
                $res = Import-Clixml -Path (_getConnectionFile)
                return [PSCustomObject]@{
                    UserName = $res.UserName
                    Password = ([pscredential]::new("P", $res.Password)).GetNetworkCredential().Password
                }
            } else {
                Write-Warning "Recovery word is incorrect. Please pass the valid recovery word and try again."
            }
        } else { _connectionWarning }
    }
}