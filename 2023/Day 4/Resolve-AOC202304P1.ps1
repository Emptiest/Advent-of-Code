function Resolve-AOC202304P1 {
    [CmdletBinding()]
    param (
        [string]$FilePath
    )

    [int]$output = 0

    foreach($Card in Get-Content $FilePath){
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
        if($numMatches -gt 0){
            Write-Verbose "$numMatches winning numbers found"
            $output = $output + [Math]::Pow(2,$numMatches - 1)
            Write-Verbose "Adding $([Math]::Pow(2,$numMatches - 1))"
        }
    }

    $output
}