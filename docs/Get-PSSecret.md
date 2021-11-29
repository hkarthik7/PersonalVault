---
external help file: PersonalVault-help.xml
Module Name: PersonalVault
online version: https://github.com/hkarthik7/PersonalVault/blob/master/docs/Get-PSSecret.md
schema: 2.0.0
---

# Get-PSSecret

## SYNOPSIS
Get the key and secret in a key value pair.

## SYNTAX

```
Get-PSSecret [-Name <String>] [-Id <Int32>] [[-Key] <String>] [-AsPlainText] [<CommonParameters>]
```

## DESCRIPTION
Get the key and encrypted secret in a key value pair.
Tab complete the Name and retrieve the secret associated with it.
To get the secret as plain text enable the switch AsPlaintext.

## EXAMPLES

### Example 1
```powershell
# You should register first to work with the vault
# You should remember your recovery word to recover your registered username and password
PS C:\> $recoveryWord = Read-Host -AsSecureString
PS C:\> Register-PSPersonalVault -Credential (Get-Credential) -RecoveryWord $recoveryWord

# connect to the vault with the credential
PS C:\> $connection = Connect-PSPersonalVault -Credential (Get-Credential)

PS C:\> Get-PSSecret
Id        : 1
Name      : Test
Value     : 76492d1116743f0423413b16050a5345MgB8AEoAVgBpADcAWQBtAHkATAB2ADkATwBKAGUAeAB4AEsAdwBGAEkAZgBLAFEAP...
Metadata  : Test
AddedOn   : 11/29/2021 2:55:31 PM
UpdatedOn :
```

Get the available secrets from the store.

### Example 2
```powershell
PS C:\> Get-PSSecret -Name Test -AsPlainText
Test@123
```

Get the secret associated with the key.

### Example 3
```powershell
PS C:\> Get-PSSecret -Name Test -Key Key1 -AsPlainText
Test@123
```

Get the secret associated with the key by passing the key that was used to encrypt it.

## PARAMETERS

### -AsPlainText
If true gets the secret value as plain text

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Key
Pass the key to decrypt.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Name
Provide the name to get it's associated secret value.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Id
{{ Fill Id Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
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

[Get-PSSecret](https://github.com/hkarthik7/PersonalVault/blob/master/docs/Get-PSSecret.md)

