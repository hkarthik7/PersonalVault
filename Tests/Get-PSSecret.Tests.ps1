Describe "PersonalVault" {

    BeforeAll {
        Import-Module ".\PersonalVault\PersonalVault.psm1" -Force
    }

    Context "Get-PSSecret" {
        BeforeAll {
            if (!([bool] (Get-PSSecret -Name "Test" -WarningAction SilentlyContinue))) {
                Add-PSSecret -Name "Test" -Value "Test" -Metadata "Secret value of Test"
            }
        }

        It "Should get a secret from personal vault" {
            Get-PSSecret -Name "Test" -AsPlainText | Should -BeLikeExactly "Test"
        }

        AfterAll {
            # cleaning up
            Remove-PSSecret -Name "Test" -Force
        }
    }
}