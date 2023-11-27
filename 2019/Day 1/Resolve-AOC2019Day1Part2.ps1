function Measure-Fuel {
    param(
        [int]$Mass
    )
    $Result = 0

    $de = [Math]::Floor($Mass / 3)
    $Fuel = $de - 2

    if($Fuel -ge 0){
        Write-Verbose "Calculated Fuel was $Fuel"
        $Result += $Fuel
        return $Result + (Measure-Fuel -Mass $Fuel)
    }else{
        0
    }
}

function Resolve-AOC2019Day1Part2 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )

    $Result = 0

    foreach($Line in Get-Content $FilePath){
        $Result += Measure-Fuel -Mass $Line
        #Write-Verbose "Running total is $Result"
    }

    $Result
}