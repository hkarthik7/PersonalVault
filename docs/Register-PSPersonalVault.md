---
external help file: PersonalVault-help.xml
Module Name: PersonalVault
online version: https://github.com/hkarthik7/PersonalVault/blob/master/docs/Register-PSPersonalVault.md
schema: 2.0.0
---

# Register-PSPersonalVault

## SYNOPSIS
Registers credential to access the vault.

## SYNTAX

```
Register-PSPersonalVault [-Credential] <PSCredential> [-RecoveryWord] <SecureString> [-Force]
 [<CommonParameters>]
```

## DESCRIPTION
Registers credential to access the vault.

## EXAMPLES

### Example 1
```powershell
# You should register first to work with the vault
# You should remember your recovery word to recover your registered username and password
PS C:\> $recoveryWord = Read-Host -AsSecureString
PS C:\> Register-PSPersonalVault -Credential (Get-Credential) -RecoveryWord $recoveryWord
```

Registers the credential to access the vault.

## PARAMETERS

### -Credential
Pass the user name and password and register to access the vault.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Force
If true overwrites the existing stored credential

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RecoveryWord
Recovery word to recover the username and password incase if you forget.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSCredential

## OUTPUTS

### System.Object
## NOTES
The secret values that you are entering as plain text in the session will not stick to in the history. **PersonalVault** will automatically remove the module related cmdlets from the history. Re-open the console to make sure that all the secrets are removed from the history.

## RELATED LINKS

[Register-PSPersonalVault](https://github.com/hkarthik7/PersonalVault/blob/master/docs/Register-PSPersonalVault.md)