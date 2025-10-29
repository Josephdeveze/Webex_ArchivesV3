#!/bin/bash

# Script pour préparer le repository GitHub
# Exclut les fichiers générés et garde seulement le code source

echo "🚀 Préparation du repository GitHub pour Webex Archive Manager..."

# Vérifier que nous sommes dans le bon dossier
if [ ! -f "webex_gui.py" ]; then
    echo "❌ Erreur: webex_gui.py non trouvé. Exécutez ce script depuis le dossier du projet."
    exit 1
fi

# Créer un dossier temporaire pour le repository GitHub
echo "📁 Création du dossier GitHub..."
GITHUB_DIR="webex-archive-manager-github"
rm -rf "$GITHUB_DIR"
mkdir "$GITHUB_DIR"

# Copier les fichiers source
echo "📋 Copie des fichiers source..."
cp webex_gui.py "$GITHUB_DIR/"
cp main.py "$GITHUB_DIR/"
cp requirements.txt "$GITHUB_DIR/"
cp build_config.ini "$GITHUB_DIR/"

# Copier les scripts
cp build_universal.sh "$GITHUB_DIR/"
cp build_app.sh "$GITHUB_DIR/"
cp build_windows.bat "$GITHUB_DIR/"
cp build_windows.ps1 "$GITHUB_DIR/"
cp clean_build.sh "$GITHUB_DIR/"

# Copier les scripts de test
cp test_portability.sh "$GITHUB_DIR/"
cp test_windows_gui.sh "$GITHUB_DIR/"
cp test_app.sh "$GITHUB_DIR/"

# Copier la documentation
cp README.md "$GITHUB_DIR/"
cp DISTRIBUTION.md "$GITHUB_DIR/"
cp PORTABILITY_CONFIRMED.md "$GITHUB_DIR/"
cp GITHUB_STRUCTURE.md "$GITHUB_DIR/"
cp GITHUB_GUIDE.md "$GITHUB_DIR/"

# Copier le dossier Webex Archive
echo "📦 Copie du dossier Webex Archive..."
cp -r "Webex Archive" "$GITHUB_DIR/"

# Copier le .gitignore
cp .gitignore "$GITHUB_DIR/"

# Créer un README spécifique pour GitHub
echo "📝 Création du README GitHub..."
cat > "$GITHUB_DIR/README.md" << 'EOF'
# 🚀 Webex Archive Manager

Une application portable pour archiver les espaces de messages Webex avec une interface graphique moderne.

## 📦 Téléchargement

**Pour les utilisateurs finaux** : Téléchargez la dernière version depuis [Releases](https://github.com/votre-username/webex-archive-manager/releases)

**Pour les développeurs** : Voir la section [Développement](#développement)

## ✨ Fonctionnalités

- 📱 Interface graphique moderne avec PyQt6
- 🔍 Recherche et filtrage des espaces
- 📦 Archivage en lot de plusieurs espaces
- 📁 Organisation automatique des fichiers téléchargés
- 🎨 Génération de fichiers HTML avec styles CSS
- 📊 Export optionnel en JSON
- 🔒 Support des tokens Webex sécurisés

## 🖥️ Plateformes supportées

- ✅ **macOS** (Apple Silicon et Intel)
- ✅ **Windows** (10/11)
- ✅ **Linux** (Ubuntu, Debian, etc.)

## 🚀 Développement

### Prérequis
- Python 3.9+
- Git

### Installation
```bash
git clone https://github.com/votre-username/webex-archive-manager.git
cd webex-archive-manager
python -m venv .venv
source .venv/bin/activate  # macOS/Linux
# ou
.venv\Scripts\activate     # Windows
pip install -r requirements.txt
```

### Compilation
```bash
# Compilation universelle
./build_universal.sh

# Ou compilation spécifique
./build_app.sh           # macOS
bash build_universal.sh  # Windows avec Git Bash
```

## 🧪 Tests

```bash
# Test de portabilité
./test_portability.sh

# Test d'interface graphique
./test_windows_gui.sh

# Test général
./test_app.sh
```

## 📋 Utilisation

1. **Obtenez un token Webex** sur [developer.webex.com](https://developer.webex.com)
2. **Entrez votre token** dans l'interface
3. **Cliquez sur "Charger les espaces"**
4. **Sélectionnez** les espaces à archiver
5. **Cliquez sur "Archiver la sélection"**

## 📁 Structure des fichiers générés

```
Webex Archives/
├── Nom de l'espace 1/
│   ├── Nom de l'espace 1.html
│   ├── files/
│   │   └── fichiers téléchargés
│   └── images/
│       └── images téléchargées
└── ...
```

## 🔒 Sécurité

- Les tokens Webex sont stockés localement
- Les fichiers d'archive sont créés localement
- L'application ne collecte aucune donnée personnelle

## 📝 Licence

Ce projet utilise le script d'archivage Webex original sous licence Cisco Sample Code License, Version 1.1.

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :
- Signaler des bugs
- Proposer des améliorations
- Soumettre des pull requests

## 📞 Support

Pour toute question ou problème :
1. Vérifiez la section [Résolution de problèmes](DISTRIBUTION.md#résolution-de-problèmes)
2. Consultez les logs dans l'interface de l'application
3. Créez une issue sur le repository du projet
EOF

# Afficher la taille du dossier GitHub
echo "📊 Taille du repository GitHub préparé:"
du -sh "$GITHUB_DIR"

echo ""
echo "✅ Repository GitHub préparé dans: $GITHUB_DIR"
echo ""
echo "📋 Prochaines étapes:"
echo "1. Créer un nouveau repository sur GitHub"
echo "2. Copier le contenu de '$GITHUB_DIR' dans le repository"
echo "3. Créer des releases avec les fichiers compilés"
echo ""
echo "📁 Fichiers inclus:"
echo "   - Code source Python"
echo "   - Scripts de compilation"
echo "   - Scripts de test"
echo "   - Documentation complète"
echo "   - Configuration PyInstaller"
echo ""
echo "📁 Fichiers exclus:"
echo "   - dist/ (fichiers compilés)"
echo "   - build/ (fichiers de build)"
echo "   - .venv/ (environnement virtuel)"
echo "   - __pycache__/ (cache Python)"
echo ""
echo "🎯 Taille du repository: ~100KB (vs 227MB avec dist/)"
