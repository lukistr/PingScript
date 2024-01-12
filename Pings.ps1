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
    $pda = Read-Host -Prompt "Input the PDA number: "
    $date = Get-Date -DisplayHint Date -Format "dd-MM-yyyy"

    if ( [string]::IsNullOrWhiteSpace($pda) ){
        pda
    } else{
        if ( Test-Path ".\logs" ) {
            ping -t $ipaddress | ForEach {"{0} - {1}" -f (Get-Date),$_} | Tee-Object -FilePath "./logs/$pda $date.txt" -Append
        } else {
            New-Item -Path "." -Name "logs" -ItemType Directory
            ping -t $ipaddress | ForEach {"{0} - {1}" -f (Get-Date),$_} | Tee-Object -FilePath "./logs/$pda $date.txt" -Append
        }
    }
}

ipaddress