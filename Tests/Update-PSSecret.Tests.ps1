Describe "PersonalVault" {

    BeforeAll {
        Import-Module ".\PersonalVault\PersonalVault.psm1" -Force
    }

    Context "Update-PSSecret" {
        BeforeAll {
            $path = Join-Path -Path $Home -ChildPath ".cos_$([System.Environment]::UserName.ToLower())"

            if (Test-Path $path) {
                Rename-Item -Path $path -NewName ".cos_$([System.Environment]::UserName.ToLower())_backup" -Force
            }

            $file = Get-ChildItem -Path $PWD.Path -Filter "_settings.json" -Recurse
            $settings = Get-Content -Path $file.FullName -Raw | ConvertFrom-Json
            $cred = [pscredential]::new($settings.userName, ($settings.password | ConvertTo-SecureString -AsPlainText -Force))
            Register-PSPersonalVault -Credential $cred -RecoveryWord ($settings.recoveryWord  | ConvertTo-SecureString -AsPlainText -Force)
            $null = Connect-PSPersonalVault -Credential ([pscredential]::new($cred.UserName, $cred.Password))

            if (!([bool] (Get-PSSecret -Name "Test" -WarningAction SilentlyContinue))) {
                Add-PSSecret -Name "Test" -Value "Test" -Metadata "Secret value of Test"
            }
        }

        It "Should update a secret to personal vault" {
            Update-PSSecret -Name "Test" -Value "Test@123" -Id 1 -Force
            Get-PSSecret -Name "Test" -AsPlainText | Should -BeLikeExactly "Test@123"
        }

        AfterAll {
            # cleaning up
            Remove-PSSecret -Name "Test" -Force
            Remove-PSPersonalVault -Force
            $path = Join-Path -Path $Home -ChildPath ".cos_$([System.Environment]::UserName)_backup"
            if (Test-Path $path) {
                Rename-Item -Path $path -NewName ".cos_$([System.Environment]::UserName.ToLower())" -Force
            }
        }
    }
}