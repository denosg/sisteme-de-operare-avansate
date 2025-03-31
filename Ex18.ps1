#Scrieți un script PowerShell care să afișeze toate serviciile care rulează pe un sistem și să le ordoneze după starea lor (pornit/oprit).
# Obținem toate serviciile și le ordonăm după starea lor
$servicii = Get-Service | Sort-Object Status

# Afișăm serviciile
$servicii | ForEach-Object {
    Write-Host "$($_.Name) - $($_.Status)" 
}
