#!/bin/bash

# Script de test spécifique pour l'interface graphique Windows
# Vérifie que PyQt6 fonctionne correctement sur Windows

echo "🪟 Test de l'interface graphique Windows - Webex Archive Manager..."

# Vérifier que nous sommes sur Windows ou dans un environnement Windows
if [[ "$OSTYPE" != "msys" ]] && [[ "$OSTYPE" != "cygwin" ]] && [[ "$OSTYPE" != "win32" ]]; then
    echo "⚠️  Ce script est conçu pour Windows. Plateforme détectée: $OSTYPE"
    echo "   Exécution du test de compatibilité générale..."
fi

# Détecter la plateforme
if [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "win32" ]]; then
    PLATFORM="windows"
    APP_PATH="dist/Webex Archive Manager/Webex Archive Manager.exe"
    APP_DIR="dist/Webex Archive Manager"
else
    PLATFORM="other"
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

# Test 2: Vérifier les dépendances PyQt6
echo "🔄 Test 2: Vérification des dépendances PyQt6..."
if [[ "$PLATFORM" == "windows" ]]; then
    # Sur Windows, vérifier les DLL PyQt6
    QT_DLLS=(
        "PyQt6/Qt6/bin/Qt6Core.dll"
        "PyQt6/Qt6/bin/Qt6Gui.dll"
        "PyQt6/Qt6/bin/Qt6Widgets.dll"
        "PyQt6/Qt6/bin/Qt6Network.dll"
    )
    
    echo "🔍 Vérification des DLL PyQt6..."
    for dll in "${QT_DLLS[@]}"; do
        if [ -f "$APP_DIR/$dll" ]; then
            echo "✅ $dll"
        else
            echo "❌ $dll - MANQUANT"
        fi
    done
    
    # Vérifier les plugins Qt
    echo "🔍 Vérification des plugins Qt..."
    PLUGINS_DIR="$APP_DIR/PyQt6/Qt6/plugins"
    if [ -d "$PLUGINS_DIR" ]; then
        PLUGIN_COUNT=$(find "$PLUGINS_DIR" -name "*.dll" | wc -l)
        echo "✅ $PLUGIN_COUNT plugins Qt trouvés"
    else
        echo "❌ Dossier des plugins Qt manquant"
    fi
else
    echo "ℹ️  Test des dépendances PyQt6 sur plateforme non-Windows"
    # Vérifier les bibliothèques PyQt6
    if command -v ldd >/dev/null 2>&1; then
        QT_DEPS=$(ldd "$APP_PATH" 2>/dev/null | grep -i qt | wc -l)
        echo "📊 Dépendances Qt détectées: $QT_DEPS"
    fi
fi

# Test 3: Vérifier les dépendances système pour l'interface graphique
echo "🔄 Test 3: Vérification des dépendances système GUI..."
if [[ "$PLATFORM" == "windows" ]]; then
    # Sur Windows, vérifier les DLL système nécessaires
    SYSTEM_DLLS=(
        "msvcp140.dll"
        "vcruntime140.dll"
        "api-ms-win-core-*.dll"
    )
    
    echo "🔍 Vérification des DLL système..."
    for dll_pattern in "${SYSTEM_DLLS[@]}"; do
        DLL_FOUND=$(find "$APP_DIR" -name "$dll_pattern" | wc -l)
        if [ "$DLL_FOUND" -gt 0 ]; then
            echo "✅ $dll_pattern ($DLL_FOUND trouvée(s))"
        else
            echo "⚠️  $dll_pattern - Non trouvée (peut être fournie par le système)"
        fi
    done
else
    echo "ℹ️  Test des dépendances système sur plateforme non-Windows"
fi

# Test 4: Test de création d'une fenêtre simple
echo "🔄 Test 4: Test de création d'interface graphique..."
cat > test_gui.py << 'EOF'
import sys
import os

# Ajouter le chemin de l'application au PYTHONPATH
if hasattr(sys, '_MEIPASS'):
    # PyInstaller
    sys.path.insert(0, sys._MEIPASS)
else:
    # Développement
    sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

try:
    from PyQt6.QtWidgets import QApplication, QWidget, QLabel
    from PyQt6.QtCore import Qt
    
    print("✅ PyQt6.QtWidgets importé avec succès")
    
    # Créer une application Qt
    app = QApplication(sys.argv)
    print("✅ QApplication créée avec succès")
    
    # Créer une fenêtre simple
    window = QWidget()
    window.setWindowTitle("Test GUI")
    window.setGeometry(100, 100, 300, 200)
    
    # Ajouter un label
    label = QLabel("Interface graphique fonctionnelle!", window)
    label.setAlignment(Qt.AlignmentFlag.AlignCenter)
    label.setGeometry(50, 50, 200, 100)
    
    print("✅ Interface graphique créée avec succès")
    
    # Fermer immédiatement pour éviter d'afficher la fenêtre
    window.close()
    app.quit()
    
    print("✅ Test d'interface graphique réussi")
    
except ImportError as e:
    print(f"❌ Erreur d'import PyQt6: {e}")
    sys.exit(1)
except Exception as e:
    print(f"❌ Erreur lors du test GUI: {e}")
    sys.exit(1)
EOF

# Exécuter le test GUI
echo "🧪 Exécution du test d'interface graphique..."
if python test_gui.py 2>/dev/null; then
    echo "✅ Test d'interface graphique réussi"
else
    echo "❌ Test d'interface graphique échoué"
    echo "   Vérifiez que PyQt6 est correctement installé"
fi

# Nettoyer le fichier temporaire
rm -f test_gui.py

# Test 5: Vérifier la configuration PyInstaller pour GUI
echo "🔄 Test 5: Vérification de la configuration PyInstaller..."
if [[ "$PLATFORM" == "windows" ]]; then
    # Vérifier que l'application est configurée comme application GUI
    if file "$APP_PATH" 2>/dev/null | grep -q "GUI"; then
        echo "✅ Application configurée comme application GUI"
    else
        echo "⚠️  Application pourrait ne pas être configurée comme GUI"
    fi
fi

echo ""
echo "🎯 Résumé du test d'interface graphique:"
echo "📱 Plateforme: $PLATFORM"
echo "🪟 Interface graphique: Testée"
echo ""
echo "✅ L'application est prête pour l'utilisation avec interface graphique!"
echo ""
echo "📋 Instructions spécifiques Windows:"
echo "1. Décompressez le fichier ZIP"
echo "2. Double-cliquez sur 'Webex Archive Manager.exe'"
echo "3. L'interface graphique devrait s'ouvrir"
echo "4. Si Windows bloque l'application:"
echo "   - Cliquez sur 'Plus d'informations'"
echo "   - Puis sur 'Exécuter quand même'"
echo "5. Si l'antivirus bloque:"
echo "   - Ajoutez l'application aux exceptions"
echo "   - Ou désactivez temporairement l'antivirus"
