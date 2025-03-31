#Scrieți un script PowerShell care să afișeze informații despre toate fișierele dintr-un director, inclusiv numele fișierului, dimensiunea și data creării.
param (
    [string]$director
)

# Verificăm dacă directorul există
if (-Not (Test-Path $director)) {
    Write-Output "Directorul specificat nu există."
    exit
}

# Obținem toate fișierele din director
$fișiere = Get-ChildItem -Path $director -File

# Afișăm informațiile pentru fiecare fișier
$fișiere | Select-Object Name, @{Name="Dimensiune (MB)"; Expression={($_.Length / 1MB).ToString("F2")}}, CreationTime | Format-Table -AutoSize


#.\Ex11.ps1 -director "D:\SOA\Powershell\Exercitii"