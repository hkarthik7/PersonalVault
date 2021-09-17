---
external help file: PersonalVault-help.xml
Module Name: PersonalVault
online version: https://github.com/hkarthik7/PersonalVault/blob/master/docs/Connect-PSPersonalVault.md
schema: 2.0.0
---

# Connect-PSPersonalVault

## SYNOPSIS
Creates a connection to the vault.

## SYNTAX

```
Connect-PSPersonalVault [-Credential] <PSCredential> [<CommonParameters>]
```

## DESCRIPTION
Creates a connection to the vault. It returns the connection object after creating a connection. It won't verify if your credential are correct, you will only know when you run any cmdlet.

## EXAMPLES

### Example 1
```powershell
PS C:\> Connect-PSPersonalVault -Credential (Get-Credential)
```

Returns a connection object.

## PARAMETERS

### -Credential
Pass the registered credential to connect to the vault successfully.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Management.Automation.PSCredential

## OUTPUTS

### System.Object
## NOTES
The secret values that you are entering as plain text in the session will not stick to in the history. **PersonalVault** will automatically remove the module related cmdlets from the history. Re-open the console to make sure that all the secrets are removed from the history.

## RELATED LINKS

[Connect-PSPersonalVault](https://github.com/hkarthik7/PersonalVault/blob/master/docs/Connect-PSPersonalVault.md)