@echo off
REM Script de compilation pour Webex Archive Manager (Windows)

echo Compilation de Webex Archive Manager...

REM Installer PyInstaller
echo Installation de PyInstaller...
pip install pyinstaller

REM Nettoyer les builds precedents
echo Nettoyage des builds precedents...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist
if exist "*.spec" del /q *.spec

REM Creer un dossier temporaire avec seulement les fichiers necessaires
echo Preparation des fichiers...
if exist temp_webex_archive rmdir /s /q temp_webex_archive
mkdir temp_webex_archive
copy "Webex Archive\webex-space-archive.py" "temp_webex_archive\"
copy "Webex Archive\generate_space_batch.py" "temp_webex_archive\"
copy "Webex Archive\README.md" "temp_webex_archive\"
if exist "Webex Archive\webexspacearchive-config.ini" copy "Webex Archive\webexspacearchive-config.ini" "temp_webex_archive\"

REM Compiler l'application
echo Compilation en cours...
pyinstaller --name="Webex Archive Manager" ^
    --onedir ^
    --noconsole ^
    --add-data="temp_webex_archive;Webex Archive" ^
    --hidden-import=PyQt6 ^
    --hidden-import=PyQt6.QtCore ^
    --hidden-import=PyQt6.QtGui ^
    --hidden-import=PyQt6.QtWidgets ^
    --hidden-import=requests ^
    --hidden-import=urllib3 ^
    --hidden-import=certifi ^
    --hidden-import=charset_normalizer ^
    --hidden-import=idna ^
    --hidden-import=json ^
    --hidden-import=subprocess ^
    --hidden-import=configparser ^
    --collect-all=requests ^
    --collect-all=urllib3 ^
    --collect-all=certifi ^
    --clean ^
    webex_gui.py

REM Nettoyer le dossier temporaire
rmdir /s /q temp_webex_archive

REM Verifier le succes
if exist "dist\Webex Archive Manager\Webex Archive Manager.exe" (
    echo Compilation reussie!
    echo L'application se trouve dans: dist\Webex Archive Manager\
    echo.
    echo Pour distribuer l'application:
    echo 1. Compressez le dossier 'dist\Webex Archive Manager' en ZIP
    echo 2. Les utilisateurs devront decompresser et double-cliquer sur 'Webex Archive Manager.exe'
) else (
    echo Erreur lors de la compilation
    exit /b 1
)

pause
