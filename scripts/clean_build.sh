#!/bin/bash

# Script de nettoyage complet pour Webex Archive Manager
# Supprime tous les fichiers de build et de distribution

echo "🧹 Nettoyage complet des builds..."

# Supprimer tous les dossiers de build
echo "   Suppression des dossiers build/"
rm -rf build/

# Supprimer tous les dossiers de distribution
echo "   Suppression des dossiers dist/"
rm -rf dist/

# Supprimer les fichiers .spec
echo "   Suppression des fichiers .spec"
rm -f *.spec

# Supprimer les fichiers temporaires
echo "   Suppression des fichiers temporaires"
rm -rf temp_webex_archive/
rm -rf __pycache__/
rm -rf .pytest_cache/

# Supprimer les fichiers de cache PyInstaller
echo "   Suppression du cache PyInstaller"
rm -rf ~/.cache/pyinstaller/
rm -rf ~/Library/Application\ Support/pyinstaller/

echo "✅ Nettoyage terminé!"
echo ""
echo "Vous pouvez maintenant reconstruire l'application avec:"
echo "   ./build_app.sh"
