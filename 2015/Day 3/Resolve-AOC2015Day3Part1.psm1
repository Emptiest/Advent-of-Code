function Resolve-AOC2015Day3Part1 {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$FilePath
    )

    $Current = New-Object System.Management.Automation.Host.Coordinates
    $Visited = New-Object System.Collections.Generic.List[System.Management.Automation.Host.Coordinates]
    $Revisited = 0

    $Visited.Add($Current) | Out-Null              # Initial one at (0,0)

    $File = Get-Content -Path $FilePath

    $Instructions = $File.ToCharArray()

    foreach($Direction in $Instructions){
        Write-Verbose "We're moving in this direction: $Direction"
        switch ($Direction) {
            {$_ -eq "<"}     {$Current.X -= 1; Write-Verbose "Moving West"}
            {$_ -eq ">"}     {$Current.X += 1; Write-Verbose "Moving East"}
            {$_ -eq "^"}     {$Current.Y += 1; Write-Verbose "Moving North"}
            {$_ -eq "v"}     {$Current.Y -= 1; Write-Verbose "Moving South"}
        }
        Write-Verbose "Moved to $Current"
        if($Visited -contains $Current){
            Write-Verbose "$Current has been visited before! Incrementing counter"
            $Revisited++
            $Visited.Remove($Current) | Out-Null
        }
        $Visited.Add($Current) | Out-Null
    }

    $Visited.Count

    #$Revisited
}