function Resolve-AOC202302P2 {
    [CmdletBinding()]
    param (
        [string]$FilePath
    )

    $output = 0

    foreach($Line in Get-Content $FilePath){
        #$ID = $Line.Split(":").Get(0) -replace "[^0-9]" , ""
        $GameLine = $Line.Split(":").Split(";").Trim()

        $GameRed = 0
        $GameGreen = 0
        $GameBlue = 0

        foreach($GameSet in $GameLine){
            $SetRed = 0
            $SetGreen = 0
            $SetBlue = 0
            $Set = $GameSet.Split(",").Trim()

            foreach($CubeLine in $Set){
                #Write-Verbose $CubeLine
                $Num = ($CubeLine -replace "[^0-9]" , "").Trim()

                switch($CubeLine){
                    {$_ -match "red"} {$SetRed += $Num}
                    {$_ -match "green"} {$SetGreen += $Num}
                    {$_ -match "blue"} {$SetBlue += $Num}
                }
            }

            if($SetRed -gt $GameRed){
                $GameRed = $SetRed
            }
            if($SetGreen -gt $GameGreen){
                $GameGreen = $SetGreen
            }
            if($SetBlue -gt $GameBlue){
                $GameBlue = $SetBlue
            }
        }
        $Power = $GameRed * $GameGreen * $GameBlue
        $output += $Power
    }

    $output
}