---
external help file: PersonalVault-help.xml
Module Name: PersonalVault
online version:
schema: 2.0.0
---

# Get-PSArchivedKey

## SYNOPSIS
Get the archived keys.

## SYNTAX

```
Get-PSArchivedKey [[-DateModified] <DateTime>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet retrives the archived keys which are separated by date modified timestamp. Optionally you can get the archived keys by providing the modified date.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-PSArchivedKeys
DateModified        Key
------------        ---
04/06/2020 10:34:44 Key1
04/06/2020 10:37:06 Key2
10/07/2020 10:39:27 Key3
10/09/2021 10:39:29 Key4
```

Lists all the archived keys.

### Example 2
```powershell
PS C:\> Get-PSArchivedKeys -DateModified (Get-Date 04/06/2020)
DateModified        Key
------------        ---
04/06/2020 10:34:44 Key1
04/06/2020 10:37:06 Key2
```

Lists all the archived keys from the specified date.

## PARAMETERS

### -DateModified
Specify the date that the key was modified.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
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

### System.Object[]

## NOTES

## RELATED LINKS

[Get-PSArchivedKey](https://github.com/hkarthik7/PersonalVault/blob/master/docs/Get-PSArchivedKey.md)