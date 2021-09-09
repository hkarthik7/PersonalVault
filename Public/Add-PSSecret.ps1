function Add-PSSecret {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $true,
            Position = 0,
            ValueFromPipeline = $true, 
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Name,

        [Parameter(
            Mandatory = $true,
            Position = 1,
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Value,

        [ValidateNotNullOrEmpty()]
        [string] $Key
    )
    
    process {
        _isHacked $Value

        if (_isNameExists $Name) { Write-Warning "Given name '$Name' already exists; Pass different name and try again." }

        else {
            if (!($PSBoundParameters.ContainsKey('Key'))) {
                $Key = Get-PSKey
            }
    
            $encryptedValue = _encrypt -plainText $Value -key $Key
    
            # create the database and save the KV pair
            $null = _createDb
    
            _unhideFile (_getDbPath)
    
            Invoke-SqliteQuery `
                -DataSource (_getDbPath) `
                -Query "INSERT INTO _ (Name, Value) VALUES (@N, @V)" `
                -SqlParameters @{
                    N = $Name
                    V = $encryptedValue
                }
            
            _hideFile (_getDbPath)
        }
    }
}