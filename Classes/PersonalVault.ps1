class PersonalVault {
    [string] $UserName
    [securestring] $Password
    [string] $Name = "PersonalVault"
    hidden [securestring] $Key
    [string] $ConnectionFilePath = (_getConnectionFile)
}