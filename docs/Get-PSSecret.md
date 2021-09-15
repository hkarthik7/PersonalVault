---
external help file: PersonalVault-help.xml
Module Name: PersonalVault
online version:
schema: 2.0.0
---

# Get-PSSecret

## SYNOPSIS
Get the key and secret in a key value pair.

## SYNTAX

```
Get-PSSecret [-Name <String>] [[-Key] <String>] [-AsPlainText] [<CommonParameters>]
```

## DESCRIPTION
Get the key and encrypted secret in a key value pair. Tab complete the *Name* and retrieve the secret associated with it. To get the secret as plain text enable the switch AsPlaintext.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-PSSecret
Name        Value
----        -----
Test        76492d1116743f0423413b16050a5345MgB8AHQAMQBCAE0AWQBHAG0AYgAzAGQAdwBMAEwAaAB1...
MynewSecret 76492d1116743f0423413b16050a5345MgB8AGIAVQBrAG4AUgBYAHIAQQBtAFgANQBIAEcAMwBu...
```

Get the available secrets from the store.

### Example 2
```powershell
PS C:\> Get-PSSecret -Name Test -AsPlainText
Test@123
```

Get the secret associated with the key.

### Example 2
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
Default value: None
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[Get-PSSecret](https://github.com/hkarthik7/PersonalVault/blob/master/docs/Get-PSSecret.md)