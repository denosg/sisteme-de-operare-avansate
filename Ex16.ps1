#Scrieți un script PowerShell care să monitorizeze un director și să afișeze un mesaj atunci când se adaugă sau se șterge un fișier.
param (
    [string]$director
)

# Verificăm dacă directorul există
if (-Not (Test-Path $director)) {
    Write-Output "Directorul specificat nu există."
    exit
}

# Creăm un obiect FileSystemWatcher pentru monitorizarea directorului
$fsWatcher = New-Object IO.FileSystemWatcher
$fsWatcher.Path = $director
$fsWatcher.Filter = "*.*"  # Monitorizează toate fișierele

# Evenimentele de monitorizat
$fsWatcher.NotifyFilter = [IO.NotifyFilters]'FileName, LastWrite'

# Definirea acțiunilor care se vor întâmpla la adăugarea sau ștergerea unui fișier
$action = {
    $eventType = $Event.SourceEventArgs.ChangeType
    $filePath = $Event.SourceEventArgs.FullPath

    if ($eventType -eq 'Created') {
        Write-Host "`nFișierul '$filePath' a fost $eventType." -ForegroundColor Green
    }
    elseif ($eventType -eq 'Deleted') {
        Write-Host "`nFișierul '$filePath' a fost $eventType." -ForegroundColor Red
    }
}

# Înregistrăm evenimentele de creare și ștergere
Register-ObjectEvent -InputObject $fsWatcher -EventName 'Created' -Action $action
Register-ObjectEvent -InputObject $fsWatcher -EventName 'Deleted' -Action $action

# Pornim monitorizarea
$fsWatcher.EnableRaisingEvents = $true

Write-Host "Monitorizarea directorului $director a început. Apasă [Ctrl+C] pentru a opri."

# Scriptul va continua să ruleze și să monitorizeze evenimentele până când utilizatorul oprește scriptul manual.
while ($true) {
    Start-Sleep -Seconds 1
}


#.\Ex16.ps1 -director "D:\SOA\Powershell\Exercitii"

