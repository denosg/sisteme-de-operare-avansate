#Scrieți un script PowerShell care să compare două directoare și să afișeze diferențele dintre ele (fișiere lipsă sau modificate).
param (
    [string]$director1,
    [string]$director2
)

# Verificăm dacă ambele directoare există
if (-Not (Test-Path $director1)) {
    Write-Output "Directorul $director1 nu există."
    exit
}

if (-Not (Test-Path $director2)) {
    Write-Output "Directorul $director2 nu există."
    exit
}

# Obținem lista fișierelor din fiecare director
$files1 = Get-ChildItem -Path $director1 -File -Recurse
$files2 = Get-ChildItem -Path $director2 -File -Recurse

# Creăm un obiect hash pentru fișierele din fiecare director
$hash1 = @{}
$hash2 = @{}

foreach ($file in $files1) {
    $relPath = $file.FullName.Substring($director1.Length + 1)
    $hash1[$relPath] = Get-FileHash $file.FullName -Algorithm SHA256
}

foreach ($file in $files2) {
    $relPath = $file.FullName.Substring($director2.Length + 1)
    $hash2[$relPath] = Get-FileHash $file.FullName -Algorithm SHA256
}

# Comparăm fișierele
Write-Output "`n=== Fișiere care lipsesc în $director2 ==="
foreach ($file in $hash1.Keys) {
    if (-Not $hash2.ContainsKey($file)) {
        Write-Host "[Lipsă] $file" -ForegroundColor Red
    }
}

Write-Output "`n=== Fișiere care lipsesc în $director1 ==="
foreach ($file in $hash2.Keys) {
    if (-Not $hash1.ContainsKey($file)) {
        Write-Host "[Lipsă] $file" -ForegroundColor Yellow
    }
}

Write-Output "`n=== Fișiere modificate ==="
foreach ($file in $hash1.Keys) {
    if ($hash2.ContainsKey($file) -and $hash1[$file].Hash -ne $hash2[$file].Hash) {
        Write-Host "[Modificat] $file" -ForegroundColor Cyan
    }
}

Write-Output "`nComparare finalizată!"
