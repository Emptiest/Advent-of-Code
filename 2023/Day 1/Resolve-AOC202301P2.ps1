function Resolve-AOC202301P2 {
    [CmdletBinding()]
    param (
        [string]$FilePath
    )

    $output = 0

    foreach($Line in Get-Content $FilePath){
        $Line = $Line -replace "one" , "one1one"
        $Line = $Line -replace "two" , "two2two"
        $Line = $Line -replace "three" , "three3three"
        $Line = $Line -replace "four" , "four4four"
        $Line = $Line -replace "five" , "five5five"
        $Line = $Line -replace "six" , "six6six"
        $Line = $Line -replace "seven" , "seven7seven"
        $Line = $Line -replace "eight" , "eight8eight"
        $Line = $Line -replace "nine" , "nine9nine"
        Write-Verbose "Line is now $Line"
        
        $Digits = ($Line -replace "[^0-9]" , "").ToCharArray()
        Write-Verbose "Digits are $Digits"
        [string]$FirstDigit = $Digits.get(0)
        Write-Verbose "$($FirstDigit) is First"
        [string]$LastDigit = $Digits.get($Digits.Count -1)
        Write-Verbose "$($LastDigit) is Last"

        $Combined = $FirstDigit + $LastDigit
        Write-Verbose "Combined is $Combined"
        $output += [int]$Combined
        Write-Verbose "Running total is $output"
    }

    $output
}