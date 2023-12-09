# Gave up

function Resolve-AOC202307P1 {
    [CmdletBinding()]
    param (
        [string]$FilePath
    )

    $Hands = @()
    $Bids = @()

    foreach($Line in Get-Content $FilePath){
        $Hands += $Line.Split(" ").Get(0)
        $Bids += $Line.Split(" ").Get(1)
    }

    for($i = 0; $i -lt $Hands.Count; $i++){
        Write-Verbose "Hand: $($Hands[$i]); Bid: $($Bids[$i])"
    }

}