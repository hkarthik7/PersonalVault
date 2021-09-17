function Add-PSSecret {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Name,

        [Parameter(Mandatory = $true, Position = 1, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Value,

        [Parameter(
            Mandatory = $true, 
            Position = 2, 
            HelpMessage = "Provide the details of what you are storing",
            ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Metadata,

        [ValidateNotNullOrEmpty()]
        [string] $Key = (Get-PSKey -WarningAction SilentlyContinue)
    )
    
    process {        
        if (_isValidConnection (_getConnectionObject)) {
            _isHacked $Value

            if (_isNameExists $Name) { Write-Warning "Given name '$Name' already exists; Pass different name and try again." }

            else {    
                $encryptedValue = _encrypt -plainText $Value -key $Key
    
                # create the database and save the KV pair
                $null = _createDb
    
                Invoke-SqliteQuery `
                    -DataSource (_getDbPath) `
                    -Query "INSERT INTO _ (Name, Value, Metadata) VALUES (@N, @V, @M)" `
                    -SqlParameters @{
                    N = $Name
                    V = $encryptedValue
                    M = $Metadata
                }

                # cleaning up
                _clearHistory $MyInvocation.MyCommand.Name
            }
        } else { _connectionWarning }
    }
}