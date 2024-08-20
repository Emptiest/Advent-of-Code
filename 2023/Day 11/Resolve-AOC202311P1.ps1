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

function ExpandInput {
    param(
        $Space
    )

    for($i = 0; $i -lt $Space.Count; $i++){
        if($Space[$i] -notmatch "[^.]"){
            # Insert a line with no galaxy
            $NewLine = "." * $Space[$i].Length
            for($j = 0; $j -lt $Space.Count + 1; $j++){
                
            }
        }
    }

    foreach($Line in $Space){
        if($Line -notmatch "[^.]"){         # if the line consists of only .
            $TempSpace.IndexOf($Line)
        }
    }

    $NewSpace
}

function Resolve-AOC202311P1 {
    [CmdletBinding()]
    param (
        [string]$FilePath
    )

    $RawInput = StoreInput -FilePath $FilePath

    $RawInput
}