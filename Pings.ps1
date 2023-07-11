<#
param (
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    $ipaddress,
    [Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    $pda
)
#>

function ipaddress(){
    $ipaddress = Read-Host -Prompt "Input the address: "

    if ( [string]::IsNullOrWhiteSpace($ipaddress) ){
        ipaddress
    } else {
        pda
    }
}

function pda(){
    [int]$pda = Read-Host -Prompt "Input the PDA number: "

    if ( $pda -ne "" ){
        if ( Test-Path ".\log" ) {
            ping -t $ipaddress | ForEach {"{0} - {1}" -f (Get-Date),$_} | Tee-Object -FilePath "./log/pda$pda.txt" -Append
        } else {
            New-Item -Path "." -Name "log" -ItemType Directory
            ping -t $ipaddress | ForEach {"{0} - {1}" -f (Get-Date),$_} | Tee-Object -FilePath "./log/pda$pda.txt" -Append
        }
    } else{
        pda
    }
}

ipaddress