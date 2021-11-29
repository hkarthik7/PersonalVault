function Get-PSSecret {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseOutputTypeCorrectly", "")]
    [CmdletBinding()]
    param (
        [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [ArgumentCompleter([NameCompleter])]
        [ValidateNotNullOrEmpty()]
        [string] $Name,

        [Parameter(Position = 1, ValueFromPipelineByPropertyName = $true)]
        [ArgumentCompleter([IdCompleter])]
        [ValidateNotNullOrEmpty()]
        [int] $Id,

        [ValidateNotNullOrEmpty()]
        [string] $Key = (Get-PSKey -WarningAction SilentlyContinue),

        [switch] $AsPlainText
    )
    
    process {

        # check if the credentials are valid.
        if (_isValidConnection (_getConnectionObject)) {
            if ($AsPlainText.IsPresent) {
                if (($PSBoundParameters.ContainsKey('Name')) -and ($PSBoundParameters.ContainsKey('Id'))) {
                    $res = (_selectValueFromDB -name $Name -id $Id).Value
                    if (($null -eq $res) -or ([string]::IsNullOrEmpty($res))) { 
                        Write-Warning "Couldn't find the value for given Name '$Name' and Id '$Id'; Pass the correct value and try again." 
                    }
                    else { return _decrypt -encryptedText $res -key $Key }
                }

                if (!($PSBoundParameters.ContainsKey('Name')) -and ($PSBoundParameters.ContainsKey('Id'))) {
                    $res = (_selectValueFromDB -id $Id).Value
                    if (($null -eq $res) -or ([string]::IsNullOrEmpty($res))) { 
                        Write-Warning "Couldn't find the value for given Id '$Id'; Pass the correct value and try again." 
                    }
                    else { return _decrypt -encryptedText $res -key $Key }
                }

                if (($PSBoundParameters.ContainsKey('Name')) -and !($PSBoundParameters.ContainsKey('Id'))) {
                    $res = (_selectValueFromDB -name $Name).Value
                    if (($null -eq $res) -or ([string]::IsNullOrEmpty($res))) { 
                        Write-Warning "Couldn't find the value for given Name '$Name'; Pass the correct value and try again." 
                    }
                    else { 
                        $result = @()
                        $res | ForEach-Object {
                            $result += (_decrypt -encryptedText $_ -key $Key)
                        }
                        return $result
                    }
                }

                $result = @()
                $res = _selectValueFromDB

                $res | ForEach-Object {
                    $r = [PSCustomObject]@{
                        Id = $_.Id
                        Name = $_.Name
                        Value = (_decrypt -encryptedText $_.Value -key $Key)
                        Metadata = $_.Metadata
                        AddedOn = if ($null -ne $_.AddedOn) { Get-Date $_.AddedOn } else { $_.AddedOn }
                        UpdatedOn = if ($null -ne $_.UpdatedOn) { Get-Date $_.UpdatedOn } else { $_.UpdatedOn }
                    }
                    $result += $r
                }
                if ([bool] ($result.Value)) { return $result }

            }

            else {
                if (($PSBoundParameters.ContainsKey('Name')) -and ($PSBoundParameters.ContainsKey('Id'))) {
                    $res = (_selectValueFromDB -name $Name -id $Id).Value
                    if (($null -eq $res) -or ([string]::IsNullOrEmpty($res))) { 
                        Write-Warning "Couldn't find the value for given Name '$Name' and Id '$Id'; Pass the correct value and try again." 
                    }
                    else { return $res }
                }

                if (!($PSBoundParameters.ContainsKey('Name')) -and ($PSBoundParameters.ContainsKey('Id'))) {
                    $res = (_selectValueFromDB -id $Id).Value
                    if (($null -eq $res) -or ([string]::IsNullOrEmpty($res))) { 
                        Write-Warning "Couldn't find the value for given Id '$Id'; Pass the correct value and try again." 
                    }
                    else { return $res }
                }

                if (($PSBoundParameters.ContainsKey('Name')) -and !($PSBoundParameters.ContainsKey('Id'))) {
                    $res = (_selectValueFromDB -name $Name).Value
                    if (($null -eq $res) -or ([string]::IsNullOrEmpty($res))) { 
                        Write-Warning "Couldn't find the value for given Name '$Name'; Pass the correct value and try again." 
                    }
                    else { return $res }
                }

                $result = @()
                $res = _selectValueFromDB

                $res | ForEach-Object {
                    $r = [PSCustomObject]@{
                        Id = $_.Id
                        Name = $_.Name
                        Value = $_.Value
                        Metadata = $_.Metadata
                        AddedOn = if ($null -ne $_.AddedOn) { Get-Date $_.AddedOn } else { $_.AddedOn }
                        UpdatedOn = if ($null -ne $_.UpdatedOn) { Get-Date $_.UpdatedOn } else { $_.UpdatedOn }
                    }
                    $result += $r
                }
                if ([bool] ($result.Value)) { return $result }
            }

        } else { _connectionWarning }
    }
}