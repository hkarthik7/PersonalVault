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

function _decrypt([string] $encryptedText, [string] $key) {
    try {
        $cred = [pscredential]::new("x", ($encryptedText | ConvertTo-SecureString -Key (_getBytes $key) -ErrorAction SilentlyContinue))
        return $cred.GetNetworkCredential().Password   
    }
    catch {
        Write-Warning "Cannot get the value as plain text; Use the right key to get the secret value as plain text."
    }
}

function _createDb {
    $path = "$env:USERPROFILE\.cos_$($env:USERNAME.ToLower())"
    $pathExists = Test-Path $path
    $file = "$path\_.db"
    $query = "CREATE TABLE _ (Name NVARCHAR PRIMARY KEY, Value TEXT)"
    $fileExists = Test-Path $file

    if (!$pathExists) { $null = New-Item -Path $path -ItemType Directory }
    if (!$fileExists) { 
        $null = New-Item -Path $file -ItemType File 
        Invoke-SqliteQuery -DataSource $file -Query $query
        _hideFile $file
    }

    return $file
}

function _getDbPath {
    return _createDb
}

function _getKeyFile {
    $path = Split-Path -Path (_getDbPath) -Parent
    return "$path\private.key"
}

function _archiveKeyFile {
    $path = (Split-Path -Path (_getKeyFile) -Parent)
    $file = (_getKeyFile).Replace("private", "private_$(Get-Date -Format ddMMyyyy-HH_mm_ss)")
    if (!(Test-Path "$path\archive")) { $null = New-Item -Path "$path\archive" -ItemType Directory }
    _unhideFile (_getKeyFile)
    Rename-Item -Path (_getKeyFile) -NewName $file
    Move-Item -Path $file -Destination "$path\archive\" -Force
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
    if ((Get-Item $filePath -Force).Attributes -notmatch 'Hidden') { (Get-Item $filePath).Attributes += 'Hidden' }
}

function _unhideFile([string] $filePath) {
    if ((Get-Item $filePath -Force).Attributes -match 'Hidden') { (Get-Item $filePath -Force).Attributes -= 'Hidden' }
}

function _isNameExists([string] $name) {
    return [bool] (Get-PSSecret -Name $name -WarningAction 'SilentlyContinue')
}