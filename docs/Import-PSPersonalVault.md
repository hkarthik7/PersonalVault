---
external help file: PersonalVault-help.xml
Module Name: PersonalVault
online version: https://github.com/hkarthik7/PersonalVault/blob/master/docs/Get-PSSecret.md
schema: 2.0.0
---

# Import-PSPersonalVault

## SYNOPSIS
Recovers the registered username and password.

## SYNTAX

```
Import-PSPersonalVault [-RecoveryWord] <SecureString> [<CommonParameters>]
```

## DESCRIPTION
Recovers the resgistered username and password. You should pass the recovery word to successfully recover the username and password.

## EXAMPLES

### Example 1
```powershell
PS C:\> $recoveryWord = Read-Host -AsSecureString
PS C:\> Import-PSPersonalVault $recoveryWord
```

Returns username and password that was registered to access the vault.

## PARAMETERS

### -RecoveryWord
Recovery word to retrieve the registered credential.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object
## NOTES
The secret values that you are entering as plain text in the session will not stick to in the history. **PersonalVault** will automatically remove the module related cmdlets from the history. Re-open the console to make sure that all the secrets are removed from the history.

## RELATED LINKS

[Import-PSPersonalVault](https://github.com/hkarthik7/PersonalVault/blob/master/docs/Import-PSPersonalVault.md)