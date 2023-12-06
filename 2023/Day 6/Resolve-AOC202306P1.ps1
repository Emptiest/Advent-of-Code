function Resolve-AOC202306P1 {
    [CmdletBinding()]
    param (
        [string]$FilePath
    )
    $Multipliers = @()

    $File = Get-Content $FilePath

    $Races = [PSCustomObject]@{
        Time = $File.Get(0).split(":").Split(" ") | Where-Object {$_} | Where-Object {$_ -notlike "Time"}
        Distance = $File.Get(1).split(":").Split(" ") | Where-Object {$_} | Where-Object {$_ -notlike "Distance"}
    }

    for($i = 0; $i -le $Races.Time.Count - 1; $i++){
        $VictoryOutcomes = 0
        $TotalTime = $Races.Time.Get($i)
        Write-Verbose "Need to beat distance of $($Races.Distance.Get($i))"
        for($t = 0; $t -le $TotalTime; $t++){
            $TimeHeld = $t
            $TimeMoving = $TotalTime - $t
            $Distance = $TimeHeld * $TimeMoving
            Write-Verbose "Travelled $Distance in race $i"
            if($Distance -gt $Races.Distance.Get($i)){
                $VictoryOutcomes++
            }
        }
        #Write-Verbose "Found $VictoryOutcomes ways to win race $i"
        $Multipliers += $VictoryOutcomes
    }

    # Some jank so we don't start with multiplying against 0
    $output = $Multipliers.Get(0)

    foreach($Number in $Multipliers){
        Write-Verbose "Multiplying $output with $Number"
        $output = $output * $Number
    }
    # jank cleanup
    $output = $output / $Multipliers.Get(0)

    $output
}