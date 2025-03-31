#Scrieți un script PowerShell care să descarce toate fișierele dintr-un director FTP și să le salveze într-un director local.
param (
    [string]$ftpServer = "ftp://exemplu.com/public_html",  # Adresa FTP
    [string]$utilizator = "username",                     # Nume utilizator FTP
    [string]$parola = "password",                         # Parola FTP
    [string]$directorLocal = "C:\FTP_Downloads"           # Directorul unde se descarcă fișierele
)

# Creăm directorul local dacă nu există
if (-Not (Test-Path $directorLocal)) {
    New-Item -ItemType Directory -Path $directorLocal | Out-Null
}

# Creăm o cerere WebClient pentru autentificare și descărcare
$webClient = New-Object System.Net.WebClient
$webClient.Credentials = New-Object System.Net.NetworkCredential($utilizator, $parola)

try {
    Write-Host "🔍 Se listează fișierele de pe serverul FTP..." -ForegroundColor Cyan
    
    # Obținem lista fișierelor
    $request = [System.Net.FtpWebRequest]::Create("$ftpServer/")
    $request.Credentials = $webClient.Credentials
    $request.Method = [System.Net.WebRequestMethods+Ftp]::ListDirectory
    $response = $request.GetResponse()
    $reader = New-Object System.IO.StreamReader $response.GetResponseStream()
    $fisiere = $reader.ReadToEnd().Split("`n") | Where-Object {$_ -ne ""}
    $reader.Close()
    $response.Close()

    # Descărcăm fiecare fișier
    foreach ($fisier in $fisiere) {
        $fisier = $fisier.Trim()
        if ($fisier -ne "") {
            $urlFisier = "$ftpServer/$fisier"
            $caleLocala = Join-Path -Path $directorLocal -ChildPath $fisier
            Write-Host "⬇️ Se descarcă: $fisier..." -ForegroundColor Yellow
            $webClient.DownloadFile($urlFisier, $caleLocala)
            Write-Host "✅ Descărcat: $caleLocala" -ForegroundColor Green
        }
    }
}
catch {
    Write-Host "❌ Eroare: $_" -ForegroundColor Red
}
finally {
    $webClient.Dispose()
}

