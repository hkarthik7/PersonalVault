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

            $encryptedValue = _encrypt -plainText $Value -key $Key

            # create the database and save the KV pair
            $null = _createDb

            Invoke-SqliteQuery `
                -DataSource (_getDbPath) `
                -Query "INSERT INTO _ (Name, Value, Metadata, AddedOn, UpdatedOn) VALUES (@N, @V, @M, @D, @U)" `
                -SqlParameters @{
                N = $Name
                V = $encryptedValue
                M = $Metadata
                D = Get-Date
                U = $null
            }

            # cleaning up
            _clearHistory $MyInvocation.MyCommand.Name
            
        } else { _connectionWarning }
    }
}