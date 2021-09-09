function Get-PSSecret {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseOutputTypeCorrectly", "")]
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ValidateNotNullOrEmpty()]
        [string] $Name,

        [switch] $AsPlainText
    )
    
    process {
        _unhideFile (_getDbPath)

        $res = Invoke-SqliteQuery -DataSource (_getDbPath) -Query "SELECT * FROM _"

        _hideFile (_getDbPath)

        if (!($AsPlainText.IsPresent) -and ($PSBoundParameters.ContainsKey('Name'))) {
            $res = $res | Where-Object { $_.Name -eq $Name } | Select-Object -ExpandProperty Value   
            if (!$res) { Write-Warning "Couldn't find the value for given Name '$Name'; Pass the correct value and try again." }
            else { return $res }
        }

        if ($AsPlainText.IsPresent -and ($PSBoundParameters.ContainsKey('Name'))) {
            $res = $res | Where-Object { $_.Name -eq $Name } | Select-Object -ExpandProperty Value   
            if (!$res) { Write-Warning "Couldn't find the value for given Name '$Name'; Pass the correct value and try again." }
            else { return _decrypt -encryptedText $res -key (Get-PSKey) }
        }

        if ($AsPlainText.IsPresent -and !($PSBoundParameters.ContainsKey('Name'))) {
            $result = @()
            $res | ForEach-Object {
                $r = [PSCustomObject]@{
                    Name = $_.Name
                    Value = (_decrypt -encryptedText $_.Value -key (Get-PSKey))
                }
                $result += $r
            }
            return $result
        }
    }
}