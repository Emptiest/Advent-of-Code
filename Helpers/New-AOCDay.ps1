function New-AOCDay {
    param (
        [int]$Year,
        [string]$Day,
        $SessionCookie
    )

    $Path = ".\$($Year)\Day $($Day)"

    New-Item -ItemType Directory -Path $Path | Out-Null

    Get-AOCInputFile -SessionCookie $SessionCookie -OutputFile "$Path\input.txt" -Year $Year -Day $Day

    if($Day.Length -lt 2){
        $Day = "0" + $Day
    }

    Copy-Item -Path ".\Template\Resolve-AOCYYYYDDPP.ps1" -Destination "$Path\Resolve-AOC$($Year)$($Day)P1.ps1"

    Set-Location $Path

    

}