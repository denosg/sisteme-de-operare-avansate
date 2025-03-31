# Scrieți un script PowerShell care să caute toate fișierele dintr-un director și să le copieze
# într-un alt director.

param (
    [string]$directorSursa,
    [string]$directorDestinatie
)

# Verificăm dacă directorul sursă există
if (-Not (Test-Path $directorSursa)) {
    Write-Output "Directorul sursă nu există."
    exit
}

# Verificăm dacă directorul destinație există, dacă nu, îl creăm
if (-Not (Test-Path $directorDestinatie)) {
    Write-Output "Directorul destinație nu există. Se va crea..."
    New-Item -Path $directorDestinatie -ItemType Directory
}

# Obținem toate fișierele din directorul sursă
$fișiere = Get-ChildItem -Path $directorSursa -File

# Copiem fiecare fișier în directorul destinație
foreach ($fișier in $fișiere) {
    $caleDestinatie = Join-Path -Path $directorDestinatie -ChildPath $fișier.Name
    Copy-Item -Path $fișier.FullName -Destination $caleDestinatie
    Write-Output "Fișierul '$($fișier.Name)' a fost copiat în '$directorDestinatie'."
}



#.\Ex4.ps1 -directorSursa "C:\Users\cti22d102\Desktop\Powershell-2" -directorDestinatie "C:\Users\cti22d102\Desktop\SOA"