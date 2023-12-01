function Get-AOCInputFile {
    param (
        [string]$SessionCookie,
        [Parameter(Mandatory)]
        [string]$OutputFile,
        [int]$Year,
        [int]$Day
    )

    if($SessionCookie){
        $Uri = "https://adventofcode.com/$($Year)/day/$($Day)/input"
        $InputFile = Invoke-WebRequest -Uri $Uri -Headers @{Cookie="session=$SessionCookie"} | Select-Object -ExpandProperty Content
        $InputFile | Out-File $OutputFile
    }else{
        Write-Error "SessionCookie was blank!"
        Write-Host "To get your session cookie, do the following:"
        Write-Host "On Firefox:"
        Write-Host "* Log in to Advent of Code"
        Write-Host "* Right click > Inspect > Storage Tab > Cookies"
        Write-Host "* Your session cookie value is the value of the cookie named 'session'"
        Write-Host "On Chrome:"
        Write-Host "TBD"
    }

}