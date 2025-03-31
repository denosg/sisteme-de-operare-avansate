# Scrieți un script PowerShell care să creeze un fișier de tip text cu un mesaj dat ca
# parametruparam (
    [string]$mesaj,
    [string]$caleFișier
)

# Verificăm dacă mesajul este valid
if ([string]::IsNullOrWhiteSpace($mesaj)) {
    Write-Output "Vă rugăm să furnizați un mesaj valid."
    exit
}

# Verificăm dacă calea fișierului a fost specificată
if ([string]::IsNullOrWhiteSpace($caleFișier)) {
    Write-Output "Vă rugăm să furnizați o cale validă pentru fișier."
    exit
}

# Creăm fișierul și scriem mesajul în el
$mesaj | Out-File -FilePath $caleFișier -Encoding UTF8

Write-Output "Fișierul a fost creat cu succes la: $caleFișier"


#.\Ex2.ps1 -mesaj "Acesta este un mesaj de test." -caleFișier "C:\Users\cti22d102\Desktop\Powershell-2\mesaj.txt"