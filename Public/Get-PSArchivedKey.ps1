function Get-PSArchivedKey {
    [CmdletBinding()]
    [OutputType([object[]])]
    param (
        [ValidateNotNullOrEmpty()]
        [datetime] $DateModified
    )
    
    process {
        if (Test-Path "$(Split-Path -Path (_getKeyFile) -Parent)\archive") {
            $results = @()
            $archivedFiles = Get-ChildItem -Path "$(Split-Path -Path (_getKeyFile) -Parent)\archive" | Select-Object FullName, LastWriteTime
    
            if ($PSBoundParameters.ContainsKey('DateModified')) {
                $archivedFiles = $archivedFiles | Where-Object { (Get-Date $_.LastWriteTime -Format ddMMyyyy) -eq (Get-Date $DateModified -Format ddMMyyyy) }
            }
            
            $archivedFiles | ForEach-Object {
                $key = Import-Clixml $_.FullName
                $keyObj = [pscredential]::new("key", $key)
    
                $obj = [PSCustomObject]@{
                    DateModified = $_.LastWriteTime
                    Key = $keyObj.GetNetworkCredential().Password
                }
    
                $results += $obj
    
            }
            return $results
        }
    }
}