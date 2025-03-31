#Scrieți un script PowerShell care să creeze un fișier log și să înregistreze toate modificările făcute într-un director specificat.
param (
    [string]$director, # Schimbă calea directorului dacă e necesar
    [string]$logFile
)

# Verificăm dacă directorul există
if (-Not (Test-Path $director)) {
    Write-Output "Directorul specificat nu există. Se va crea..."
    New-Item -ItemType Directory -Path $director | Out-Null
}

# Verificăm dacă fișierul log există, dacă nu, îl creăm
if (-Not (Test-Path $logFile)) {
    New-Item -ItemType File -Path $logFile | Out-Null
}

Write-Output "Monitorizarea directorului: $director"
Write-Output "Log salvat în: $logFile"
Write-Output "Pentru a opri scriptul, folosește Ctrl + C"

# Inițializăm FileSystemWatcher
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $director
$watcher.IncludeSubdirectories = $true
$watcher.EnableRaisingEvents = $true

# Funcție pentru scrierea în log
function Log-Modificare {
    param ($tip, $numeFisier)
    $timp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $mesaj = "$timp | [$tip] $numeFisier"

    # Scriem în fișierul log
    try {
        Add-Content -Path $logFile -Value $mesaj
    } catch {
        Write-Host "Eroare la scrierea în fișierul log: $_" -ForegroundColor Red
    }

    # Afișăm în consolă
    Write-Host $mesaj -ForegroundColor Yellow
}

# Evenimente monitorizate
$onCreated = Register-ObjectEvent $watcher "Created" -Action {
    Log-Modificare "Adăugat" $Event.SourceEventArgs.FullPath
}
$onDeleted = Register-ObjectEvent $watcher "Deleted" -Action {
    Log-Modificare "Șters" $Event.SourceEventArgs.FullPath
}
$onChanged = Register-ObjectEvent $watcher "Changed" -Action {
    Log-Modificare "Modificat" $Event.SourceEventArgs.FullPath
}
$onRenamed = Register-ObjectEvent $watcher "Renamed" -Action {
    Log-Modificare "Redenumit" "$($Event.SourceEventArgs.OldFullPath) -> $($Event.SourceEventArgs.FullPath)"
}

# Menținerea rulării scriptului
while ($true) {
    Start-Sleep -Seconds 1
}

