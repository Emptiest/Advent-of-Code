function Helper1 {
    [CmdletBinding()]
    param (
        $Object
    )

    $output
}

function Resolve-AOC202301P1 {
    [CmdletBinding()]
    param (
        [string]$FilePath
    )

    $output = 0

    foreach($Line in Get-Content $FilePath){
        $Digits = ($Line -replace "[^0-9]" , "").ToCharArray()
        [string]$FirstDigit = $Digits.get(0)
        Write-Verbose "$($FirstDigit) is First"
        [string]$LastDigit = $Digits.get($Digits.Count -1)
        Write-Verbose "$($LastDigit) is Last"

        $Combined = $FirstDigit + $LastDigit
        $output += [int]$Combined
    }

    $output
}