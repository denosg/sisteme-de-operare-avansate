#Scrieți un script PowerShell care să afle adresa IP publică a computerului folosind o solicitare web.
try {
    Write-Host "Se obține adresa IP publică..." -ForegroundColor Cyan
    
    # Interogăm un serviciu extern care returnează IP-ul public
    $ipPublic = Invoke-RestMethod -Uri "https://api64.ipify.org?format=text"
    
    Write-Host "Adresa IP publică este: $ipPublic" -ForegroundColor Green
}
catch {
    Write-Host "Eroare la obținerea adresei IP: $_" -ForegroundColor Red
}
