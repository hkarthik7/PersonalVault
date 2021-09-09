Describe "PersonalVault" {

    BeforeAll {
        Import-Module ".\PersonalVault\PersonalVault.psm1" -Force
    }

    Context "Remove-PSSecret" {
        BeforeAll {
            if (!([bool] (Get-PSSecret -Name "Test" -WarningAction SilentlyContinue))) {
                Add-PSSecret -Name "Test" -Value "Test"
            }
        }

        It "Should remove a secret from personal vault" {
            Remove-PSSecret -Name "Test" -Force
            Get-PSSecret -Name "Test" -WarningAction SilentlyContinue | Should -BeNullOrEmpty
        }

        AfterAll {
            # cleaning up
            Remove-PSSecret -Name "Test" -WarningAction SilentlyContinue -Force
        }
    }
}