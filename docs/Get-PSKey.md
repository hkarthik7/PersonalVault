---
external help file: PersonalVault-help.xml
Module Name: PersonalVault
online version:
schema: 2.0.0
---

# Get-PSKey

## SYNOPSIS
Gets the key if it exists or generates a new key.

## SYNTAX

```
Get-PSKey [-Force] [<CommonParameters>]
```

## DESCRIPTION
Gets the key if it exists or generates a new key. You can use the *Force* parameter to rotate the keys and secure your secret with different keys.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-PSKey
Key1
```

Gets the existing key.

### Example 2
```powershell
PS C:\> Get-PSKey -Force
Key2
```

Rotates the key.

## PARAMETERS

### -Force
If true rotates the key.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.String

## NOTES

## RELATED LINKS

[Get-PSKey](https://github.com/hkarthik7/PersonalVault/blob/master/docs/Get-PSKey.md)