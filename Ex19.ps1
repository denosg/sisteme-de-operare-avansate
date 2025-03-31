#Scrieți un script PowerShell care să afișeze informații despre dispozitivele conectate la un sistem, inclusiv numele dispozitivului, tipul și adresa MAC.
# Obținem informații despre toate adaptoarele de rețea
$adaptoare = Get-NetAdapter

Write-Host "Dispozitivele de rețea conectate la sistem:"
Write-Host "-----------------------------------------"

# Parcurgem fiecare adaptor și afișăm informațiile relevante
$adaptoare | ForEach-Object {
    $numeDispozitiv = $_.Name
    $tipDispozitiv = $_.InterfaceDescription
    $adresaMAC = $_.MacAddress

    # Afișăm informațiile pentru fiecare dispozitiv de rețea
    Write-Host "Nume dispozitiv: $numeDispozitiv"
    Write-Host "Tip dispozitiv: $tipDispozitiv"
    Write-Host "Adresă MAC: $adresaMAC"
    Write-Host "-------------------------------"
}

# Obținem informații despre monitoare conectate
$monitoare = Get-WmiObject -Class Win32_DesktopMonitor

Write-Host "Monitoare conectate la sistem:"
Write-Host "--------------------------------"

$monitoare | ForEach-Object {
    $numeMonitor = $_.Name
    $statusMonitor = $_.Status
    $tipMonitor = $_.PNPDeviceID

    Write-Host "Nume Monitor: $numeMonitor"
    Write-Host "Status Monitor: $statusMonitor"
    Write-Host "Tip Monitor: $tipMonitor"
    Write-Host "-------------------------------"
}

# Obținem informații despre dispozitivele de tip HID (Mouse, Tastatură, etc.)
$dispozitiveHID = Get-WmiObject -Class Win32_PointingDevice

Write-Host "Dispozitive HID conectate la sistem (Mouse, Tastatură, etc.):"
Write-Host "--------------------------------------------------------"

$dispozitiveHID | ForEach-Object {
    $numeDispozitivHID = $_.Name
    $tipDispozitivHID = $_.DeviceID

    Write-Host "Nume dispozitiv: $numeDispozitivHID"
    Write-Host "Tip dispozitiv: $tipDispozitivHID"
    Write-Host "-------------------------------"
}

