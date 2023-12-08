# Works, but is brute force only. Doesn't work for the puzzle because the answer is too high of a number.

function MakeStep {
    param(
        [hashtable]$HashTable,
        [string]$Key,
        [string]$Step
    )

    $Options = $HashTable[$Key]
    $Left = (($Options) -replace "[()]","").Split(",").Trim()[0]
    $Right = (($Options) -replace "[()]","").Split(",").Trim()[1]

    switch($Step) {
        L {
            $ResultingKey = $Left
            #Write-Verbose "Moving from $CurrentStep to $Left"
        }
        R {
            $ResultingKey = $Right
            #Write-Verbose "Moving from $CurrentStep to $Right"
        }
    }
    $ResultingKey
}

function MakeLRSteps {
    param(
        [string]$LRInstructions,
        [hashtable]$HashTable,
        [string]$StartKey
    )

    $LRArray = $LRInstructions.ToCharArray()

    $StepCount = 0
    $CurrentStep = $StartKey

    while($CurrentStep -ne "ZZZ"){
        foreach($Step in $LRArray){
            $CurrentStep = MakeStep -Key $CurrentStep -HashTable $HashTable -Step $Step
            
            $StepCount++
    
            if($CurrentStep -eq "ZZZ"){Write-Verbose "found ZZZ, breaking loop";break}
        }
        Write-Verbose "Current Stepcount is $StepCount"
    }
    

    $StepCount
}

function ReadAOCInput {
    param(
        [string]$FilePath
    )

    $InputFile = Get-Content $FilePath | Select-Object -Skip 2

    $HashTable = @{}

    foreach($Line in $InputFile){
        $Key = $Line.Split("=")[0].Trim()
        $Value = $Line.Split("=")[1].Trim()
        $HashTable.add( $Key, $Value )
    }

    $HashTable
}

function Resolve-AOC202308P1 {
    [CmdletBinding()]
    param (
        [string]$FilePath
    )

    $InputFile = Get-Content $FilePath | Select-Object -Skip 2

    $LRInstructions = Get-Content $FilePath | Select-Object -First 1
    $StartKey = $InputFile[0].Split("=")[0].Trim()

    $HashTable = ReadAOCInput -FilePath $FilePath

    $Result = MakeLRSteps -LRInstructions $LRInstructions -HashTable $HashTable -StartKey $StartKey

    $Result
}