function Resolve-AOC2015Day1Part2 {
    [CmdletBinding()]
    param (
        [String]$InputString
    )

    Write-Verbose "Received $InputString"

    $CharacterArray = $InputString.ToCharArray()

    Write-Verbose "Converted to Character Array of size $($CharacterArray.Count)"

    $Floor = 0
    $Position = 1

    foreach($Character in $CharacterArray){
        if($Character -eq "(") {           # If up
            Write-Verbose "Going up"
            $Floor++
        }elseif($Character -eq ")") {      # If down
            Write-Verbose "Going down"
            $Floor--
            if($Floor -eq -1){
                Write-Verbose "We've entered the basement!"
                $Position
            }
        }
        $Position++
    }

}