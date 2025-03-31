#Scrieți un script PowerShell care să trimită un email folosind SMTP, cu un subiect și un corp de mesaj date ca parametri.
param (
    [string]$destinatar = "exemplu@destinatar.com",
    [string]$subiect = "Subiect email",
    [string]$corp = "Acesta este corpul emailului.",
    [string]$expeditor = "exemplu@expeditor.com",
    [string]$smtpServer = "smtp.gmail.com",
    [int]$port = 587,
    [string]$username = "exemplu@expeditor.com",
    [string]$password = "parola"
)

# Creăm un obiect pentru autentificare SMTP
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ($username, $securePassword)

# Creăm obiectul email
$email = @{
    From       = $expeditor
    To         = $destinatar
    Subject    = $subiect
    Body       = $corp
    SmtpServer = $smtpServer
    Port       = $port
    UseSsl     = $true
    Credential = $cred
}

# Trimitem emailul
Send-MailMessage @email

Write-Output "Email trimis cu succes către $destinatar."
