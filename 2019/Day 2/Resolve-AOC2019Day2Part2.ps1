function Resolve-AOC2019Day2Part2 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )

    $IntCode = [int[]](Get-Content $FilePath).Split(",")
    for($i = 0; $i -lt $IntCode.Count; $i++){
        Write-Verbose $IntCode.Get($i)
    }

    $Searching = $true
    $Noun = 0
    $Verb = 0

    while($Searching){
        $IntCodeCopy = $IntCode
        $Output = Resolve-IntCode -IntCode $IntCodeCopy

        if($Output.Get(0) -eq 19690720){
            Write-Output "Noun is $($Output.Get(1))"
            Write-Output "Verb is $($Output.Get(2))"
            $Answer = 100 * $IntCode.Get(1) + $IntCode.Get(2)
            Write-Output "Answer is $Answer"
            $Searching = $false
        }else{
            if($Noun -eq 99){
                $Noun = 0
                $Verb++
                $IntCode = [int[]](Get-Content $FilePath).Split(",")
                $IntCode.Item(1) = $Noun
                $IntCode.Item(2) = $Verb
            }else{
                $Noun++
                $IntCode = [int[]](Get-Content $FilePath).Split(",")
                $IntCode.Item(1) = $Noun
                $IntCode.Item(2) = $Verb
            }
        }
    }
}

function Resolve-IntCode {
    [CmdletBinding()]
    param(
        [int[]]$IntCode
    )
    
    $Running = $true

    $i = 0 #index
    while ($Running) {
        Write-Verbose "Old values starting from index $i are $($IntCode.Get($i)),$($IntCode.Get($i+1)),$($IntCode.Get($i+2)),$($IntCode.Get($i+3))"
        $OpCode = $IntCode.Get($i)
        $num1 = $IntCode.Get($IntCode.Get($i+1))
        $num2 = $IntCode.Get($IntCode.Get($i+2))
        $outputIndex = $IntCode.Get($i + 3)

        switch($OpCode){
            99  {Write-Verbose "Found OpCode 99 at position $i, halting"; $Running = $false}

            1   {
                $newNum = $num1 + $num2
                Write-Verbose "Adding $num1 and $num2"
                $IntCode.Item($outputIndex) = $newNum
                Write-Verbose "Wrote $newNum to index $outputIndex"
                $i = $i + 4
            }
            2   {
                $newNum = $num1 * $num2
                $IntCode.Item($outputIndex) = $newNum
                Write-Verbose "Wrote $newNum to index $outputIndex"
                $i = $i + 4
            }
            Default {Write-Error "Invalid OpCode at index $i"; break}
        }
    }
    Write-Verbose "Item at Index 0 this time is $($IntCode.Get(0))"
    $IntCode
}