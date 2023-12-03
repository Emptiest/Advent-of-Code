# DOES NOT WORK

function Find-SchematicSymbols {
    param(
        $Schematic
    )

    $output = New-Object System.Collections.Generic.List[System.Management.Automation.Host.Coordinates]

    for($y = 0; $y -lt $Schematic.Count; $y++){
        $Line = $Schematic.Get($y)
        if($Line -match "[^0-9.]"){
            Write-Verbose "Found a match on line $y"
            $LineCharArray = $Line.ToCharArray()
            $Symbol = New-Object System.Management.Automation.Host.Coordinates
            $Symbol.Y = $y
            for($i = 0; $i -lt $LineCharArray.Count; $i++){
                if($LineCharArray.Get($i) -match "[^0-9.]"){
                    $Symbol.X = $i
                    $output.Add($Symbol)
                    Write-Verbose "Adding $($Symbol.X),$($Symbol.Y) to SymbolLocations"
                }
            }
            
        }
    }

    $output
}

function Find-SchematicNumbers {
    param(
        $Schematic
    )

    $output = New-Object System.Collections.Generic.List[System.Management.Automation.Host.Coordinates]

    for($y = 0; $y -lt $Schematic.Count; $y++){
        $Line = $Schematic.Get($y)
        if($Line -match "\d"){
            Write-Verbose "Found a match on line $y"
            $Number = New-Object System.Management.Automation.Host.Coordinates
            $Number.Y = $y
            while($Line -match "\d+"){
                $Number.X = $Line.IndexOf($Matches[0])
                $output.Add($Number)
                Write-Verbose "Adding $($Number.X),$($Number.Y) to NumberLocations"
                $Line = $Line -replace $Matches[0] , ("." * $Matches[0].Length)
                Write-Verbose "Replaced line is $Line"
            }
        }
    }
    $output
}

function Confirm-AdjacentSymbol {
    param (
        [System.Management.Automation.Host.Coordinates]$Number,
        $Schematic
    )

    # Is there no adjacent symbol?
    $output = $false

    foreach($num in $Number){
        # Get Length of the number
        Write-Verbose "Checking $num location"
        $CharArray = $Schematic.Get($num.Y).ToCharArray()
        $isDigit = $true
        for($i = 0; $isDigit; $i++){
            if(($i + $num.X) -lt $CharArray.Length){
                if($CharArray.Get($i + $num.X) -match "[^0-9]"){
                    $Length = $i
                    Write-Verbose "Number at $num is $Length digits"
                    $isDigit = $false
                }
            }else{
                $Length = $i
                $isDigit = $false
            }
        }

        # Assemble the coordinates to check
        $IndexesToCheck = New-Object System.Collections.Generic.List[System.Management.Automation.Host.Coordinates]
        $CurrentCheck = New-Object System.Management.Automation.Host.Coordinates

        for($x = -1; $x -le $Length; $x++){
            for($y = -1; $y -lt 2; $y++){
                $CurrentCheck.X = $num.X + $x
                $CurrentCheck.Y = $num.Y + $y
                Write-Verbose "Iterating through $CurrentCheck"
                #Write-Verbose "First check $($CurrentCheck.X -ge 0)"
                #Write-Verbose "Second check $($CurrentCheck.X -lt ($Schematic.Get($num.Y).Length))"
                #Write-Verbose "Third check $($CurrentCheck.Y -ge 0)"
                #Write-Verbose "Fourth check $($CurrentCheck.Y -lt $Schematic.Count)"
                if(($CurrentCheck.X -ge 0) -and ($CurrentCheck.X -lt ($Schematic.Get($num.Y).Length)) -and ($CurrentCheck.Y -ge 0) -and ($CurrentCheck.Y -lt $Schematic.Count)){            # Making sure it doesn't spill out of bounds
                    $IndexesToCheck.Add($CurrentCheck)
                    Write-Verbose "Adding $($CurrentCheck.X),$($CurrentCheck.Y) to indexes to check"
                }
            }
        }
    }

    # Check the coordinates
    foreach($Index in $IndexesToCheck){
        $Character = $($Schematic.Get($Index.Y).ToCharArray().Get($Index.X))
        Write-Verbose "Character at $Index is $Character"
        if($Character -match "[^0-9.]"){
            $output = $true
        }
    }

    $output
}

function Get-SchematicNumber {
    param (
        [System.Management.Automation.Host.Coordinates]$Coord,
        $Schematic
    )

    $CharArray = $Schematic.Get($num.Y).ToCharArray()
    [string]$IntArray = @()
    $isDigit = $true
    for($i = 0; $isDigit; $i++){
        if($i + $Coord.X -gt $CharArray.Length){
            $isDigit = $false
        }
        if($CharArray.Get($i + $Coord.X) -match "\d"){
            $IntArray = $IntArray + $CharArray.Get($i + $Coord.X)
        }else{
            $isDigit = $false
        }
    }

    [int]$IntArray

}

function Resolve-AOC202303P1 {
    [CmdletBinding()]
    param (
        [string]$FilePath
    )

    $Schematic = Get-Content $FilePath

    $output = 0

    #$SymbolLocations = Find-SchematicSymbols -Schematic $Schematic
    $NumberLocations = Find-SchematicNumbers -Schematic $Schematic
    foreach($num in $NumberLocations){
        if(Confirm-AdjacentSymbol -Number $num -Schematic $Schematic){
            $output += Get-SchematicNumber -Coord $num -Schematic $Schematic
        }
    }

    $output
}