# PersonalVault
## about_PersonalVault

# SHORT DESCRIPTION
Personal vault helps to store the secrets locally and manage it in easy and efficient way.

# LONG DESCRIPTION
Personal vault helps to store the secrets in a key value pair and make it easy to manage. It uses **PowerShell**'s inbuild security mechanism to encrypt and decrypt the secret
texts. The secrets are encrypted using an auto-generate 32 bits key and stored in the vault. **PersonalVault** provides the cmdlet to add, get, update and remove the secrets easily. You can use your own key which should be of 32 bits or generate it using the cmdlet **Get-PSKey**.

You can secure all your secrets with individual key and store it in the vault. This way you can store your secrets more securely. Rotate your keys easily and all retrieve it using the **DateModified** parameter in the cmdlet **Get-PSArchivedKey**.

Additionally, you can tab complete the available keys from the vault for easy retrieval of the keys.

**PersonalVault** gives a warning if the secret value that you're trying to store is already exposed (or hacked) in the internet. This gives us an opportunity to review the secret value and change it immediately.

# EXAMPLES

### Example 1
```powershell
PS C:\> Add-PSSecret -Name "MynewSecret" -Value "Thisisanonhackablepassword@2021"
```

Add a secret value to the vault.

### Example 2
```powershell
PS C:\> Add-PSSecret -Name Test -Value 'Test@123'
WARNING: Secret 'Test@123' was hacked 833 time(s); Consider changing the secret value.
```

Get a warning if the secret you are trying to add is exposed.

### Example 3
```powershell
PS C:\> Get-PSSecret
```

Get the secret value from the vault

### Example 4
```powershell
PS C:\> Get-PSKey
```

Get the key used to encrypt the secet value

### Example 5
```powershell
PS C:\> Get-PSKey -Force
PS C:\> Add-PSSecret -Name "MyanothernewSecret" -Value "Thisisanonhackablepassword@2021"
```

Rotate the key and add a new secret

### Example 6
```powershell
PS C:\> Get-PSArchivedKey
```

Get the archived keys. Use it to retrieve the secrets that was encrypted using these keys.

### Example 7
```powershell
PS C:\> Update-PSSecret -Name Test -Value "AnyStrongPassword@2021"
```

Update a secret value. Use tab completion to find the key to update it's corresponding secret.

### Example 8
```powershell
PS C:\> Remove-PSSecret -Name Test -Force
```

Remove a secret with the key

### Example 9
```powershell
PS C:\ Remove-PSPersonalVault -Force
```

Force remove the vault. This is a destructive operation and it removes all the stored secrets.

# NOTE
It is best to save the secrets with individual keys for more security. Since the PowerShell encryption uses Windows DPAPI, the user who stored the keys and secrets
can only view it in plain text.

# SEE ALSO
[Get-PSSecret](https://github.com/hkarthik7/PersonalVault/blob/master/docs/Get-PSSecret.md)

# KEYWORDS
Try the cmdlets.

- [Add-PSSecret](https://github.com/hkarthik7/PersonalVault/blob/master/docs/Add-PSSecret.md)
- [Get-PSKey](https://github.com/hkarthik7/PersonalVault/blob/master/docs/Get-PSKey.md)
- [Get-PSSecret](https://github.com/hkarthik7/PersonalVault/blob/master/docs/Get-PSSecret.md)
- [Update-PSSecret](https://github.com/hkarthik7/PersonalVault/blob/master/docs/Update-PSSecret.md)
