function Resolve-AOC2019Day1Part1 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )

    $Result = 0

    foreach($Line in Get-Content $FilePath){
        $de = [Math]::Floor($Line / 3)
        $Result += $de - 2
    }

    $Result
}