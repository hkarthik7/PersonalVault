---
external help file: PersonalVault-help.xml
Module Name: PersonalVault
online version: https://github.com/hkarthik7/PersonalVault/blob/master/docs/Remove-PSPersonalVaultConnection.md
schema: 2.0.0
---

# Remove-PSPersonalVaultConnection

## SYNOPSIS
Removes the existing connection and stored connection to the vault.

## SYNTAX

```
Remove-PSPersonalVaultConnection [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes the existing connection and stored connection to the vault.

## EXAMPLES

### Example 1
```powershell
# You should register first to work with the vault
# You should remember your recovery word to recover your registered username and password
PS C:\> $recoveryWord = Read-Host -AsSecureString
PS C:\> Register-PSPersonalVault -Credential (Get-Credential) -RecoveryWord $recoveryWord

# connect to the vault with the credential
PS C:\> $connection = Connect-PSPersonalVault -Credential (Get-Credential)

PS C:\> Remove-PSPersonalVaultConnection -Force
```

You must create a connection to the vault before removing the connection. If you remove the connection you have to register before connecting.

## PARAMETERS

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force
If true removes the store credential used for connecting the vault.

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

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
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

[Remove-PSPersonalVaultConnection](https://github.com/hkarthik7/PersonalVault/blob/master/docs/Remove-PSPersonalVaultConnection.md)