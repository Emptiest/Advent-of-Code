function Switch-Lights {
    [CmdletBinding()]
    param (
        [ref]$LightsArray,
        [int]$x1,
        [int]$y1,
        [int]$x2,
        [int]$y2
    )

    for ($i = $x1; $i -le $x2; $i++){
        for ($j = $y1; $j -le $y2; $j++){
            $LightsArray.Value[$i,$j] = $LightsArray.Value[$i,$j] + 2
        }
    }
}

function TurnOnOff {
    [CmdletBinding()]
    param (
        [ref]$LightsArray,
        [int]$x1,
        [int]$y1,
        [int]$x2,
        [int]$y2,
        [bool]$bool
    )

    for ($i = $x1; $i -le $x2; $i++){
        for ($j = $y1; $j -le $y2; $j++){
            if($bool){
                $LightsArray.Value[$i,$j]++
            }else{
                if($LightsArray.Value[$i,$j] -gt 0){
                    $LightsArray.Value[$i,$j]--
                }
            }
            #Write-Verbose "Current Coord is ($i,$j)"
        }
    }
}

function Resolve-AOC2015Day6Part2 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )
    
    $LightsArray = New-Object "int[,]" 1000,1000

    foreach($Line in Get-Content $FilePath){
        Write-Verbose "Current line is:"
        Write-Verbose $Line

        $x1 = $Line.Split(",").Get(0) -replace "[^0-9]" , ''
        $y1 = $Line.Split(",").Get(1).Split("through").Get(0) -replace "[^0-9]" , ''
        $x2 = $Line.Split(",").Get(1).Split("through").Get(1) -replace "[^0-9]" , ''
        $y2 = $Line.Split(",").Get(2) -replace "[^0-9]" , ''

        switch($Line)
        {
            {$_ -like "turn on*"}    {Write-Verbose "Turning things on!"; TurnOnOff -LightsArray ([ref]$LightsArray) -x1 $x1 -y1 $y1 -x2 $x2 -y2 $y2 -bool $true}
            {$_ -like "turn off*"}   {Write-Verbose "Turning things off!"; TurnOnOff -LightsArray ([ref]$LightsArray) -x1 $x1 -y1 $y1 -x2 $x2 -y2 $y2 -bool $false}
            {$_ -like "toggle*"}     {Write-Verbose "Toggling things!"; Switch-Lights -LightsArray ([ref]$LightsArray) -x1 $x1 -y1 $y1 -x2 $x2 -y2 $y2}
            Default {Write-Verbose "Switch statement didn't work."}
        }
    }
    $LightsArray | Measure-Object -Sum | Select-Object Sum
}