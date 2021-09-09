function Get-PSSecret {
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

        if ($PSBoundParameters.ContainsKey('Name')) {
            $res = $res | Where-Object { $_.Name -eq $Name } | Select-Object -ExpandProperty Value   
            if (!$res) { Write-Warning "Couldn't find the value for given Name '$Name'; Pass the correct value and try again." }
        }

        if ($AsPlainText.IsPresent) { return _decrypt -encryptedText $res -key (Get-PSKey) }
        return $res
    }
}