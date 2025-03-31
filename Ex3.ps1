# Scrieți un script PowerShell care să afișeze primele zece linii ale unui fișier dat ca
# parametru.

param (
    [string]$caleFișier
)

# Verificăm dacă fișierul există
if (-Not (Test-Path $caleFișier)) {
    Write-Output "Fișierul specificat nu există."
    exit
}

# Citim primele 10 linii din fișier
$primele10Linii = Get-Content -Path $caleFișier | Select-Object -First 10

# Afișăm primele 10 linii
$primele10Linii


#.\Ex3.ps1 -caleFișier "C:\Users\cti22d102\Desktop\Powershell-2\exemplu.txt"
