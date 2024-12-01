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

function Resolve-AOC202401P1 {
    [CmdletBinding()]
    param (
        [string]$FilePath
    )

    $RawInput = StoreInput -FilePath $FilePath

    $ParseInput = $RawInput.Split("   ")
    $index = 0
    $List1 = foreach($Number in $ParseInput){
        if($index % 2 -eq 0){   # If even
            $Number
        }
        $index++
    }

    $index = 0
    $List2 = foreach($Number in $ParseInput){
        if($index % 2 -ne 0){   # If odd
            $Number
        }
        $index++
    }

    $List1 = $List1 | Sort-Object
    $List2 = $List2 | Sort-Object

    $Sum = 0
    for($i = 0; $i -lt $List1.Count; $i++){
        $Distance = [System.Math]::Abs($List1[$i] - $List2[$i])
        Write-Verbose $Distance
        $Sum += $Distance
    }
    $Sum
}