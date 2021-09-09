using namespace System.Collections;
using namespace System.Management.Automation;
using namespace System.Collections.Generic;

class NameCompleter : IArgumentCompleter {
    [IEnumerable[CompletionResult]] CompleteArgument(
        [string] $CommandName,
        [string] $ParameterName,
        [string] $WordToComplete,
        [Language.CommandAst] $CommandAst,
        [IDictionary] $FakeBoundParameters
    ) {
        $results = [List[CompletionResult]]::new()
        $names = Invoke-SqliteQuery -DataSource (_getDbPath) -Query "SELECT * FROM _"

        foreach ($value in $names.Name) {
            if ($value -like "*$WordToComplete*") {
                $results.Add($value)
            }
        }

        return $results
    }
}