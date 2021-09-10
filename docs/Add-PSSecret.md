---
external help file: PersonalVault-help.xml
Module Name: PersonalVault
online version:
schema: 2.0.0
---

# Add-PSSecret

## SYNOPSIS
Adds a secret to the personal vault store.

## SYNTAX

```
Add-PSSecret [-Name] <String> [-Value] <String> [-Key <String>] [<CommonParameters>]
```

## DESCRIPTION
This cmdlet adds the given name and secret value to the personal vault. It auto generates a key of 32 bits and encrypts the secret value and store it in the vault.

## EXAMPLES

### Example 1
```powershell
PS C:\> Add-PSSecret -Name "MynewSecret" -Value "Thisisanonhackablepassword@2021"
```

Add a secret value to the vault.

### Example 2
```powershell
PS C:\> Add-PSSecret -Name "Test" -Value "Test@123"
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
Name to store against the secret value. For instance an user name. 

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS
[Add-PSSecret](https://github.com/hkarthik7/PersonalVault/blob/master/docs/Add-PSSecret.md)