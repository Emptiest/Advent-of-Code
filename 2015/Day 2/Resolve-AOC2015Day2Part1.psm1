function Get-SurfaceArea {
    param (
        [int]$Length,
        [int]$Width,
        [int]$Height
    )

    $Sides = ($Length * $Width),($Width * $Height),($Height * $Length)
    Write-Verbose "Smallest Side is $(($Sides | Measure-Object -Minimum).Minimum)"

    $SurfaceArea = ((2 * $Sides.Get(0)) + (2 * $Sides.Get(1)) + (2 * $Sides.Get(2))) + ($Sides | Measure-Object -Minimum).Minimum
    $SurfaceArea
}

function Resolve-AOC2015Day2Part1 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )

    $WrappingPaper = 0

    foreach($line in [System.IO.File]::ReadLines($FilePath)){
        $Dimensions = $line.Split("x")
        $Length = $Dimensions.Get(0)
        $Width = $Dimensions.Get(1)
        $Height = $Dimensions.Get(2)

        $WrappingPaper += Get-SurfaceArea -Length $Length -Width $Width -Height $Height
    }
    $WrappingPaper
}