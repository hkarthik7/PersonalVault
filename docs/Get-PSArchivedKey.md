---
external help file: PersonalVault-help.xml
Module Name: PersonalVault
online version: https://github.com/hkarthik7/PersonalVault/blob/master/docs/Get-PSArchivedKey.md
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
This cmdlet retrives the archived keys which are separated by date modified timestamp.
Optionally you can get the archived keys by providing the modified date.

## EXAMPLES

### Example 1
```powershell
# You should register first to work with the vault
# You should remember your recovery word to recover your registered username and password
PS C:\> $recoveryWord = Read-Host -AsSecureString
PS C:\> Register-PSPersonalVault -Credential (Get-Credential) -RecoveryWord $recoveryWord

# connect to the vault with the credential
PS C:\> $connection = Connect-PSPersonalVault -Credential (Get-Credential)

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
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object[]
## NOTES
The secret values that you are entering as plain text in the session will not stick to in the history. **PersonalVault** will automatically remove the module related cmdlets from the history. Re-open the console to make sure that all the secrets are removed from the history.

## RELATED LINKS

[Get-PSArchivedKey](https://github.com/hkarthik7/PersonalVault/blob/master/docs/Get-PSArchivedKey.md)

