# 2.0.0

**Breaking Changes**

- Added tables **AddedOn** and **UpdatedOn** to track when a secret was added and updated.
- Changed primary key from **Name** to **Id** parameter to add multiple values to same name.
- Added functionality to automatically migrate from older schema to new schema.

# 1.1.2

**Breaking Changes**

- *Register-PSPersonalVault* register with username and password before accessing the vault
- *Connect-PSPersonalVault* connect to the vault using registered credential to access the vault
- *Import-PSPersonalVault* recover the username and password using the recovery word if the stored credential are forgotten
- *Remove-PSPersonalVaultConnection* remove the stored connection
- Introduced cmdlets to register and connect to the vault using username and password.
- Recover the credential using recovery word
- Modified all cmdlets to check the connection before managing the vault

# 0.1.2

- Fixed **Get-PSKey** key rotation.
- Added Metadata section to update the comments. This helps to know what we're storing.

# 0.1.1

- Bug fix for username and user home drive environment variables.
- Modified the functionality to hide files only in Windows.
- Added functionality to clear history of secret value from the command run history.
- Bug fix for secret value hacked counts check.

# 0.1.0

- Module initial release.