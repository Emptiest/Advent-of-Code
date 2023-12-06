function solvequadraticmin {
    param(
        $time,
        $distance
    )

    $Min = ($time - [Math]::sqrt([Math]::Pow($time,2) - 4 * $distance)) / 2
    $Min
}

function solvequadraticmax {
    param(
        $time,
        $distance
    )

    $Max = ($time + [Math]::sqrt([Math]::Pow($time,2) - 4 * $distance)) / 2
    $Max
}

function Resolve-AOC202306P2 {
    [CmdletBinding()]
    param (
        [string]$FilePath
    )

    $File = Get-Content $FilePath

    $Races = [PSCustomObject]@{
        Time = [int64](($File.Get(0).split(":") | Where-Object {$_} | Where-Object {$_ -notlike "Time"}).Trim() -replace " ")
        Distance = [int64](($File.Get(1).split(":") | Where-Object {$_} | Where-Object {$_ -notlike "Distance"}).Trim() -replace " ")
    }

    $Minimum = solvequadraticmin -time $Races.Time -distance $Races.Distance
    $Maximum = solvequadraticmax -time $Races.Time -distance $Races.Distance
    $output = [Math]::Floor($Maximum) - [Math]::Ceiling($Minimum) + 1

    $output
}