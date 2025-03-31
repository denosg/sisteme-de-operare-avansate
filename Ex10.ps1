#Scrieți un script PowerShell care să afișeze informații despre procesele care rulează pe un sistem, inclusiv PID-ul, numele procesului și consumul de memorie.

# Obținem toate procesele care rulează pe sistem
$procese = Get-Process

# Afișăm informațiile relevante pentru fiecare proces
$procese | Select-Object Id, ProcessName, @{Name="Memorie (MB)"; Expression={($_.WorkingSet64 / 1MB).ToString("F2")}} | Format-Table -AutoSize


