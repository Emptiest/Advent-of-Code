function StoreInput {
    param(
        [string]$FilePath
    )

    $Lines = @()

    foreach($Line in Get-Content $FilePath){
        $Lines += $Line
    }

    $Lines
}

function Resolve-AOC202403P2 {
    [CmdletBinding()]
    param (
        [string]$FilePath
    )

    $RawInput = StoreInput -FilePath $FilePath

    $Regex = "mul\((\d+,\d+)\)"

    $SumOutput = 0

    foreach($Line in $RawInput){
        $Muls = (Select-String -InputObject $Line -Pattern $Regex -AllMatches | ForEach-Object {$_.Matches}).Value
        foreach($Mul in $Muls){
            [int]$Num1 = ($Mul -split ",")[0] -replace "mul\("
            [int]$Num2 = ($Mul -split ",")[1] -replace "\)"
            $SumOutput += $Num1 * $Num2
        }
    }

    $SumOutput
}