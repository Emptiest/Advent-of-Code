# Does not work

function New-Map {
    param(
        [string]$FilePath
    )

    $Content = Get-Content $FilePath
    $output = @()

    foreach($Line in $Content){
        $object = [PSCustomObject]@{
            DestinationStart = [int]($Line.Split(" ").Get(0))
            SourceStart = [int]($Line.Split(" ").Get(1))
            RangeLength = [int]($Line.Split(" ").Get(2))
        }
        $output += $object
    }
    $output
}

function Search-Map {
    param(
        $Start,
        $Map
    )

    $MidIndex = $false
    foreach($Line in $Map){
        if(($Start -ge $($Map.SourceStart)) -and ($Start -lt $($Map.SourceStart + $Map.RangeLength))){
            $output = $Start + ($Map.SourceStart - $Map.DestinationStart)
            $MidIndex = $true
        }
    }

    if(-not $MidIndex){
        $output = $Start
    }
    $output
}

function Find-Location {
    param(
        [int]$Seed,
        $SeedToSoilMap,
        $SoilToFertilizerMap,
        $FertilizerToWaterMap,
        $WaterToLightMap,
        $LightToTempMap,
        $TempToHumidityMap,
        $HumidityToLocationMap
    )
    $output = Search-Map -Start $Seed -Map $SeedToSoilMap
    $output
}

function Resolve-AOC202305P1 {
    [CmdletBinding()]
    param (
        [string]$SeedFile,
        [string]$SeedToSoilFile,
        [string]$SoilToFertilizerFile,
        [string]$FertilizerToWaterFile,
        [string]$WaterToLightFile,
        [string]$LightToTempFile,
        [string]$TempToHumidityFile,
        [string]$HumidityToLocationFile
    )

    $SeedToSoilMap = New-Map -FilePath $SeedToSoilFile
    $SoilToFertilizerMap = New-Map -FilePath $SoilToFertilizerFile
    $FertilizerToWaterMap = New-Map -FilePath $FertilizerToWaterFile
    $WaterToLightMap = New-Map -FilePath $WaterToLightFile
    $LightToTempMap = New-Map -FilePath $LightToTempFile
    $TempToHumidityMap = New-Map -FilePath $TempToHumidityFile
    $HumidityToLocationMap = New-Map -FilePath $HumidityToLocationFile

    $Seeds = (Get-Content $SeedFile).Split(" ")
    $Locations = @()

    foreach($Seed in $Seeds){
        $Locations += Find-Location -Seed $Seed -SeedToSoilMap $SeedToSoilMap -SoilToFertilizerMap $SoilToFertilizerMap -FertilizerToWaterMap $FertilizerToWaterMap -WaterToLightMap $WaterToLightMap -LightToTempMap $LightToTempMap -TempToHumidityMap $TempToHumidityMap -HumidityToLocationMap $HumidityToLocationMap
    }


    $output = $Locations | Measure-Object -Minimum | Select-Object -ExpandProperty Minimum
    $output
}