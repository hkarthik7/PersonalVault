function _generateKey {
    $newChar = @()
    $char = [char[]](48..93)
    $char += [char[]](97..122)

    For($i=0; $i -lt $char.Count; $i++) {
        $newChar += $char[$i]
    }
    
    [String]$p = Get-Random -InputObject $newChar -Count 32
    return $p.Replace(" ","")
}

function _getBytes([string] $key) {
    return [System.Text.Encoding]::UTF8.GetBytes($key)
}

function _encrypt([string] $plainText, [string] $key) {
    return $plainText | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString -Key (_getBytes $key)
}

function _decrypt {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string] $encryptedText,

        [Parameter(Mandatory)]
        [string] $key
    )
    try {
        $cred = [pscredential]::new("x", ($encryptedText | ConvertTo-SecureString -Key (_getBytes $key) -ErrorAction SilentlyContinue))
        return $cred.GetNetworkCredential().Password   
    }
    catch {
        Write-Warning "Cannot get the value as plain text; Use the right key to get the secret value as plain text."
    }
}

function _getOS {
    if ($env:OS -match 'Windows') { return 'Windows' }
    elseif ($IsLinux) { return 'Linux' }
    elseif ($IsMacOs -or $IsOSX) { return 'MacOs' }
}

function _getUser {
    # should work in both Mac and Linux
    return [System.Environment]::UserName
}

function _clearHistory([string] $functionName) {
    $path = (Get-PSReadLineOption).HistorySavePath

    if (!([string]::IsNullOrEmpty($path)) -and (Test-Path -Path $path)) {
        $contents = Get-Content -Path $path
        if ($contents -notmatch $functionName) { $contents -notmatch $functionName | Set-Content -Path $path -Encoding UTF8 }
    }
}

function _createDb {
    $path = Join-Path -Path $Home -ChildPath ".cos_$((_getUser).ToLower())"
    $pathExists = Test-Path $path
    $file = Join-Path -Path $path -ChildPath "_.db"
    $fileExists = Test-Path $file

    # Metadata section is required so that we know what we are storing.
    $query = "CREATE TABLE _ (
        Id INTEGER PRIMARY KEY AUTOINCREMENT,
        Name TEXT NOT NULL, 
        Value TEXT NOT NULL, 
        Metadata TEXT NOT NULL, 
        AddedOn TEXT, 
        UpdatedOn TEXT)"

    # Make ID as primary key and copy all data from old table.
    # This should run if the file exists with older schema
    if ($fileExists) {
        $columns = (Invoke-SqliteQuery -DataSource $file -Query "PRAGMA table_info(_)").name
        if (!$columns.Contains("AddedOn")) {
            $res = Invoke-SqliteQuery -DataSource $file -Query "SELECT * FROM _"
            $null = Remove-Item -Path $file -Force
            $null = New-Item -Path $file -ItemType File
            Invoke-SqliteQuery -DataSource $file -Query $query

            foreach ($i in $res) {
                $dataTable = [PSCustomObject]@{
                    Name = $i.Name
                    Value = $i.Value
                    Metadata = $i.Metadata
                    AddedOn = $null
                    UpdatedOn = $null
                } | Out-DataTable
            }

            Invoke-SQLiteBulkCopy -DataTable $dataTable -DataSource $file -Table _ -ConflictClause Ignore -Force
            _hideFile $file
        }
    } else {
        if (!$pathExists) { $null = New-Item -Path $path -ItemType Directory }
        if (!$fileExists) { 
            $null = New-Item -Path $file -ItemType File 
            Invoke-SqliteQuery -DataSource $file -Query $query
            _hideFile $file
        }
    }

    return $file
}

function _connectionWarning {
    Write-Warning "You must create a connection to the vault to manage the secrets. Check your connection object and pass the right credential."
}

function _getDbPath {
    return _createDb
}

function _getKeyFile {
    $path = Split-Path -Path (_getDbPath) -Parent
    return (Join-Path -Path $path -ChildPath "private.key")
}

function _getConnectionFile {
    $path = Split-Path -Path (_getKeyFile) -Parent
    return (Join-Path -Path $path -ChildPath "connection.clixml")
}

function _archiveKeyFile {
    $path = Split-Path -Path (_getKeyFile) -Parent
    [string] $keyFile = _getKeyFile
    $file = $keyFile.Replace("private", "private_$(Get-Date -Format ddMMyyyy-HH_mm_ss)")
    $archivePath = Join-Path -Path $path -ChildPath "archive"
    if (!(Test-Path $archivePath)) { $null = New-Item -Path $archivePath -ItemType Directory }
    _unhideFile (_getKeyFile)
    Rename-Item -Path (_getKeyFile) -NewName $file
    Move-Item -Path $file -Destination "$archivePath" -Force
}

function _isKeyFileExists {
    return (Test-Path (_getKeyFile))
}

function _saveKey([string] $key, [switch] $force) {
    $file = _getKeyFile
    $fileExists = _isKeyFileExists

    if ($fileExists -and !$force.IsPresent) { Write-Warning "Key file already exists; Use Force parameter to update the file." }

    if ($fileExists -and $force.IsPresent) {
        _unhideFile $file
        $encryptedKey = [pscredential]::new("key", ($key | ConvertTo-SecureString -AsPlainText -Force))    
        $encryptedKey.Password | Export-Clixml -Path $file -Force
        _hideFile $file
    }
    
    if (!$fileExists) {
        $encryptedKey = [pscredential]::new("key", ($key | ConvertTo-SecureString -AsPlainText -Force))    
        $encryptedKey.Password | Export-Clixml -Path $file -Force
        _hideFile $file
    }
}

function _hideFile([string] $filePath) {
    if ((_getOS) -eq "Windows") {    
        if ((Get-Item $filePath -Force).Attributes -notmatch 'Hidden') { (Get-Item $filePath).Attributes += 'Hidden' }
    }
}

function _unhideFile([string] $filePath) {
    if ((_getOS) -eq "Windows") {
        if ((Get-Item $filePath -Force).Attributes -match 'Hidden') { (Get-Item $filePath -Force).Attributes -= 'Hidden' }
    }
}

function _isNameExists([string] $name) {
    return [bool] (Get-PSSecret -Name $name -WarningAction 'SilentlyContinue')
}

function _getHackedPasswords {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline=$true)]        
        [String[]]$secureStringList
    )
    
    begin {
        #initialize function variables
        $encoding = [System.Text.Encoding]::UTF8
        $result = @()
        $hackedCount = @()
    }
    
    process {
        foreach ($string in $secureStringList) {
            
            $SHA1Hash = New-Object -TypeName "System.Security.Cryptography.SHA1CryptoServiceProvider"
            $Hashcode = ($SHA1Hash.ComputeHash($encoding.GetBytes($string)) | `
                    ForEach-Object { "{0:X2}" -f $_ }) -join ""
            
            $Start, $Tail = $Hashcode.Substring(0, 5), $Hashcode.Substring(5)

            $Url = "https://api.pwnedpasswords.com/range/" + $Start
            $Request = Invoke-RestMethod -Uri $Url -UseBasicParsing -Method Get
            
            $hashedArray = $Request.Split()

            foreach ($item in $hashedArray) {

                if (!([string]::IsNullOrEmpty($item))) {
                    $encodedPassword = $item.Split(":")[0]
                    $count = $item.Split(":")[1]
                    $Hash = [PSCustomObject]@{
                        "HackedPassword" = $encodedPassword.Trim()
                        "Count"          = $count.Trim()
                    }
                    $result += $Hash
                }  
            }

            foreach ($pass in $result) {
                if($pass.HackedPassword -eq $Tail) {
                    $newHash = [PSCustomObject]@{
                        Name = $string
                        Count = $pass.Count
                    }
                    $hackedCount += $newHash
                }
            }

            if ($string -notin $hackedCount.Name) {
                $finalHash = [PSCustomObject]@{
                    Name = $string
                    Count = 0
                }
                $hackedCount += $finalHash
            }
        }
        return $hackedCount
    }
}

function _isHacked([string] $value) {
    $res = (_getHackedPasswords $value -ErrorAction SilentlyContinue).Count
    if ($res -gt 0) {
        Write-Warning "Secret '$value' was hacked $($res) time(s); Consider changing the secret value."
    }
}

function _clearPersonalVault {
    Remove-Item -Path (Split-Path -Path (_getDbPath) -Parent) -Recurse -Force
}

function _clearConnection {
    Remove-Item -Path (_getConnectionFile) -Force
    [System.Environment]::SetEnvironmentVariable("PERSONALVAULT_U", "", [System.EnvironmentVariableTarget]::Process)
    [System.Environment]::SetEnvironmentVariable("PERSONALVAULT_P", "", [System.EnvironmentVariableTarget]::Process)
}

function _isValidConnection ([PersonalVault] $connection) {
    $verified = $false

    if (($null -ne $connection.UserName) -and ($null -ne $connection.Password)) {
        if (Test-Path -Path (_getConnectionFile)) {
            $properties = Import-Clixml -Path (_getConnectionFile)
            $prop = [pscredential]::new($properties.UserName, $properties.Password)
            $propPassword = $prop.GetNetworkCredential().Password
    
            $conn = [pscredential]::new($connection.UserName, $connection.Password)
            $connPassword = $conn.GetNetworkCredential().Password
    
            if (($prop.UserName -eq $conn.UserName) -and ($propPassword -eq $connPassword)) { $verified = $true }
        }
    }


    return $verified
}

function _setEnvironmentVariable ([string] $key, [string] $value) {
    if (!([string]::IsNullOrEmpty($key)) -and !([string]::IsNullOrEmpty($value))) {
        [System.Environment]::SetEnvironmentVariable($key, $value, [System.EnvironmentVariableTarget]::Process)
    }
}

function _getEnvironmentVariable([string] $key) {
    if (!([string]::IsNullOrEmpty($key))) {
        return [System.Environment]::GetEnvironmentVariable($key)
    }
}

function _getConnectionObject {
    $connection = [PersonalVault]::new()
    $userName = _getEnvironmentVariable -key "PERSONALVAULT_U"
    $password = (_getEnvironmentVariable -key "PERSONALVAULT_P")

    if (!([string]::IsNullOrEmpty($userName)) -and !([string]::IsNullOrEmpty($password))) {
        $connection.UserName = $userName
        $connection.Password = $password | ConvertTo-SecureString -ErrorAction SilentlyContinue
        return $connection
    }
}

function _isValidRecoveryWord ([securestring] $recoveryWord) {
    $res = Import-Clixml -Path (_getConnectionFile)
    $key = [pscredential]::new("Key", $res.Key)
    $recKey = [pscredential]::new("Key", $recoveryWord)

    return ($recKey.GetNetworkCredential().Password -eq $key.GetNetworkCredential().Password)
}

function _selectValueFromDB([string] $name, [int] $id) {
    if ($name -and $id) {
        return (Invoke-SqliteQuery -DataSource (_getDbPath) -Query "SELECT Value FROM _ WHERE Name = '$name' AND Id = '$id'")
    }

    if (!$name -and $id) {
        return (Invoke-SqliteQuery -DataSource (_getDbPath) -Query "SELECT Value FROM _ WHERE Id = '$id'")
    }

    if ($name -and !$id) {
        return (Invoke-SqliteQuery -DataSource (_getDbPath) -Query "SELECT Value FROM _ WHERE Name = '$name'")
    }

    return (Invoke-SqliteQuery -DataSource (_getDbPath) -Query "SELECT * FROM _")
}