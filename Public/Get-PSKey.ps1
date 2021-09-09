function Get-PSKey {
    [CmdletBinding()]
    [OutputType([string])]
    param (
        [switch] $Force
    )
    
    process {
        if (_isKeyFileExists) {
            $res = Import-Clixml (_getKeyFile)
            $key = [pscredential]::new("key", $res)
            $key = $key.GetNetworkCredential().Password
        }

        if (!(_isKeyFileExists)) {
            $key = _generateKey
            _saveKey -key $key
        }

        if ($Force.IsPresent) {
            _archiveKeyFile
            $key = _generateKey; _saveKey -key $key -force
        }

        return $key
    }
}