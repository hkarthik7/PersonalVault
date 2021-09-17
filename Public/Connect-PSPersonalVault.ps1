function Connect-PSPersonalVault {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseOutputTypeCorrectly", "")]
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [pscredential] $Credential
    )
    
    process {
        $personalVault = [PersonalVault]::new()

        $personalVault.UserName = if ([string]::IsNullOrEmpty($Credential.UserName)) { _getUser } else { $Credential.UserName }
        $personalVault.Password = $Credential.Password
        
        # Return the PersonalVault object so that it can be consumed and verified by other cmdlets
        _setEnvironmentVariable -key "PERSONALVAULT_U" -value $personalVault.UserName
        _setEnvironmentVariable -key "PERSONALVAULT_P" -value ($personalVault.Password | ConvertFrom-SecureString)
        
        return $personalVault
    }
}