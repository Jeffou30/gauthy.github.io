# Dossier source à sauvegarder
$sourceFolder = "D:\"

# Chemin local temporaire pour compression
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$backupName = "Backup_D_$timestamp.zip"
$backupPath = "C:\Backup\$backupName"

# Dossier distant Google Drive via rclone (préconfiguré comme "gdrive")
$remoteFolder = "gdrive:Sauvegardes/Serveur"

# Créer les dossiers locaux si nécessaires
if (!(Test-Path "C:\Backup")) {
    New-Item -Path "C:\Backup" -ItemType Directory | Out-Null
}
if (!(Test-Path "C:\Logs")) {
    New-Item -Path "C:\Logs" -ItemType Directory | Out-Null
}

# Fichier de log
$logFile = "C:\Logs\sauvegarde_drive.log"
Add-Content $logFile "`n=== Sauvegarde du $timestamp ==="

try {
    # Compression
    Compress-Archive -Path "$sourceFolder\*" -DestinationPath $backupPath -Force

    # Envoi vers Google Drive
    & rclone copy "$backupPath" $remoteFolder --progress

    Add-Content $logFile "✅ Sauvegarde réussie à $(Get-Date)"
}
catch {
    Add-Content $logFile "❌ Erreur pendant la sauvegarde : $_"
}