Describe "PersonalVault" {

    BeforeAll {
        Import-Module ".\PersonalVault\PersonalVault.psm1" -Force
    }

    Context "Update-PSSecret" {
        BeforeAll {
            if (!([bool] (Get-PSSecret -Name "Test" -WarningAction SilentlyContinue))) {
                Add-PSSecret -Name "Test" -Value "Test" -Metadata "Secret value of Test"
            }
        }

        It "Should update a secret to personal vault" {            
            Update-PSSecret -Name "Test" -Value "Test@123" -Force
            Get-PSSecret -Name "Test" -AsPlainText | Should -BeLikeExactly "Test@123"
        }

        AfterAll {
            # cleaning up
            Remove-PSSecret -Name "Test" -Force
        }
    }
}