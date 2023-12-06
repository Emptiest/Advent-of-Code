function New-AOCDay {
    param (
        [int]$Year,
        [string]$Day
    )

    $Path = ".\$($Year)\Day $($Day)"

    New-Item -ItemType Directory -Path $Path

    if($Day.Length -lt 2){
        $Day = "0" + $Day
    }

    Copy-Item -Path ".\Template\Resolve-AOCYYYYDDPP.ps1" -Destination ".\$($Year)\Day $($Day)\Resolve-AOC$($Year)$($Day)P1.ps1"

    Set-Location $Path

}