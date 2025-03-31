#Scrieți un script PowerShell care să genereze o parolă aleatoare cu o lungime dată ca parametru.

param (
    [int]$lungime
)

# Verificăm dacă lungimea este validă
if ($lungime -le 0) {
    Write-Output "Lungimea parolei trebuie să fie un număr pozitiv."
    exit
}

# Definim caracterele permise pentru parolă
$caractere = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+"

# Generăm parola aleatorie
$parola = -join ((1..$lungime) | ForEach-Object { $caractere | Get-Random })

# Afișăm parola generată
Write-Output "Parola generată: $parola"
