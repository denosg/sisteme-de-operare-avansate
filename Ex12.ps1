#Scrieți un script PowerShell care să creeze un fișier de tip CSV și să îl completeze cu informații despre 
#toate fișierele dintr-un director, inclusiv numele fișierului, dimensiunea și data creării.
param (
    [string]$director,
    [string]$caleFisierCSV
)

# Verificăm dacă directorul există
if (-Not (Test-Path $director)) {
    Write-Output "Directorul specificat nu există."
    exit
}

# Obținem toate fișierele din director
$fișiere = Get-ChildItem -Path $director -File

# Creăm o listă cu informațiile fișierelor
$informațiiFișiere = $fișiere | Select-Object Name, @{Name="Dimensiune (MB)"; Expression={($_.Length / 1MB).ToString("F2")}}, CreationTime

# Exportăm informațiile într-un fișier CSV nou
$informațiiFișiere | Export-Csv -Path $caleFisierCSV -NoTypeInformation

Write-Output "Fișierul CSV a fost creat și completat cu informațiile fișierelor din director: $caleFisierCSV"

