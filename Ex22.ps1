#Scrieți un script PowerShell care să monitorizeze utilizarea procesorului și să salveze datele într-un fișier CSV la fiecare 10 secunde.
param (
    [string]$caleFisierCSV
)

# Definim capul de tabel pentru fișierul CSV (dacă fișierul nu există)
if (-Not (Test-Path $caleFisierCSV)) {
    "Data,UtilizareProcesor" | Out-File -FilePath $caleFisierCSV
}

# Începem să monitorizăm utilizarea procesorului
while ($true) {
    # Obținem utilizarea procesorului
    $utilizareProcesor = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples[0].CookedValue

    # Obținem data și ora curentă
    $dataCurenta = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Salvăm datele într-un fișier CSV
    "$dataCurenta,$utilizareProcesor" | Out-File -FilePath $caleFisierCSV -Append

    # Așteptăm 10 secunde înainte de a repeta
    Start-Sleep -Seconds 10
}
