#!/bin/bash

# Script de compilation universel pour Webex Archive Manager
# Supporte macOS et Windows (via WSL ou Git Bash)

echo "🚀 Compilation de Webex Archive Manager..."

# Détecter la plateforme
if [[ "$OSTYPE" == "darwin"* ]]; then
    PLATFORM="macos"
    echo "📱 Plateforme détectée: macOS"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "win32" ]]; then
    PLATFORM="windows"
    echo "🪟 Plateforme détectée: Windows"
else
    PLATFORM="linux"
    echo "🐧 Plateforme détectée: Linux"
fi

# Vérifier que l'environnement virtuel est activé
if [[ "$VIRTUAL_ENV" == "" ]]; then
    echo "⚠️  Veuillez activer l'environnement virtuel d'abord:"
    if [[ "$PLATFORM" == "windows" ]]; then
        echo "   source .venv/Scripts/activate"
    else
        echo "   source .venv/bin/activate"
    fi
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
if [[ "$PLATFORM" == "windows" ]]; then
    rm -rf ~/AppData/Local/pyinstaller/ 2>/dev/null || true
else
    rm -rf ~/.cache/pyinstaller/ ~/Library/Application\ Support/pyinstaller/ 2>/dev/null || true
fi

# Créer un dossier temporaire avec seulement les fichiers nécessaires
echo "📋 Préparation des fichiers..."
mkdir -p "temp_webex_archive"
cp "Webex Archive/webex-space-archive.py" "temp_webex_archive/"
cp "Webex Archive/generate_space_batch.py" "temp_webex_archive/"
cp "Webex Archive/README.md" "temp_webex_archive/"
if [ -f "Webex Archive/webexspacearchive-config.ini" ]; then
    cp "Webex Archive/webexspacearchive-config.ini" "temp_webex_archive/"
fi

# Configurer les options PyInstaller selon la plateforme
if [[ "$PLATFORM" == "macos" ]]; then
    echo "🍎 Configuration pour macOS..."
    PYINSTALLER_OPTS=(
        "--name=Webex Archive Manager"
        "--onedir"
        "--noconsole"
        "--windowed"
        "--add-data=temp_webex_archive:Webex Archive"
        "--hidden-import=PyQt6"
        "--hidden-import=PyQt6.QtCore"
        "--hidden-import=PyQt6.QtGui"
        "--hidden-import=PyQt6.QtWidgets"
        "--hidden-import=PyQt6.QtNetwork"
        "--hidden-import=requests"
        "--hidden-import=urllib3"
        "--hidden-import=certifi"
        "--hidden-import=charset_normalizer"
        "--hidden-import=idna"
        "--hidden-import=json"
        "--hidden-import=subprocess"
        "--hidden-import=configparser"
        "--collect-all=requests"
        "--collect-all=urllib3"
        "--collect-all=certifi"
        "--collect-all=charset_normalizer"
        "--collect-all=idna"
        "--collect-all=PyQt6"
        "--copy-metadata=PyQt6"
        "--copy-metadata=requests"
        "--copy-metadata=urllib3"
        "--copy-metadata=certifi"
        "--clean"
        "--strip"
    )
elif [[ "$PLATFORM" == "windows" ]]; then
    echo "🪟 Configuration pour Windows..."
    PYINSTALLER_OPTS=(
        "--name=Webex Archive Manager"
        "--onedir"
        "--noconsole"
        "--windowed"
        "--add-data=temp_webex_archive;Webex Archive"
        "--hidden-import=PyQt6"
        "--hidden-import=PyQt6.QtCore"
        "--hidden-import=PyQt6.QtGui"
        "--hidden-import=PyQt6.QtWidgets"
        "--hidden-import=PyQt6.QtNetwork"
        "--hidden-import=requests"
        "--hidden-import=urllib3"
        "--hidden-import=certifi"
        "--hidden-import=charset_normalizer"
        "--hidden-import=idna"
        "--hidden-import=json"
        "--hidden-import=subprocess"
        "--hidden-import=configparser"
        "--collect-all=requests"
        "--collect-all=urllib3"
        "--collect-all=certifi"
        "--collect-all=charset_normalizer"
        "--collect-all=idna"
        "--collect-all=PyQt6"
        "--copy-metadata=PyQt6"
        "--copy-metadata=requests"
        "--copy-metadata=urllib3"
        "--copy-metadata=certifi"
        "--clean"
        "--strip"
    )
else
    echo "🐧 Configuration pour Linux..."
    PYINSTALLER_OPTS=(
        "--name=Webex Archive Manager"
        "--onedir"
        "--noconsole"
        "--windowed"
        "--add-data=temp_webex_archive:Webex Archive"
        "--hidden-import=PyQt6"
        "--hidden-import=PyQt6.QtCore"
        "--hidden-import=PyQt6.QtGui"
        "--hidden-import=PyQt6.QtWidgets"
        "--hidden-import=PyQt6.QtNetwork"
        "--hidden-import=requests"
        "--hidden-import=urllib3"
        "--hidden-import=certifi"
        "--hidden-import=charset_normalizer"
        "--hidden-import=idna"
        "--hidden-import=json"
        "--hidden-import=subprocess"
        "--hidden-import=configparser"
        "--collect-all=requests"
        "--collect-all=urllib3"
        "--collect-all=certifi"
        "--collect-all=charset_normalizer"
        "--collect-all=idna"
        "--collect-all=PyQt6"
        "--copy-metadata=PyQt6"
        "--copy-metadata=requests"
        "--copy-metadata=urllib3"
        "--copy-metadata=certifi"
        "--clean"
        "--strip"
    )
fi

# Compiler l'application
echo "⚙️  Compilation en cours..."
pyinstaller "${PYINSTALLER_OPTS[@]}" webex_gui.py

# Nettoyer le dossier temporaire
rm -rf "temp_webex_archive"

# Vérifier le succès
if [ -d "dist/Webex Archive Manager" ]; then
    echo "✅ Compilation réussie!"
    echo "📁 L'application se trouve dans: dist/Webex Archive Manager/"
    echo ""
    
    if [[ "$PLATFORM" == "macos" ]]; then
        echo "🍎 Pour macOS:"
        echo "1. Compressez le dossier 'dist/Webex Archive Manager' en ZIP"
        echo "2. Les utilisateurs devront décompresser et double-cliquer sur 'Webex Archive Manager'"
        echo "3. Sur macOS, les utilisateurs devront peut-être autoriser l'application dans"
        echo "   Préférences Système > Sécurité et confidentialité"
    elif [[ "$PLATFORM" == "windows" ]]; then
        echo "🪟 Pour Windows:"
        echo "1. Compressez le dossier 'dist/Webex Archive Manager' en ZIP"
        echo "2. Les utilisateurs devront décompresser et double-cliquer sur 'Webex Archive Manager.exe'"
        echo "3. Windows peut afficher un avertissement de sécurité - les utilisateurs devront"
        echo "   cliquer sur 'Plus d'informations' puis 'Exécuter quand même'"
    else
        echo "🐧 Pour Linux:"
        echo "1. Compressez le dossier 'dist/Webex Archive Manager' en ZIP"
        echo "2. Les utilisateurs devront décompresser et exécuter './Webex Archive Manager'"
        echo "3. Assurez-vous que les dépendances système sont installées"
    fi
else
    echo "❌ Erreur lors de la compilation"
    exit 1
fi
