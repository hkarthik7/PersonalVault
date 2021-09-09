using namespace System.Text;

function Merge-Files {
   [CmdletBinding()]
   param (
      # This will get all the .ps1 files from the directory
      [Parameter(Mandatory = $true, ParameterSetName = "Functions")]
      [Parameter(Mandatory = $true, ParameterSetName = "Classes")]
      [string[]]
      $InputDirectory,

      # File name has to be passed with the directory name
      [Parameter(Mandatory = $true, ParameterSetName = "Functions")]
      [Parameter(Mandatory = $true, ParameterSetName = "Classes")]
      [string]
      $OutputDirectory,

      [Parameter(Mandatory = $true, ParameterSetName = "Functions")]
      [switch] $Functions,

      [Parameter(Mandatory = $true, ParameterSetName = "Classes")]
      [switch] $Classes
   )
   
   process {
      try {
         if (-not (Test-Path -Path $InputDirectory)) {
            Write-Error `
               -Exception ItemNotFoundException `
               -Message "Can't find Path $InputDirectory" `
               -ErrorId "PathNotFound,Files\Merge-Files" `
               -Category "ObjectNotFound"
         }

         elseif (-not (Test-Path -Path (Split-Path $OutputDirectory -Parent))) {
            Write-Error `
               -Exception ItemNotFoundException `
               -Message "Can't find Path $OutputDirectory" `
               -ErrorId "PathNotFound,Files\Merge-Files" `
               -Category "ObjectNotFound"
         }

         else {
            $Files = Get-ChildItem -Path (Convert-Path $InputDirectory) -Filter "*.ps1" | Select-Object -ExpandProperty FullName

            if ($PSCmdlet.ParameterSetName -eq "Functions") {

               $PSCmdlet.WriteObject("Merging Functions in given path $($OutputDirectory)")
               Merge-Functions -Files $Files | Set-Content -Path $OutputDirectory
            }

            elseif ($PSCmdlet.ParameterSetName -eq "Classes") {
               $PSCmdlet.WriteObject("Merging Classes in given path $($OutputDirectory)")
               Merge-Classes -Files $Files | Set-Content -Path $OutputDirectory
            }
         }
         

      }
      catch {
         throw $_
      }
   }
}

# function to merge classes and functions in seperate files.
# Specify the input files and output file.
function Merge-Functions {
   [CmdletBinding()]
   param (
       [Parameter(Mandatory)]
       [string[]]
       $Files
   )
   
   process {
      [StringBuilder] $Contents = [StringBuilder]::new()

      foreach ($File in $Files) {
         Write-Verbose "Working with: $(Split-Path $File -Leaf)"
         $FileContents = Get-Content -Path $File

         foreach ($Line in $FileContents) {
            $Line = $Line -replace " +$", ""
            if ((![string]::IsNullOrEmpty($Line.Trim())) -and (![string]::IsNullOrWhiteSpace($Line.Trim()))) {
               # .Trim() method removes the indentation in final output so it has to be included for each line in
               # the condition.
               $Contents.AppendLine($Line) > $null
            }
         }
      }

      $PSCmdlet.WriteObject($Contents.ToString())
   }   
}

function Merge-Classes {
   [CmdletBinding()]
   param (
       [Parameter(Mandatory)]
       [string[]]
       $Files
   )
   
   process {
      [StringBuilder] $UsingContents = [StringBuilder]::new()
      [StringBuilder] $Contents = [StringBuilder]::new()
      $UsingStatementCollector = @()

      foreach ($File in $Files) {
         Write-Verbose "Working with: $(Split-Path $File -Leaf)"
         $FileContents = Get-Content -Path $File

         # separate using statements
         $Matches = $FileContents | Select-String "using.+"

         foreach ($Match in $Matches) {
            Write-Verbose "Found: $($Match.Line)"

            if ($null -eq ($UsingStatementCollector | Where-Object { $_ -eq $Match.Line })) {
               $UsingContents.AppendLine($Match.Line) > $null
               $UsingStatementCollector += , $Match.Line
            }
         }
         
         $FileContents = $FileContents -replace "using.+", ""

         foreach ($Line in $FileContents) {
            if ((![string]::IsNullOrEmpty($Line.Trim())) -and (![string]::IsNullOrWhiteSpace($Line.Trim()))) {
               $Line = $Line -replace " +$", ""
               # .Trim() method removes the indentation in final output so it has to be included for each line in
               # the condition.
               $Contents.AppendLine($Line) > $null
            }
         }

      }

      $PSCmdlet.WriteObject("$($UsingContents) $($Contents.ToString())")
   }
}