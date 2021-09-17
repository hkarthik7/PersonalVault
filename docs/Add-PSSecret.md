---
external help file: PersonalVault-help.xml
Module Name: PersonalVault
online version: https://github.com/hkarthik7/PersonalVault/blob/master/docs/Add-PSSecret.md
schema: 2.0.0
---

# Add-PSSecret

## SYNOPSIS
Adds a secret to the personal vault store.

## SYNTAX

```
Add-PSSecret [-Name] <String> [-Value] <String> -Metadata <String> [-Key <String>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet adds the given name and secret value to the personal vault.
It auto generates a key of 32 bits and encrypts the secret value and store it in the vault. You can also generate a new key or bring your own key and add the kv pair to the store.

## EXAMPLES

### Example 1
```powershell
# You should register first to work with the vault
# You should remember your recovery word to recover your registered username and password
PS C:\> $recoveryWord = Read-Host -AsSecureString
PS C:\> Register-PSPersonalVault -Credential (Get-Credential) -RecoveryWord $recoveryWord

# connect to the vault with the credential
PS C:\> $connection = Connect-PSPersonalVault -Credential (Get-Credential)

# add secrets to the vault
PS C:\> Add-PSSecret -Name "GMail_username" -Value "Thisisanonhackablepassword@2021" -Metadata "My personal gmail account."
```

Add a secret value to the vault.

### Example 2
```powershell
PS C:\> Add-PSSecret -Name Test -Value 'Test@123' -Metadata "Adding a test value"
WARNING: Secret 'Test@123' was hacked 833 time(s); Consider changing the secret value.
```

Get a warning if the secret value that you are trying to add is exposed.

## PARAMETERS

### -Key
32 bits key to encrypt the secret value

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Name to store against the secret value.
For instance an user name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Value
This denotes the secret value to be stored.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Metadata
Provide the details of what you are storing

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object

## NOTES

The secret values that you are entering as plain text in the session will not stick to in the history. **PersonalVault** will automatically remove the module related cmdlets from the history. Re-open the console to make sure that all the secrets are removed from the history.

## RELATED LINKS

[Add-PSSecret](https://github.com/hkarthik7/PersonalVault/blob/master/docs/Add-PSSecret.md)

