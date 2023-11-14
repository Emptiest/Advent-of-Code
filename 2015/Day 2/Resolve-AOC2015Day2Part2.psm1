function Get-RibbonLength {
    param (
        [int]$Length,
        [int]$Width,
        [int]$Height
    )

    $Perimeters = (2 * $Length + 2 * $Width),(2 * $Width + 2 * $Height),(2 * $Height + 2 * $Length)
    Write-Verbose "Smallest Perimeter is $(($Perimeters | Measure-Object -Minimum).Minimum)"

    $Volume = $Length * $Width * $Height
    Write-Verbose "Bow will require $Volume feet"
    $Length = $Volume + ($Perimeters | Measure-Object -Minimum).Minimum
    $Length
}

function Resolve-AOC2015Day2Part2 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )

    $RibbonLength = 0

    foreach($line in [System.IO.File]::ReadLines($FilePath)){
        $Dimensions = $line.Split("x")
        $Length = $Dimensions.Get(0)
        $Width = $Dimensions.Get(1)
        $Height = $Dimensions.Get(2)

        $RibbonLength += Get-RibbonLength -Length $Length -Width $Width -Height $Height
    }
    $RibbonLength
}