# PERSONAL VAULT

Personal Vault is a **PowerShell** module which helps to save and manage the secrets in key value pair locally on ease and efficient way. You can use it as a personal vault to store your credential that you use on daily basis. It is easy to add, retrieve, update and remove the secrets. Tab complete the **Name** and encrypt the secrets using auto generated keys.

**PersonalVault** identifies if your secret value is hacked or not when you add it to the store and warns immediately to change the value.

You can view the usage of module in the [blog post](https://hkarthik7.github.io/powershell/2021/10/08/PersonalVault.html).

## Getting Started

Install the module from the [PowerShellGallery](https://www.powershellgallery.com/packages/PersonalVault/2.0.0)

```powershell
# For PowerShell version 5 and above run.
PS C:\> Install-Module PersonalVault -Force
PS C:\> Import-Module PersonalVault -Force
```

## Examples

### Example 1

```powershell
# You should register first to work with the vault
# You should remember your recovery word to recover your registered username and password
PS C:\> $recoveryWord = Read-Host -AsSecureString
PS C:\> Register-PSPersonalVault -Credential (Get-Credential) -RecoveryWord $recoveryWord

# connect to the vault with the credential
PS C:\> $connection = Connect-PSPersonalVault -Credential (Get-Credential)

# Add a new secret value to the store
PS C:\> Add-PSSecret -Name "GMail_username" -Value "Thisisanonhackablepassword@2021" -Metadata "My personal gmail account."
```

### Example 2

```powershell
# Read the secret value from the store
PS C:\> Get-PSSecret -Name MyNewSecret
76492d1116743f0423413b16050a5345MgB8AEcAbwBqADgAO....

# list all the available secret values from the vault
PS C:\> Get-PSSecret
Id        : 1
Name      : Test
Value     : 76492d1116743f0423413b16050a5345MgB8AGQALwBoAE0AegBkAHEARwBDADEAOQByADcAdgB4AEEALwBZAE4AawA4AHcAPQA9AH...
Metadata  : Test
AddedOn   : 11/29/2021 2:55:31 PM
UpdatedOn : 11/29/2021 3:12:58 PM

Id        : 2
Name      : Test
Value     : 76492d1116743f0423413b16050a5345MgB8AGEAaQBqAGIARgBqAEsANQA5AEsAVAA4AEkAaQBjAG8AMgA0ADIANAAwAFEAPQA9AHw...
Metadata  : Test
AddedOn   : 11/29/2021 3:09:38 PM
UpdatedOn :

Id        : 3
Name      : Test
Value     : 76492d1116743f0423413b16050a5345MgB8AGMAZABKAGIATgB2AGMAVABkAEEAawBUAGUAMQBPAGcAYgA4AHYAbQBQAEEAPQA9AHwA...
Metadata  : Test
AddedOn   : 11/29/2021 3:12:31 PM
UpdatedOn :
```

### Example 3

```powershell
# Update an existing secret; Tab complete the Name parameter to easily find the Name to update it's corresponding value.
PS C:\> Update-PSSecret -Name MyNewSecret -Id 1 -Value Thisisanewsecretpassword -Force
```

### Example 4

```powershell
# Remove the secret value from the vault.
PS C:\> Remove-PSSecret -Name MyNewSecret -Force
```

### Example 5

```powershell
# Get the key that is used to encrypt the password.
PS C:\> Get-PSKey
8fhbrfbv8y3rhbqjf98y4ribfkyd5*^g
```

### Example 6

```powershell
# Rotate the key every time when you add a secret value. This way each of your secret value will be encrypted with a new key.
PS C:\> Get-PSKey -Force
948ryqibcklajdbalkjbalyq8fqo-(D
```

### Example 7

```powershell
# Get all the keys that was used to encrypt your secret value. You can only decrypt the value using the same key.
PS C:\> Get-PSArchivedKey
DateModified        Key
------------        ---
04/06/2021 10:34:44 Key1
04/06/2021 10:37:06 Key2
10/07/2021 10:39:27 Key3
10/09/2021 10:39:29 Key4
```

## Release Notes

- [ChangeLog](https://github.com/hkarthik7/PersonalVault/blob/master/CHANGELOG.md)

## Dependencies

- [PSSQlite](https://www.powershellgallery.com/packages/PSSQLite/1.1.0)

## Build Locally

To build the module locally run .\psake.ps1. This installs the dependencies and runs unit tests.

## License

[License](https://github.com/hkarthik7/PersonalVault/blob/master/License)

## Contributions

Contributions are welcome.
