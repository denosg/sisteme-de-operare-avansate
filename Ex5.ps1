# Scrieți un script PowerShell care să creeze un director nou și să mute toate fișierele cu o
# anumită extensie dintr-un director în noul director creat.

param (
    [string]$directorSursa,
    [string]$extensie,
    [string]$directorDestinatie
)

# Verificăm dacă directorul sursă există
if (-Not (Test-Path $directorSursa)) {
    Write-Output "Directorul sursă nu există."
    exit
}

# Verificăm dacă directorul destinație există. Dacă nu, îl creăm
if (-Not (Test-Path $directorDestinatie)) {
    Write-Output "Directorul destinație nu există. Se va crea..."
    New-Item -Path $directorDestinatie -ItemType Directory
}

# Creăm un subdirector în directorul destinație pentru fișierele cu extensia specificată
$subdirectorDestinatie = Join-Path -Path $directorDestinatie -ChildPath "$extensie`_fișiere"
if (-Not (Test-Path $subdirectorDestinatie)) {
    Write-Output "Crearea subdirectorului pentru fișierele cu extensia '$extensie'..."
    New-Item -Path $subdirectorDestinatie -ItemType Directory
}

# Obținem fișierele cu extensia specificată din directorul sursă
$fișiere = Get-ChildItem -Path $directorSursa -Filter "*.$extensie" -File

# Mutăm fișierele în subdirectorul destinație
foreach ($fișier in $fișiere) {
    $caleDestinatie = Join-Path -Path $subdirectorDestinatie -ChildPath $fișier.Name
    Move-Item -Path $fișier.FullName -Destination $caleDestinatie
    Write-Output "Fișierul '$($fișier.Name)' a fost mutat în '$subdirectorDestinatie'."
}

#.\Ex5.ps1 -directorSursa "C:\Users\cti22d102\Desktop\Powershell-2" -extensie "txt" -directorDestinatie "C:\Users\cti22d102\Desktop\SOA"

