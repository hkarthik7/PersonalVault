Describe "PersonalVault" {

    BeforeAll {
        Import-Module ".\PersonalVault\PersonalVault.psm1" -Force
    }

    Context "Get-PSKey" {
        It "Should get the key from key file" {
            # key shouldn't be changed
            Get-PSKey | Should -BeOfType [string]
        }
    }
}