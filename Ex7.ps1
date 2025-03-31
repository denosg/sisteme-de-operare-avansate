#Scrieți un script PowerShell care să descarce un fișier de pe un server web dat ca parametru.

param (
    [string]$url,
    [string]$caleDestinatie
)

# Verificăm dacă URL-ul și calea de destinație au fost specificate
if (-Not $url -or -Not $caleDestinatie) {
    Write-Output "Utilizare: .\Ex7.ps1 -url 'https://exemplu.com/fișier.txt' -caleDestinatie 'C:\Calea\Către\Fișier.txt'"
    exit
}

# Descarcăm fișierul
try {
    Write-Output "Se descarcă fișierul de la: $url"
    Invoke-WebRequest -Uri $url -OutFile $caleDestinatie
    Write-Output "Fișier descărcat cu succes la: $caleDestinatie"
} catch {
    Write-Output "Eroare la descărcare: $_"
}
