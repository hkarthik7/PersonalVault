---
external help file: PersonalVault-help.xml
Module Name: PersonalVault
online version:
schema: 2.0.0
---

# Remove-PSPersonalVault

## SYNOPSIS
Removes the personal vault.

## SYNTAX

```
Remove-PSPersonalVault [-Force] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Permanently removes the personal vault. This is a destructive operation and if used all the stored secrets will be lost.

## EXAMPLES

### Example 1
```powershell
PS C:\> Remove-PSPersonalVault -Force
```

Permanently removes the personal vault.

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
Permanently removes the vault if true.

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

## RELATED LINKS

[Remove-PSPersonalVault](https://github.com/hkarthik7/PersonalVault/blob/master/docs/Remove-PSPersonalVault.md)