function Resolve-AOC2015Day5Part2 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )

    $NiceCounter = 0

    foreach($line in Get-Content $FilePath) {
        $Naughty = $false
        if($line -match "^.*ab.*|.*cd.*|.*pq.*|.*xy.*$"){           # Rule 3: Do not contain certain strings "ab", "cd", "pq", or "xy"
            Write-Verbose "$line is naughty"
            $Naughty = $true
        }
        if(-not $Naughty){
            if($line -notmatch "(\w)\1{1}"){                        # Rule 2: Contain at least one pair
                Write-Verbose "$line is naughty"
                $Naughty = $true
            }
        }
        if(-not $Naughty){
            if($line -notmatch "[aeiou].*[aeiou].*[aeiou]"){        # Rule 1: at least 3 vowels
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