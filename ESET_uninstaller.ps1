Set-ExecutionPolicy Bypass -Scope Process -Force

Write-Host `
"______________________________________
|                                     |
|          Script de suppression      |
|      ESET Endpoint Security + Agent |
|                                     |
|        Développé par Cy6er-Guy      |
|                                     |
______________________________________ " `
-ForegroundColor Yellow

Write-Host "Démarrage de la désinstallation sur l'ordinateur cible..." -ForegroundColor Red

# Le mot de passe pour la désinstallation d'ESET Endpoint Security
$password = "VotreMotDePasseIci"  # Remplacez par le mot de passe réel

# Désinstallation silencieuse d'ESET Endpoint Security
$uninstall64 = gci "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "ESET Endpoint Security" } | select UninstallString

if ($uninstall64) {
    $uninstall64 = $uninstall64.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
    $uninstall64 = $uninstall64.Trim()
    Write-Host "Désinstallation d'ESET Endpoint Security en cours..."
    start-process "msiexec.exe" -arg "/X $uninstall64 /qn /norestart password=$password" -Wait
}

# Désinstallation silencieuse d'ESET Management Agent
$uninstall64 = gci "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -match "ESET Management Agent" } | select UninstallString

if ($uninstall64) {
    $uninstall64 = $uninstall64.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
    $uninstall64 = $uninstall64.Trim()
    Write-Host "Désinstallation d'ESET Management Agent en cours..."
    start-process "msiexec.exe" -arg "/X $uninstall64 /qn /norestart" -Wait
}

# Activation du pare-feu après la désinstallation
Set-NetFirewallProfile -Profile * -Enabled True

Write-Host "Processus de vérification de suppression en cours..."

# Vérification que les programmes sont désinstallés
$namelistappli = Get-WmiObject -Class Win32_Product | Select-Object -Property Name

if ($namelistappli -contains "Eset Management Agent" -or $namelistappli -contains "ESET Endpoint Security") {
    Write-Host "Les produits ESET ne sont pas complètement supprimés" -BackgroundColor Black -ForegroundColor Green
} else {
    Write-Host "Les produits ESET ont été désinstallés avec succès."
}
