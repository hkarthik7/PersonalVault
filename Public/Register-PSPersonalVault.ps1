function Register-PSPersonalVault {
    [CmdletBinding(DefaultParameterSetName = "Default")]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [pscredential] $Credential,

        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [securestring] $RecoveryWord,

        [switch] $Force
    )
    
    process {
        $personalVault = [PersonalVault]::new()
        $personalVault.UserName = if ([string]::IsNullOrEmpty($Credential.UserName)) { _getUser } else { $Credential.UserName }
        $personalVault.Password = $Credential.Password
        $personalVault.Key = $RecoveryWord

        if (!(Test-Path (_getConnectionFile))) { $personalVault | Export-Clixml -Path (_getConnectionFile) }

        if ($Force.IsPresent) {
            if (_isValidConnection (_getConnectionObject)) {
                $personalVault | Export-Clixml -Path (_getConnectionFile) -Force
            } else { _connectionWarning }
        }
    }
}