#Scrieți un script PowerShell care să caute și să înlocuiască un șir de caractere dat ca parametru într-un fișier de tip text.
param (
    [string]$caleFisier,  # Calea către fișierul de tip text
    [string]$cauta,       # Șirul de caractere de căutat
    [string]$inlocuieste   # Șirul de caractere cu care să înlocuim
)

# Verificăm dacă fișierul există
if (-Not (Test-Path $caleFisier)) {
    Write-Output "Fișierul nu există la calea specificată: $caleFisier"
    exit
}

# Citim conținutul fișierului
$continutFisier = Get-Content -Path $caleFisier

# Înlocuim toate aparițiile șirului de caractere
$continutModificat = $continutFisier -replace [regex]::Escape($cauta), $inlocuieste

# Scriem conținutul modificat înapoi în fișier
Set-Content -Path $caleFisier -Value $continutModificat

Write-Output "Șirul '$cauta' a fost înlocuit cu '$inlocuieste' în fișierul $caleFisier."
