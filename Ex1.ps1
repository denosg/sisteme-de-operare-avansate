# Scrieți un script PowerShell care să afișeze toate fișierele dintr-un director dat ca
# parametru, împreună cu dimensiunea lor în octeți

param (
    [string]$director
)

# Verificam daca directorul exista
if (Test-Path $director -PathType Container) {

    # Obtinem toate fișierele din directorul specificat
    $fișiere = Get-ChildItem -Path $director -File

    # Afișăm fișierele și dimensiunea acestora
    foreach ($fișier in $fișiere) {
        Write-Output "$($fișier.FullName) - $($fișier.Length) octeți"
    }

} else {
    Write-Output "Directorul specificat nu există."
}


#.\gg.ps1 -director "C:\Users\cti22d102\Desktop\SOA\Powershell"