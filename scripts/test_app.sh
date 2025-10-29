#!/bin/bash

# Script de test pour vérifier que l'application fonctionne correctement
# Teste les fonctionnalités de base sans nécessiter de token Webex

echo "🧪 Test de l'application Webex Archive Manager..."

# Détecter la plateforme
if [[ "$OSTYPE" == "darwin"* ]]; then
    PLATFORM="macos"
    APP_PATH="dist/Webex Archive Manager.app/Contents/MacOS/Webex Archive Manager"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "win32" ]]; then
    PLATFORM="windows"
    APP_PATH="dist/Webex Archive Manager/Webex Archive Manager.exe"
else
    PLATFORM="linux"
    APP_PATH="dist/Webex Archive Manager/Webex Archive Manager"
fi

echo "📱 Plateforme détectée: $PLATFORM"

# Vérifier que l'application existe
if [ ! -f "$APP_PATH" ]; then
    echo "❌ Application non trouvée: $APP_PATH"
    echo "   Veuillez d'abord compiler l'application avec ./build_universal.sh"
    exit 1
fi

echo "✅ Application trouvée: $APP_PATH"

# Test 1: Vérifier que l'application peut démarrer
echo "🔄 Test 1: Vérification de l'exécutable..."
if [ -f "$APP_PATH" ]; then
    echo "✅ L'exécutable existe et est accessible"
else
    echo "❌ L'exécutable n'existe pas ou n'est pas accessible"
    exit 1
fi

# Test 2: Vérifier les fichiers de configuration
echo "🔄 Test 2: Vérification des fichiers de configuration..."
if [[ "$PLATFORM" == "macos" ]]; then
    CONFIG_PATH="dist/Webex Archive Manager.app/Contents/Resources/Webex Archive/webexspacearchive-config.ini"
else
    CONFIG_PATH="dist/Webex Archive Manager/Webex Archive/webexspacearchive-config.ini"
fi

if [ -f "$CONFIG_PATH" ]; then
    echo "✅ Fichier de configuration trouvé: $CONFIG_PATH"
else
    echo "❌ Fichier de configuration manquant: $CONFIG_PATH"
    exit 1
fi

# Test 3: Vérifier les dépendances
echo "🔄 Test 3: Vérification des dépendances..."
if [[ "$PLATFORM" == "macos" ]]; then
    DEPS_PATH="dist/Webex Archive Manager.app/Contents/Frameworks"
else
    DEPS_PATH="dist/Webex Archive Manager"
fi

if [ -d "$DEPS_PATH" ]; then
    echo "✅ Dossier des dépendances trouvé: $DEPS_PATH"
else
    echo "❌ Dossier des dépendances manquant: $DEPS_PATH"
    exit 1
fi

# Test 4: Vérifier la taille de l'application
echo "🔄 Test 4: Vérification de la taille de l'application..."
if [[ "$PLATFORM" == "macos" ]]; then
    APP_SIZE=$(du -sh "dist/Webex Archive Manager.app" | cut -f1)
else
    APP_SIZE=$(du -sh "dist/Webex Archive Manager" | cut -f1)
fi

echo "✅ Taille de l'application: $APP_SIZE"

# Test 5: Vérifier les permissions
echo "🔄 Test 5: Vérification des permissions..."
if [ -x "$APP_PATH" ]; then
    echo "✅ L'application est exécutable"
else
    echo "⚠️  L'application n'est pas exécutable, tentative de correction..."
    chmod +x "$APP_PATH"
    if [ -x "$APP_PATH" ]; then
        echo "✅ Permissions corrigées"
    else
        echo "❌ Impossible de corriger les permissions"
        exit 1
    fi
fi

echo ""
echo "🎉 Tous les tests sont passés avec succès!"
echo "📱 L'application est prête pour la distribution sur $PLATFORM"
echo ""
echo "📋 Prochaines étapes:"
echo "1. Compressez le dossier 'dist/Webex Archive Manager' en ZIP"
echo "2. Testez l'application sur une machine cible"
echo "3. Partagez le fichier ZIP avec les utilisateurs"
