#Scrieți un script PowerShell care să afișeze toate procesele care rulează pe un sistem și să le ordoneze după numele procesului în ordine alfabetică

# Obținem toate procesele care rulează pe sistem
$procese = Get-Process

# Ordonați procesele după numele procesului în ordine alfabetică
$proceseSortate = $procese | Sort-Object Name

# Afișăm procesele sortate
$proceseSortate | Format-Table -Property Name, Id, CPU, Memory
