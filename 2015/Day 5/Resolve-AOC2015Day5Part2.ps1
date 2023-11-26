function Resolve-AOC2015Day5Part2 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )

    $NiceCounter = 0

    foreach($line in Get-Content $FilePath) {
        $Naughty = $false
        if($line -notmatch "(..).*\1"){                             # Rule 1: Contain a pair of any two letters that appears at least twice without overlapping
            Write-Verbose "$line is naughty"
            $Naughty = $true
        }
        if(-not $Naughty){
            if($line -notmatch "(.).\1"){                           # Rule 2: Containe at least one letter which repeats with exactly one letter in between
                Write-Verbose "$line is naughty"
                $Naughty = $true
            }
        }
        if(-not $Naughty){
            Write-Verbose "$line must be nice"
            $NiceCounter++
        }
    }
    $NiceCounter
}