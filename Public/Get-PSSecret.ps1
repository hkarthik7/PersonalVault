function Get-PSSecret {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseOutputTypeCorrectly", "")]
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ArgumentCompleter([NameCompleter])]
        [ValidateNotNullOrEmpty()]
        [string] $Name,

        [ValidateNotNullOrEmpty()]
        [string] $Key = (Get-PSKey -WarningAction SilentlyContinue),

        [switch] $AsPlainText
    )
    
    process {

        # check if the credential are valid.
        if (_isValidConnection (_getConnectionObject)) {

            $res = Invoke-SqliteQuery -DataSource (_getDbPath) -Query "SELECT * FROM _"
    
            if (!($AsPlainText.IsPresent) -and ($PSBoundParameters.ContainsKey('Name'))) {
                $res = $res | Where-Object { $_.Name -eq $Name } | Select-Object -ExpandProperty Value
                if (!$res) { Write-Warning "Couldn't find the value for given Name '$Name'; Pass the correct value and try again." }
                else { return $res }
            }
    
            if ($AsPlainText.IsPresent -and ($PSBoundParameters.ContainsKey('Name'))) {
                $res = $res | Where-Object { $_.Name -eq $Name } | Select-Object -ExpandProperty Value   
                if (!$res) { Write-Warning "Couldn't find the value for given Name '$Name'; Pass the correct value and try again." }
                else { return _decrypt -encryptedText $res -key $Key }
            }
    
            if ($AsPlainText.IsPresent -and !($PSBoundParameters.ContainsKey('Name'))) {
                $result = @()
                $res | ForEach-Object {
                    $r = [PSCustomObject]@{
                        Name = $_.Name
                        Value = (_decrypt -encryptedText $_.Value -key $Key)
                        Metadata = $_.Metadata
                    }
                    $result += $r
                }
                if ([bool] ($result.Value)) { return $result }
            }
    
            else { return $res }
        } else { _connectionWarning }
    }
}