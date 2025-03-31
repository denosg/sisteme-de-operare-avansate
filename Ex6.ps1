#Scrieți un script PowerShell care să afișeze toate fișierele dintr-un director care au fost modificate în ultimele 24 de ore.

param (
    [string]$director
)

# Verificăm dacă directorul există
if (-Not (Test-Path $director)) {
    Write-Output "Directorul specificat nu există."
    exit
}

# Obținem data și ora curentă și calculăm limita de 24 de ore
$limitaTimp = (Get-Date).AddHours(-24)

# Găsim fișierele modificate în ultimele 24 de ore
$modificate = Get-ChildItem -Path $director -File | Where-Object { $_.LastWriteTime -ge $limitaTimp }

# Verificăm dacă s-au găsit fișiere și le afișăm
if ($modificate.Count -eq 0) {
    Write-Output "Nu există fișiere modificate în ultimele 24 de ore."
} else {
    Write-Output "Fișierele modificate în ultimele 24 de ore:"
    $modificate | ForEach-Object { Write-Output "$($_.FullName) - Ultima modificare: $($_.LastWriteTime)" }
}
