# Does Not work

function Resolve-AOC202304P2 {
    [CmdletBinding()]
    param (
        [string]$FilePath
    )

    $Pile = Get-Content $FilePath
    [int]$output = $Pile.Count

    foreach($Card in $Pile){
        $Numbers = $Card.Split("|").Trim()
        # Store winning numbers
        $WinningNumbers = @()
        # Store other numbers
        $MyNumbers = @()
        for($i = 0; $i -lt $Numbers.Count; $i++){
            if($i % 2){
                #$MyNumbers += $Numbers.Get($i).Split("  ").Trim().Split(" ").Trim()
                $MyNumbers += $Numbers.Get($i).Split("  ").Trim().Split(" ").Trim()
            }else{
                $WinningNumbers += $Numbers.Get($i).Split(":").Trim().Get(1).Split("  ").Trim().Split(" ").Trim()
            }
        }
        # Compare number of matches
        $numMatches = 0
        foreach($Winnum in $WinningNumbers){
            foreach($Mynum in $MyNumbers){
                if($Winnum -eq $Mynum){
                    $numMatches++
                    Write-Verbose "Match found with $Winnum"
                }
            }
        }
        
        while($numMatches -gt 0){
            $Pile
            $numMatches--
        }
    }

    $output
}