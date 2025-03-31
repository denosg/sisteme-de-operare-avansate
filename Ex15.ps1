#Scrieți un script PowerShell care să găsească toate fișierele dintr-un director care au o anumită extensie și să le șteargă.
param (
    [string]$director,
    [string]$extensie
)

# Verificăm dacă directorul există
if (-Not (Test-Path $director)) {
    Write-Output "Directorul specificat nu există."
    exit
}

# Căutăm toate fișierele cu extensia dată în directorul specificat
$fișiereDeȘters = Get-ChildItem -Path $director -Filter "*.$extensie" -File

# Dacă sunt fișiere de șters
if ($fișiereDeȘters.Count -gt 0) {
    foreach ($fișier in $fișiereDeȘters) {
        # Ștergem fișierul
        Remove-Item $fișier.FullName -Force
        Write-Output "Fișierul '$($fișier.Name)' a fost șters."
    }
} else {
    Write-Output "Nu au fost găsite fișiere cu extensia '.$extensie' în directorul specificat."
}
