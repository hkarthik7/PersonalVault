# PERSONAL VAULT

Personal Vault is a **PowerShell** module which helps to save and manage the secrets in key value pair locally on ease and efficient way. You can use it as a personal vault to store your credential that you use on daily basis. It is easy to add, retrieve, update and remove the secrets. Tab complete the **Name** and encypt the secrets using auto generated keys. 

**PersonalVault** identifies if your secret value is hacked or not when you add it to the store and warns immediately to change the value.

## Getting Started

Install the module from the [PowerShellGallery](https://www.powershellgallery.com/packages/PersonalVault/0.1.0)

## Examples
### Example 1
```powershell
# Add a new secret value to the store
PS C:\> Add-PSSecret -Name MyNewSecret -Value "MyNewSecretValue@2021"
```

### Example 2
```powershell
# Read the secret value from the store
PS C:\> Get-PSSecret -Name MyNewSecret
```

### Example 3
```powershell
# Inspect the module to list the cmdlets and each cmdlet has it's associate help section.
PS C:\> Get-Command -Module PersonalVault
```

## Release Notes

- [ChangeLog](https://github.com/hkarthik7/PersonalVault/blob/master/CHANGELOG.md)

## Dependencies

- PSSQlite

## Build Locally

To build the module locally run .\psake.ps1. This installs the dependencies and runs unit tests.

## License

[License](https://github.com/hkarthik7/PersonalVault/blob/master/License)

## Contributions

Contributions are welcome.