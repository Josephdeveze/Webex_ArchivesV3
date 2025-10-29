# Script de compilation amélioré pour Webex Archive Manager sur Windows
# Résout les problèmes de modules manquants (_socket, multiprocessing, etc.)

Write-Host "🚀 Compilation de Webex Archive Manager pour Windows..." -ForegroundColor Cyan
Write-Host ""

# Vérifier Python
Write-Host "🔍 Vérification de Python..." -ForegroundColor Yellow
try {
    $pythonVersion = python --version 2>&1
    Write-Host "✅ Python trouvé: $pythonVersion" -ForegroundColor Green
} catch {
    Write-Host "❌ Python n'est pas installé ou n'est pas dans le PATH" -ForegroundColor Red
    Write-Host "   Téléchargez Python depuis: https://www.python.org/downloads/" -ForegroundColor Yellow
    pause
    exit 1
}

# Vérifier/Installer les dépendances
Write-Host ""
Write-Host "📦 Installation/Mise à jour des dépendances..." -ForegroundColor Yellow
python -m pip install --upgrade pip
python -m pip install --upgrade PyQt6 requests pyinstaller

# Nettoyer les anciens builds
Write-Host ""
Write-Host "🧹 Nettoyage des anciens builds..." -ForegroundColor Yellow
if (Test-Path "build") {
    Remove-Item -Recurse -Force "build"
    Write-Host "   ✓ Dossier 'build' supprimé" -ForegroundColor Gray
}
if (Test-Path "dist") {
    Remove-Item -Recurse -Force "dist"
    Write-Host "   ✓ Dossier 'dist' supprimé" -ForegroundColor Gray
}

# Compiler avec PyInstaller
Write-Host ""
Write-Host "⚙️  Compilation avec PyInstaller..." -ForegroundColor Yellow
Write-Host "   (Cela peut prendre quelques minutes...)" -ForegroundColor Gray
Write-Host ""

$specFile = "Webex Archive Manager.spec"

if (Test-Path $specFile) {
    # Utiliser le fichier .spec mis à jour
    pyinstaller --clean --noconfirm $specFile
} else {
    Write-Host "❌ Fichier .spec non trouvé!" -ForegroundColor Red
    pause
    exit 1
}

# Vérifier le résultat
Write-Host ""
if (Test-Path "dist\Webex Archive Manager\Webex Archive Manager.exe") {
    Write-Host "✅ Compilation terminée avec succès!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📁 L'application se trouve dans:" -ForegroundColor Cyan
    Write-Host "   $(Resolve-Path 'dist\Webex Archive Manager')" -ForegroundColor White
    Write-Host ""
    Write-Host "📋 Instructions de distribution:" -ForegroundColor Yellow
    Write-Host "   1. Compressez le dossier 'dist\Webex Archive Manager' en ZIP" -ForegroundColor White
    Write-Host "   2. Envoyez le fichier ZIP à vos utilisateurs" -ForegroundColor White
    Write-Host "   3. Les utilisateurs doivent décompresser et lancer 'Webex Archive Manager.exe'" -ForegroundColor White
    Write-Host ""
    Write-Host "⚠️  Note: Windows Defender peut afficher un avertissement" -ForegroundColor Yellow
    Write-Host "   Solution: Cliquez sur 'Plus d'informations' puis 'Exécuter quand même'" -ForegroundColor White
    Write-Host ""
    
    # Tester l'exécutable
    Write-Host "🧪 Voulez-vous tester l'application maintenant? (O/N)" -ForegroundColor Cyan
    $test = Read-Host
    if ($test -eq "O" -or $test -eq "o") {
        Write-Host "🚀 Lancement de l'application..." -ForegroundColor Green
        Start-Process "dist\Webex Archive Manager\Webex Archive Manager.exe"
    }
} else {
    Write-Host "❌ Erreur: L'exécutable n'a pas été créé" -ForegroundColor Red
    Write-Host "   Vérifiez les messages d'erreur ci-dessus" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "Appuyez sur une touche pour fermer..." -ForegroundColor Gray
pause
