function StoreInput {
    param(
        [string]$FilePath
    )

    $Lines = @()

    foreach($Line in Get-Content $FilePath){
        $Lines += $Line
    }



    $Lines

}

function Resolve-AOC202310P1 {
    [CmdletBinding()]
    param (
        [string]$FilePath
    )

    $Maze = StoreInput -FilePath $FilePath

    $StartingPos = New-Object System.Management.Automation.Host.Coordinates

    for($i = 0; $i -lt $Maze.Count; $i++){
        if($Maze[$i] -match "S"){
            $StartingPos.Y = $i
            $StartingPos.X = $Maze[$i].IndexOf("S")
        }
    }

    $StartingPos
}