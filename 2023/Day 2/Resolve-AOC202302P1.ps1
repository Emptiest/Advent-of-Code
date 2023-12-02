function Resolve-AOC202302P1 {
    [CmdletBinding()]
    param (
        [string]$FilePath,
        [int]$Red,
        [int]$Green,
        [int]$Blue
    )

    $output = 0

    foreach($Line in Get-Content $FilePath){
        $ID = $Line.Split(":").Get(0) -replace "[^0-9]" , ""
        $GameLine = $Line.Split(":").Split(";").Trim()
        $Impossible = $false

        foreach($GameSet in $GameLine){
            $GameRed = 0
            $GameGreen = 0
            $GameBlue = 0
            $Set = $GameSet.Split(",").Trim()

            foreach($CubeLine in $Set){
                #Write-Verbose $CubeLine
                $Num = ($CubeLine -replace "[^0-9]" , "").Trim()

                switch($CubeLine){
                    {$_ -match "red"} {$GameRed += $Num}
                    {$_ -match "green"} {$GameGreen += $Num}
                    {$_ -match "blue"} {$GameBlue += $Num}
                }
            }
            if(
                ($GameRed -gt $Red) -or
                ($GameGreen -gt $Green) -or
                ($GameBlue -gt $Blue)
            ){
                $Impossible = $true
                Write-Verbose "Game $ID was impossible"
            }
        }

        if(-not $Impossible){
            $output += $ID
            Write-Verbose "Adding $ID; Running total is $output"
        }
        
    }

    $output
}