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

function Test-IfSafe {
    [CmdletBinding()]
    param (
        [string]$InputRow
    )
    Write-Verbose "Evaluating row $InputRow"
    $SafeBool = $true
    [int[]]$SplitRow = $InputRow -split " "
    $AscSort = ($SplitRow | Sort-Object) -join " "
    $DescSort = ($SplitRow | Sort-Object -Descending) -join " "

    # Unsafe if difference is 1 < x < 3
    for($i = 0; $i -lt ($SplitRow.Count - 1); $i++){
        $Diff = [System.Math]::Abs($SplitRow[$i] - $SplitRow[$i + 1])
        Write-Verbose "Diff is $Diff"
        if($Diff -lt 1 -or $Diff -gt 3){
            Write-Verbose "Unsafe due diff!"
            $SafeBool = $false
        }
    }

    # Unsafe if not sorted one way or the other
    if($InputRow -ne $AscSort -and $InputRow -ne $DescSort){
        Write-Verbose "Unsafe due to sorting!"
        $SafeBool = $false
    }

    $SafeBool
}

function Resolve-AOC202402P1 {
    [CmdletBinding()]
    param (
        [string]$FilePath
    )

    $RawInput = StoreInput -FilePath $FilePath

    $SafeCount = 0

    foreach($Row in $RawInput){
        if(Test-IfSafe -InputRow $Row){
            $SafeCount++
            Write-Verbose "Safe report found! Incrementing counter to $SafeCount"
        }
    }

    $SafeCount
}