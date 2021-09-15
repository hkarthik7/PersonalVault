Describe "PersonalVault" {

    BeforeAll {
        Import-Module ".\PersonalVault\PersonalVault.psm1" -Force
    }

    Context "Add-PSSecret" {
        BeforeAll {
            if ([bool] (Get-PSSecret -Name "Test" -WarningAction SilentlyContinue)) {
                Remove-PSSecret -Name "Test" -Force
            }
        }

        It "Should add a secret to personal vault" {
            Add-PSSecret -Name "Test" -Value "Test" -Metadata "Secret value of Test"
            Get-PSSecret -Name "Test" -AsPlainText | Should -BeLikeExactly "Test"
        }

        AfterAll {
            # cleaning up
            Remove-PSSecret -Name "Test" -Force
        }
    }
}