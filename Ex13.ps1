#Scrieți un script PowerShell care să obțină toate fișierele dintr-un director și să le comprime într-un fișier ZIP.
param (
    [string]$director,
    [string]$caleFisierZIP
)

# Verificăm dacă directorul există
if (-Not (Test-Path $director)) {
    Write-Output "Directorul specificat nu există."
    exit
}

# Obținem toate fișierele din director
$fișiere = Get-ChildItem -Path $director -File

# Dacă sunt fișiere în director, le comprimăm într-un fișier ZIP
if ($fișiere.Count -gt 0) {
    # Comprimăm fișierele într-un fișier ZIP
    Compress-Archive -Path $fișiere.FullName -DestinationPath $caleFisierZIP
    Write-Output "Fișierele au fost comprimate în fișierul ZIP: $caleFisierZIP"
} else {
    Write-Output "Nu sunt fișiere în directorul specificat."
}


#.\Ex13.ps1 -director "D:\SOA\Powershell\Exercitii" -caleFisierZIP "D:\SOA\Powershell\Exercitii"