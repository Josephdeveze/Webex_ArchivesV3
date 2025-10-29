# Script PowerShell pour compiler Webex Archive Manager sur Windows
# Alternative au script batch pour les utilisateurs PowerShell

Write-Host "🚀 Compilation de Webex Archive Manager pour Windows..." -ForegroundColor Green

# Vérifier si Python est disponible
try {
    $pythonVersion = python --version 2>&1
    Write-Host "✅ Python trouvé: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Python n'est pas trouvé. Veuillez installer Python." -ForegroundColor Red
    Write-Host "   Téléchargez depuis: https://www.python.org/downloads/" -ForegroundColor Yellow
    Read-Host "Appuyez sur Entrée pour quitter"
    exit 1
}

# Vérifier si Git Bash est disponible
try {
    $bashVersion = bash --version 2>&1
    Write-Host "✅ Git Bash trouvé" -ForegroundColor Green
} catch {
    Write-Host "❌ Git Bash n'est pas trouvé. Veuillez installer Git for Windows." -ForegroundColor Red
    Write-Host "   Téléchargez depuis: https://git-scm.com/download/win" -ForegroundColor Yellow
    Read-Host "Appuyez sur Entrée pour quitter"
    exit 1
}

# Vérifier si l'environnement virtuel existe
if (Test-Path ".venv") {
    Write-Host "✅ Environnement virtuel trouvé" -ForegroundColor Green
} else {
    Write-Host "⚠️  Environnement virtuel non trouvé. Création..." -ForegroundColor Yellow
    python -m venv .venv
    Write-Host "✅ Environnement virtuel créé" -ForegroundColor Green
}

# Activer l'environnement virtuel
Write-Host "🔄 Activation de l'environnement virtuel..." -ForegroundColor Cyan
& ".venv\Scripts\Activate.ps1"

# Installer les dépendances
Write-Host "📦 Installation des dépendances..." -ForegroundColor Cyan
pip install -r requirements.txt

# Exécuter le script bash universel
Write-Host "📋 Exécution du script de compilation..." -ForegroundColor Cyan
bash build_universal.sh

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ Compilation terminée avec succès!" -ForegroundColor Green
    Write-Host "📁 Ouvrez le dossier 'dist' pour voir votre application." -ForegroundColor Cyan
    Write-Host ""
    Write-Host "🪟 Instructions pour Windows:" -ForegroundColor Yellow
    Write-Host "1. Compressez le dossier 'dist\Webex Archive Manager' en ZIP" -ForegroundColor White
    Write-Host "2. Partagez le fichier ZIP avec les utilisateurs" -ForegroundColor White
    Write-Host "3. Les utilisateurs devront décompresser et exécuter 'Webex Archive Manager.exe'" -ForegroundColor White
    Write-Host "4. Windows peut afficher un avertissement - cliquez sur 'Plus d'informations' puis 'Exécuter quand même'" -ForegroundColor White
} else {
    Write-Host "❌ Erreur lors de la compilation" -ForegroundColor Red
}

Read-Host "Appuyez sur Entrée pour quitter"
