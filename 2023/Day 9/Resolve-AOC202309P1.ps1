function PredictHistory {
    param(
        $History
    )

    [int]$ThisHistory = $History.ToCharArray()

    $Differences = @()

    if($ThisHistory -match "[^0 ]"){        # If The current History is not zeroed out...
        for($i = 0; $i -lt $ThisHistory.Count; $i++){
            $Differences += $ThisHistory[$i+1] - $ThisHistory[$i]
        }
    }else{
        $Prediction = 0
    }
    
    

    $Prediction
}

function Resolve-AOC202309P1 {
    [CmdletBinding()]
    param (
        [string]$FilePath
    )

    $History = @()
    $Sum = 0

    foreach($Line in Get-Content $FilePath){
        $History += $Line
    }

    foreach($Line in $History){
        $Sum += PredictHistory -History $Line
    }

    $Sum
}