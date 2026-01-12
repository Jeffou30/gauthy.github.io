# Dossier source (celui que tu veux sauvegarder)
$sourceFolder = "D:\"

# Dossier de destination dans ton Google Drive (adapter si besoin)
$destinationFolder = "G:\Mon Drive\Sauvegardes\Serveur"

# Créer un dossier de log si besoin
if (!(Test-Path "C:\Logs")) {
    New-Item -Path "C:\Logs" -ItemType Directory | Out-Null
}

# Créer le dossier de destination s'il n'existe pas
if (!(Test-Path $destinationFolder)) {
    New-Item -Path $destinationFolder -ItemType Directory | Out-Null
}

# Lancer la copie
$logFile = "C:\Logs\sauvegarde_drive.log"
Add-Content $logFile "Début : $(Get-Date)"

try {
    Copy-Item -Path "$sourceFolder\*" -Destination $destinationFolder -Recurse -Force
    Add-Content $logFile "✅ Sauvegarde réussie à $(Get-Date)"
}
catch {
    Add-Content $logFile "❌ Erreur pendant la sauvegarde : $_"
}

Add-Content $logFile "Fin : $(Get-Date)`r`n"
