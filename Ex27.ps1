#Scrieți un script PowerShell care să caute fișierele mai mari de o anumită dimensiune într-un director și să le mute într-un alt director.
param (
    [string]$directorSursa,
    [string]$directorDestinatie,
    [float]$dimensiuneMinimaMB  # Dimensiunea minimă a fișierelor în MB
)

# Verificăm dacă directorul sursă există
if (-Not (Test-Path $directorSursa)) {
    Write-Host "Directorul sursă nu există: $directorSursa" -ForegroundColor Red
    exit
}

# Verificăm dacă directorul destinație există, dacă nu, îl creăm
if (-Not (Test-Path $directorDestinatie)) {
    Write-Host "Directorul destinație nu există. Se creează: $directorDestinatie" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $directorDestinatie | Out-Null
}

# Convertim dimensiunea în MB la bytes
$dimensiuneMinimaBytes = $dimensiuneMinimaMB * 1MB

# Găsim fișierele mai mari decât dimensiunea specificată
$listaFisiere = Get-ChildItem -Path $directorSursa -File | Where-Object { $_.Length -gt $dimensiuneMinimaBytes }

# Verificăm dacă există fișiere care trebuie mutate
if ($listaFisiere.Count -eq 0) {
    Write-Host "Nu s-au găsit fișiere mai mari de $dimensiuneMinimaMB MB în $directorSursa" -ForegroundColor Green
    exit
}

# Mutăm fișierele în directorul destinație
foreach ($fisier in $listaFisiere) {
    $caleNoua = Join-Path -Path $directorDestinatie -ChildPath $fisier.Name
    Move-Item -Path $fisier.FullName -Destination $caleNoua -Force
    Write-Host "Mutat: $($fisier.Name) → $directorDestinatie" -ForegroundColor Cyan
}

Write-Host "Toate fișierele mai mari de $dimensiuneMinimaMB MB au fost mutate în $directorDestinatie!" -ForegroundColor Green
