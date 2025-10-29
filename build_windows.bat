@echo off
REM Script de compilation pour Webex Archive Manager sur Windows
REM Utilise Git Bash ou WSL pour exécuter le script bash

echo 🚀 Compilation de Webex Archive Manager pour Windows...

REM Vérifier si Git Bash est disponible
where bash >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ Git Bash n'est pas trouvé. Veuillez installer Git for Windows.
    echo    Téléchargez depuis: https://git-scm.com/download/win
    pause
    exit /b 1
)

REM Vérifier si Python est disponible
python --version >nul 2>nul
if %errorlevel% neq 0 (
    echo ❌ Python n'est pas trouvé. Veuillez installer Python.
    echo    Téléchargez depuis: https://www.python.org/downloads/
    pause
    exit /b 1
)

REM Exécuter le script bash universel
echo 📋 Exécution du script de compilation...
bash build_universal.sh

if %errorlevel% equ 0 (
    echo.
    echo ✅ Compilation terminée avec succès!
    echo 📁 Ouvrez le dossier 'dist' pour voir votre application.
    echo.
    echo 🪟 Instructions pour Windows:
    echo 1. Compressez le dossier 'dist\Webex Archive Manager' en ZIP
    echo 2. Partagez le fichier ZIP avec les utilisateurs
    echo 3. Les utilisateurs devront décompresser et exécuter 'Webex Archive Manager.exe'
    echo 4. Windows peut afficher un avertissement - cliquez sur "Plus d'informations" puis "Exécuter quand même"
) else (
    echo ❌ Erreur lors de la compilation
)

pause
