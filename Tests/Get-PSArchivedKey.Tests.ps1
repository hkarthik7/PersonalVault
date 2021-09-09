Describe "PersonalVault" {

    BeforeAll {
        Import-Module ".\PersonalVault\PersonalVault.psm1" -Force
    }

    Context "Get-PSArchivedKey" {
        BeforeAll {
            $result = [PSCustomObject]@{
                DateModified = "09/09/2021 23:11:00"
                Key = "75uhkjrbsfdv8lfnvkjp98yqrigbwrg8"
            }
        }
        It "Should return a the archived keys" {
            Mock Get-PSArchivedKey { return $result }
        }
    }
}