#Scrieți un script PowerShell care să detecteze toate dispozitivele conectate la rețeaua locală și să afișeze adresele lor IP și MAC.
Write-Host "🔍 Se scanează rețeaua locală pentru dispozitive conectate..." -ForegroundColor Cyan

# Rulăm comanda ARP pentru a obține lista dispozitivelor conectate
$dispozitive = arp -a

# Verificăm dacă avem rezultate
if ($dispozitive -match "No ARP Entries Found") {
    Write-Host "❌ Nu au fost găsite dispozitive conectate." -ForegroundColor Red
    exit
}

# Procesăm rezultatele și extragem IP-urile și adresele MAC
$dispozitive | ForEach-Object {
    if ($_ -match "(\d+\.\d+\.\d+\.\d+)\s+([\w-]+)") {
        $ip = $matches[1]
        $mac = $matches[2]
        Write-Host "📡 IP: $ip  |  MAC: $mac" -ForegroundColor Green
    }
}
