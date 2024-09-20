Set-ExecutionPolicy Bypass -Scope Process -Force

Write-Host `
" _____________________________________
|                                     |
|          Delete Script ESET         |
|      Endpoint Security + Agent      |
|                                     |
| (c) Drek_27                         |
|                                     |
 �������������������������������������" `
-ForegroundColor Yellow

Write-Host "Uninstallation starting on the target computer..." -ForegroundColor Red

# Le mot de passe pour la désinstallation d'ESET Endpoint Security
$password = "VotreMotDePasseIci"  # Remplacez par le mot de passe réel

# Désinstallation silencieuse d'ESET Endpoint Security
$uninstall64 = gci "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "ESET Endpoint Security" } | select UninstallString

if ($uninstall64) {
    $uninstall64 = $uninstall64.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
    $uninstall64 = $uninstall64.Trim()
    Write-Host "Uninstalling ESET Endpoint Security..."
    start-process "msiexec.exe" -arg "/X $uninstall64 /qn /norestart password=$password" -Wait
}

# Désinstallation silencieuse d'ESET Management Agent
$uninstall64 = gci "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "ESET Management Agent" } | select UninstallString

if ($uninstall64) {
    $uninstall64 = $uninstall64.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
    $uninstall64 = $uninstall64.Trim()
    Write-Host "Uninstalling ESET Management Agent..."
    start-process "msiexec.exe" -arg "/X $uninstall64 /qn /norestart" -Wait
}

# Activation du pare-feu après la désinstallation
Set-NetFirewallProfile -Profile * -Enabled True

Write-Host "Deletion verification process ..."

# Vérification que les programmes sont désinstallés
$namelistappli = Get-WmiObject -Class Win32_Product | Select-Object -Property Name

if ($namelistappli -contains "Eset Management Agent" -or $namelistappli -contains "ESET Endpoint Security") {
    Write-Host "ESET products are not fully deleted" -BackgroundColor Black -ForegroundColor Green
} else {
    Write-Host "ESET products have been successfully uninstalled."
}
