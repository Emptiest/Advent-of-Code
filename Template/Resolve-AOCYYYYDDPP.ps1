function Resolve-AOCYYYYDDPP {
    [CmdletBinding()]
    param (
        [string]$FilePath
    )

    foreach($Line in Get-Content $FilePath){
        #Do-Something
    }

    $output
}