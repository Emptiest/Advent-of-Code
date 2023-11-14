function Resolve-AOC2015Day1 {
    [CmdletBinding()]
    param (
        [String]$InputString
    )

    $Ups = 0
    $Downs = 0

    $UpCharacter = "\("
    $DownCharacter = "\)"

    $tempString = ($InputString -replace $UpCharacter,"")
    $Ups = $InputString.Length - $tempString.Length

    $tempString = ($InputString -replace $DownCharacter,"")
    $Downs = $InputString.Length - $tempString.Length

    Write-Verbose "Up: $Ups"
    Write-Verbose "Down: $Down"
    $Result = $Ups - $Downs
    $Result
}