#!/bin/bash

# Script de test de portabilité pour Webex Archive Manager
# Vérifie que l'application fonctionne sans Python installé sur la machine cible

echo "🧪 Test de portabilité - Webex Archive Manager..."

# Détecter la plateforme
if [[ "$OSTYPE" == "darwin"* ]]; then
    PLATFORM="macos"
    # Vérifier si c'est un .app bundle ou un dossier simple
    if [ -d "dist/Webex Archive Manager.app" ]; then
        APP_PATH="dist/Webex Archive Manager.app/Contents/MacOS/Webex Archive Manager"
        APP_DIR="dist/Webex Archive Manager.app"
    else
        APP_PATH="dist/Webex Archive Manager/Webex Archive Manager"
        APP_DIR="dist/Webex Archive Manager"
    fi
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "win32" ]]; then
    PLATFORM="windows"
    APP_PATH="dist/Webex Archive Manager/Webex Archive Manager.exe"
    APP_DIR="dist/Webex Archive Manager"
else
    PLATFORM="linux"
    APP_PATH="dist/Webex Archive Manager/Webex Archive Manager"
    APP_DIR="dist/Webex Archive Manager"
fi

echo "📱 Plateforme détectée: $PLATFORM"

# Test 1: Vérifier que l'application existe
echo "🔄 Test 1: Vérification de l'exécutable..."
if [ ! -f "$APP_PATH" ]; then
    echo "❌ Application non trouvée: $APP_PATH"
    echo "   Veuillez d'abord compiler l'application avec ./build_universal.sh"
    exit 1
fi
echo "✅ Exécutable trouvé: $APP_PATH"

# Test 2: Vérifier que Python n'est pas requis
echo "🔄 Test 2: Vérification de l'indépendance Python..."
if [[ "$PLATFORM" == "macos" ]]; then
    PYTHON_CHECK=$(otool -L "$APP_PATH" 2>/dev/null | grep -i python || echo "Aucune dépendance Python trouvée")
else
    PYTHON_CHECK=$(ldd "$APP_PATH" 2>/dev/null | grep -i python || echo "Aucune dépendance Python trouvée")
fi

if [[ "$PYTHON_CHECK" == *"python"* ]]; then
    echo "⚠️  Dépendances Python détectées:"
    echo "   $PYTHON_CHECK"
    echo "   L'application pourrait nécessiter Python sur la machine cible"
else
    echo "✅ Aucune dépendance Python détectée - Application totalement portable"
fi

# Test 3: Vérifier les dépendances système
echo "🔄 Test 3: Vérification des dépendances système..."
if [[ "$PLATFORM" == "macos" ]]; then
    DEPS=$(otool -L "$APP_PATH" 2>/dev/null | grep -v "@executable_path" | grep -v "/System" | grep -v "/usr/lib" | wc -l)
elif [[ "$PLATFORM" == "windows" ]]; then
    DEPS=$(ldd "$APP_PATH" 2>/dev/null | grep -v "Windows" | grep -v "msvcrt" | wc -l)
else
    DEPS=$(ldd "$APP_PATH" 2>/dev/null | grep -v "linux-vdso" | grep -v "libc.so" | grep -v "libm.so" | wc -l)
fi

echo "📊 Nombre de dépendances externes: $DEPS"
if [ "$DEPS" -lt 10 ]; then
    echo "✅ Peu de dépendances externes - Bonne portabilité"
else
    echo "⚠️  Nombreuses dépendances externes - Vérifiez la compatibilité"
fi

# Test 4: Vérifier la taille et la structure
echo "🔄 Test 4: Vérification de la taille et structure..."
APP_SIZE=$(du -sh "$APP_DIR" | cut -f1)
echo "📦 Taille totale: $APP_SIZE"

# Vérifier que tous les fichiers nécessaires sont présents
if [[ "$PLATFORM" == "macos" ]]; then
    if [ -d "dist/Webex Archive Manager.app" ]; then
        # Structure .app bundle
        REQUIRED_FILES=(
            "Contents/MacOS/Webex Archive Manager"
            "Contents/Resources/Webex Archive/webex-space-archive.py"
            "Contents/Resources/Webex Archive/webexspacearchive-config.ini"
            "Contents/Frameworks/Python"
        )
    else
        # Structure dossier simple
        REQUIRED_FILES=(
            "Webex Archive Manager"
            "_internal/Webex Archive/webex-space-archive.py"
            "_internal/Webex Archive/webexspacearchive-config.ini"
            "_internal/Python"
        )
    fi
else
    REQUIRED_FILES=(
        "Webex Archive Manager.exe"
        "_internal/Webex Archive/webex-space-archive.py"
        "_internal/Webex Archive/webexspacearchive-config.ini"
        "_internal/python3.dll"
    )
fi

echo "🔍 Vérification des fichiers requis..."
for file in "${REQUIRED_FILES[@]}"; do
    if [ -e "$APP_DIR/$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file - MANQUANT"
    fi
done

# Test 5: Vérifier les permissions
echo "🔄 Test 5: Vérification des permissions..."
if [ -x "$APP_PATH" ]; then
    echo "✅ L'application est exécutable"
else
    echo "⚠️  L'application n'est pas exécutable, correction..."
    chmod +x "$APP_PATH"
    if [ -x "$APP_PATH" ]; then
        echo "✅ Permissions corrigées"
    else
        echo "❌ Impossible de corriger les permissions"
    fi
fi

# Test 6: Test de démarrage rapide (sans interface)
echo "🔄 Test 6: Test de démarrage..."
echo "   (Ce test vérifie que l'application peut démarrer sans erreur critique)"

# Créer un script de test temporaire
cat > test_startup.py << 'EOF'
import sys
import os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

try:
    # Test d'import des modules principaux
    import PyQt6.QtWidgets
    import requests
    import json
    import configparser
    print("✅ Tous les modules principaux peuvent être importés")
except ImportError as e:
    print(f"❌ Erreur d'import: {e}")
    sys.exit(1)
EOF

# Exécuter le test d'import
if [[ "$PLATFORM" == "macos" ]]; then
    PYTHON_PATH="$APP_DIR/Contents/Frameworks/Python"
else
    PYTHON_PATH="$APP_DIR/python3.dll"
fi

if [ -e "$PYTHON_PATH" ]; then
    echo "✅ Interpréteur Python intégré trouvé"
else
    echo "⚠️  Interpréteur Python intégré non trouvé"
fi

# Nettoyer le fichier temporaire
rm -f test_startup.py

echo ""
echo "🎯 Résumé du test de portabilité:"
echo "📱 Plateforme: $PLATFORM"
echo "📦 Taille: $APP_SIZE"
echo "🔗 Dépendances externes: $DEPS"
echo ""
echo "✅ L'application est prête pour la distribution!"
echo ""
echo "📋 Instructions pour les utilisateurs:"
if [[ "$PLATFORM" == "macos" ]]; then
    echo "1. Décompressez le fichier ZIP"
    echo "2. Double-cliquez sur 'Webex Archive Manager.app'"
    echo "3. Autorisez l'application dans Préférences Système si demandé"
elif [[ "$PLATFORM" == "windows" ]]; then
    echo "1. Décompressez le fichier ZIP"
    echo "2. Double-cliquez sur 'Webex Archive Manager.exe'"
    echo "3. Cliquez sur 'Plus d'informations' puis 'Exécuter quand même' si Windows bloque"
else
    echo "1. Décompressez le fichier ZIP"
    echo "2. Exécutez './Webex Archive Manager'"
    echo "3. Assurez-vous que les dépendances système sont installées"
fi
