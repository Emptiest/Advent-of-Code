function Resolve-AOC2015Day3Part2 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )

    $Santa = New-Object System.Management.Automation.Host.Coordinates
    $RoboSanta = New-Object System.Management.Automation.Host.Coordinates
    $Visited = New-Object System.Collections.Generic.List[System.Management.Automation.Host.Coordinates]

    $Visited.Add($Santa) | Out-Null              # Initial one at (0,0)

    $File = Get-Content -Path $FilePath

    $Instructions = $File.ToCharArray()
    [switch]$SantaSwitch = $true

    foreach($Direction in $Instructions){

        switch ($SantaSwitch) {
            $false  {$SantaSwitch = $true}
            $true   {$SantaSwitch = $false}
        }

        Write-Verbose "We're moving in this direction: $Direction"
        switch ($Direction) {
            {$_ -eq "<" -and $SantaSwitch}          {$Santa.X -= 1; Write-Verbose "Santa is Moving West"}
            {$_ -eq "<" -and -not $SantaSwitch}     {$RoboSanta.X -= 1; Write-Verbose "RoboSanta is Moving West"}
            {$_ -eq ">" -and $SantaSwitch}          {$Santa.X += 1; Write-Verbose "Santa is Moving East"}
            {$_ -eq ">" -and -not $SantaSwitch}     {$RoboSanta.X += 1; Write-Verbose "RoboSanta is Moving East"}
            {$_ -eq "^" -and $SantaSwitch}          {$Santa.Y += 1; Write-Verbose "Santa is Moving North"}
            {$_ -eq "^" -and -not $SantaSwitch}     {$RoboSanta.Y += 1; Write-Verbose "RoboSanta is Moving North"}
            {$_ -eq "v" -and $SantaSwitch}          {$Santa.Y -= 1; Write-Verbose "Santa is Moving South"}
            {$_ -eq "v" -and -not $SantaSwitch}     {$RoboSanta.Y -= 1; Write-Verbose "RoboSanta is Moving South"}
        }

        if($SantaSwitch){
            Write-Verbose "Santa moved to $Santa"
            if($Visited -notcontains $Santa){
                Write-Verbose "$Santa is a new house! Incrementing"
                $Visited.Add($Santa) | Out-Null
            }else{
                Write-Verbose "Santa or RoboSanta has visited $Santa before."
            }
        }else{
            Write-Verbose "RoboSanta moved to $RoboSanta"
            if($Visited -notcontains $RoboSanta){
                Write-Verbose "$RoboSanta is a new house! Incrementing"
                $Visited.Add($RoboSanta) | Out-Null
            }else{
                Write-Verbose "Santa or RoboSanta has visited $RoboSanta before."
            }
        }
    }

    $Visited.Count
}