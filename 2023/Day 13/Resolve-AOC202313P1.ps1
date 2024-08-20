function SplitInput {
    param(
        $RawInput
    )

    $TempArray = @()
    $ArrayIndex = 0
    $SplitInput = @()

    for($i = 0; $i -le $RawInput.Count; $i++){
        Write-Verbose "Parsing Line $($i) of $($RawInput.Count)"
        if(($RawInput[$i] -match "\S") -and ($i -lt $($RawInput.Count))){
            $TempArray += $RawInput[$i]
        }else{
            $SplitInputObject = [PSCustomObject]@{
                Index = $ArrayIndex
                Array = $TempArray
            }
            $ArrayIndex ++
            $TempArray = @()
            $SplitInput += $SplitInputObject
            Write-Verbose "Adding $($SplitInputObject.Array) at Index $($SplitInputObject.Index)"
        }
    }

    $SplitInput
}

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

function FindMirror {
    param(
        $Arrays
    )

    $MirrorIndices = @()

    foreach($Array in $Arrays){
        for($i = 0; $i -lt $Array.Array.Count){
            
        }
        
        $TempMirrorIndex = [PSCustomObject]@{
            Orientation = $MirrorOrientation
            MirrorIndex = $MirrorIndex
            Index = $Array.Index
        }
        $MirrorIndices += $TempMirrorIndex
    }

    $MirrorIndices
}

function Resolve-AOC202313P1 {
    [CmdletBinding()]
    param (
        [string]$FilePath
    )

    $RawInput = StoreInput -FilePath $FilePath

    $SplitInput = SplitInput -RawInput $RawInput

    $SplitInput
}