#Scrieți un script PowerShell care să genereze un raport despre utilizarea discului pe toate unitățile disponibile.
# Obține toate unitățile de stocare disponibile
$discuri = Get-PSDrive -PSProvider FileSystem | Select-Object Name, Used, Free, @{Name="TotalSize";Expression={$_.Used + $_.Free}}

# Creare raport
$raport = @()
foreach ($disc in $discuri) {
    $utilizare = if ($disc.TotalSize -gt 0) { [math]::Round(($disc.Used / $disc.TotalSize) * 100, 2) } else { 0 }
    
    $raport += [PSCustomObject]@{
        "Unitate"   = $disc.Name
        "Dimensiune Totală (GB)" = "{0:N2}" -f ($disc.TotalSize / 1GB)
        "Spațiu Liber (GB)" = "{0:N2}" -f ($disc.Free / 1GB)
        "Utilizare (%)" = "$utilizare %"
    }
}

# Afișează raportul în consolă
$raport | Format-Table -AutoSize

# Salvează raportul într-un fișier CSV
$raport | Export-Csv -Path "$env:USERPROFILE\Desktop\RaportDiscuri.csv" -NoTypeInformation
Write-Output "Raportul a fost salvat pe Desktop: RaportDiscuri.csv"
