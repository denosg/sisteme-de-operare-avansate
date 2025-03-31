#Scrieți un script PowerShell care să descarce conținutul unei pagini web și să îl salveze într-un fișier local.
param (
    [string]$url,
    [string]$caleFisier
)

# Verificăm dacă avem acces la URL
try {
    Write-Host "Se descarcă conținutul de la: $url" -ForegroundColor Cyan
    $continut = Invoke-WebRequest -Uri $url -UseBasicParsing

    # Salvăm conținutul în fișier
    $continut.Content | Out-File -FilePath $caleFisier -Encoding UTF8
    Write-Host "Conținutul a fost salvat în: $caleFisier" -ForegroundColor Green
}
catch {
    Write-Host "Eroare la descărcarea paginii: $_" -ForegroundColor Red
}
