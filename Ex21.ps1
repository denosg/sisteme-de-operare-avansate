#Scrieți un script PowerShell care să citească un fișier JSON și să extragă o anumită informație specificată ca parametru.
param (
    [string]$caleFișierJSON,
    [string]$cheie
)

# Verificăm dacă fișierul JSON există
if (-Not (Test-Path $caleFișierJSON)) {
    Write-Output "Fișierul JSON nu există."
    exit
}

# Citim conținutul fișierului JSON
$continutJSON = Get-Content -Path $caleFișierJSON -Raw | ConvertFrom-Json

# Verificăm dacă cheia specificată există în JSON
if ($continutJSON.PSObject.Properties[$cheie]) {
    # Extragem informația asociată cheii
    $valoare = $continutJSON.$cheie
    Write-Output "Valoarea pentru cheia '$cheie' este: $valoare"
} else {
    Write-Output "Cheia '$cheie' nu există în fișierul JSON."
}

#.\Ex21.ps1 -caleFișierJSON "D:\SOA\Powershell\Exercitii\person.json" -cheie "name"