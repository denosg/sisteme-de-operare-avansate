#Scrieți un script PowerShell care să caute și să înlocuiască un cuvânt dat ca parametru în toate fișierele dintr-un director.

param (
    [string]$director,
    [string]$cuvantCautat,
    [string]$cuvantInlocuit
)

# Verificăm dacă directorul există
if (-Not (Test-Path $director)) {
    Write-Output "Directorul specificat nu există."
    exit
}

# Obținem toate fișierele din director și subdirectoare
$fișiere = Get-ChildItem -Path $director -Recurse -File

foreach ($fișier in $fișiere) {
    # Citim conținutul fișierului
    $continut = Get-Content $fișier.FullName

    # Verificăm dacă cuvântul cautat există în fișier
    if ($continut -contains $cuvantCautat) {
        # Înlocuim cuvântul
        $continutNou = $continut -replace $cuvantCautat, $cuvantInlocuit

        # Scriem noul conținut în fișier
        Set-Content -Path $fișier.FullName -Value $continutNou

        Write-Output "Cuvântul '$cuvantCautat' a fost înlocuit cu '$cuvantInlocuit' în fișierul '$($fișier.FullName)'."
    }
}
