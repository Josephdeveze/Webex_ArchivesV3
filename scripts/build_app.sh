#!/bin/bash

# Script de compilation pour Webex Archive Manager
# Crée un exécutable autonome pour macOS

echo "🚀 Compilation de Webex Archive Manager..."

# Vérifier que l'environnement virtuel est activé
if [[ "$VIRTUAL_ENV" == "" ]]; then
    echo "⚠️  Veuillez activer l'environnement virtuel d'abord:"
    echo "   source .venv/bin/activate"
    exit 1
fi

# Installer PyInstaller si nécessaire
echo "📦 Installation de PyInstaller..."
pip install pyinstaller

# Nettoyer les builds précédents
echo "🧹 Nettoyage des builds précédents..."
rm -rf build dist *.spec temp_webex_archive __pycache__ .pytest_cache

# Nettoyer aussi le cache PyInstaller pour être sûr
echo "🧹 Nettoyage du cache PyInstaller..."
rm -rf ~/.cache/pyinstaller/ ~/Library/Application\ Support/pyinstaller/ 2>/dev/null || true

# Créer un dossier temporaire avec seulement les fichiers nécessaires
echo "📋 Préparation des fichiers..."
mkdir -p "temp_webex_archive"
cp "Webex Archive/webex-space-archive.py" "temp_webex_archive/"
cp "Webex Archive/generate_space_batch.py" "temp_webex_archive/"
cp "Webex Archive/README.md" "temp_webex_archive/"
if [ -f "Webex Archive/webexspacearchive-config.ini" ]; then
    cp "Webex Archive/webexspacearchive-config.ini" "temp_webex_archive/"
fi

# Compiler l'application
echo "⚙️  Compilation en cours..."
pyinstaller --name="Webex Archive Manager" \
    --onedir \
    --noconsole \
    --add-data="temp_webex_archive:Webex Archive" \
    --hidden-import=PyQt6 \
    --hidden-import=PyQt6.QtCore \
    --hidden-import=PyQt6.QtGui \
    --hidden-import=PyQt6.QtWidgets \
    --hidden-import=requests \
    --hidden-import=urllib3 \
    --hidden-import=certifi \
    --hidden-import=charset_normalizer \
    --hidden-import=idna \
    --hidden-import=json \
    --hidden-import=subprocess \
    --hidden-import=configparser \
    --collect-all=requests \
    --collect-all=urllib3 \
    --collect-all=certifi \
    --clean \
    webex_gui.py

# Nettoyer le dossier temporaire
rm -rf "temp_webex_archive"

# Vérifier le succès
if [ -d "dist/Webex Archive Manager" ]; then
    echo "✅ Compilation réussie!"
    echo "📁 L'application se trouve dans: dist/Webex Archive Manager/"
    echo ""
    echo "Pour distribuer l'application:"
    echo "1. Compressez le dossier 'dist/Webex Archive Manager' en ZIP"
    echo "2. Les utilisateurs devront décompresser et double-cliquer sur 'Webex Archive Manager'"
    echo ""
    echo "Note: Sur macOS, les utilisateurs devront peut-être autoriser l'application dans"
    echo "      Préférences Système > Sécurité et confidentialité"
else
    echo "❌ Erreur lors de la compilation"
    exit 1
fi
