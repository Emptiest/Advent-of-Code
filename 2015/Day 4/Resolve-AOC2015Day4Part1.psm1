function Get-HashFromString {
    param(
        [string]$String
    )

    $stringAsStream = [System.IO.MemoryStream]::new()
    $writer = [System.IO.StreamWriter]::new($stringAsStream)
    $writer.write($String)
    $writer.Flush()
    $stringAsStream.Position = 0
    $Output = Get-FileHash -InputStream $stringAsStream | Select-Object Hash
    $Output
}

function Resolve-AOC2015Day4Part1 {
    [CmdletBinding()]
    param(
        [string]$String
    )

    $Searching = $true
    $Postfix = 0

    while($Searching){
        $Try = $String + $Postfix
        Write-Verbose "Trying $Try"
        $Solution = Get-HashFromString -String $Try | Select-Object -ExpandProperty Hash
        Write-Verbose "Hashed value is $Solution"

        if($Solution.StartsWith("00000")){
            Write-Verbose "Found a good hash!"
            $Searching = $false
        }else{
            $Postfix++
        }
    }
    $Postfix
}