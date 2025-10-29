#!/bin/bash

# Script pour préparer le repository GitHub pour distribution interne
# Inclut les fichiers compilés pour que les utilisateurs puissent télécharger directement

echo "🏢 Préparation du repository GitHub pour distribution interne..."

# Vérifier que nous sommes dans le bon dossier
if [ ! -f "webex_gui.py" ]; then
    echo "❌ Erreur: webex_gui.py non trouvé. Exécutez ce script depuis le dossier du projet."
    exit 1
fi

# Vérifier que l'application est compilée
if [ ! -d "dist/Webex Archive Manager" ]; then
    echo "❌ Erreur: Application non compilée. Exécutez d'abord ./build_universal.sh"
    exit 1
fi

# Créer un dossier temporaire pour le repository GitHub
echo "📁 Création du dossier GitHub..."
GITHUB_DIR="webex-archive-manager-internal"
rm -rf "$GITHUB_DIR"
mkdir -p "$GITHUB_DIR"/{macos,windows,docs,src,scripts}

# Copier l'application compilée macOS
echo "📦 Copie de l'application macOS..."
cp -r "dist/Webex Archive Manager" "$GITHUB_DIR/macos/"

# Copier le code source (optionnel, pour les développeurs)
echo "📋 Copie du code source..."
cp webex_gui.py "$GITHUB_DIR/src/"
cp main.py "$GITHUB_DIR/src/"
cp requirements.txt "$GITHUB_DIR/src/"

# Copier les scripts de compilation
echo "🔧 Copie des scripts de compilation..."
cp build_universal.sh "$GITHUB_DIR/scripts/"
cp build_app.sh "$GITHUB_DIR/scripts/"
cp build_windows.bat "$GITHUB_DIR/scripts/"
cp build_windows.ps1 "$GITHUB_DIR/scripts/"
cp clean_build.sh "$GITHUB_DIR/scripts/"

# Copier les scripts de test
cp test_portability.sh "$GITHUB_DIR/scripts/"
cp test_windows_gui.sh "$GITHUB_DIR/scripts/"
cp test_app.sh "$GITHUB_DIR/scripts/"

# Copier la documentation
echo "📚 Copie de la documentation..."
cp README.md "$GITHUB_DIR/docs/"
cp DISTRIBUTION.md "$GITHUB_DIR/docs/"
cp PORTABILITY_CONFIRMED.md "$GITHUB_DIR/docs/"
cp INTERNAL_DISTRIBUTION.md "$GITHUB_DIR/docs/"

# Copier le dossier Webex Archive
cp -r "Webex Archive" "$GITHUB_DIR/src/"

# Copier le .gitignore adapté
cp .gitignore "$GITHUB_DIR/"

# Créer un README principal pour les utilisateurs
echo "📝 Création du README principal..."
cat > "$GITHUB_DIR/README.md" << 'EOF'
# 🚀 Webex Archive Manager - Version Interne

Application portable pour archiver les espaces de messages Webex avec une interface graphique moderne.

## 📦 Téléchargement Rapide

### 🍎 macOS
1. **Téléchargez** le dossier `macos/Webex Archive Manager`
2. **Double-cliquez** sur `Webex Archive Manager`
3. **Autorisez** l'application dans Préférences Système si demandé

### 🪟 Windows
1. **Téléchargez** le dossier `windows/Webex Archive Manager`
2. **Double-cliquez** sur `Webex Archive Manager.exe`
3. **Cliquez** sur "Plus d'informations" puis "Exécuter quand même" si Windows bloque

## ✨ Fonctionnalités

- 📱 Interface graphique moderne
- 🔍 Recherche et filtrage des espaces
- 📦 Archivage en lot de plusieurs espaces
- 📁 Organisation automatique des fichiers téléchargés
- 🎨 Génération de fichiers HTML avec styles CSS
- 📊 Export optionnel en JSON
- 🔒 Support des tokens Webex sécurisés

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

## 📞 Support Interne

Pour toute question ou problème :
- Consultez la documentation dans le dossier `docs/`
- Contactez l'équipe IT interne
- Créez une issue sur ce repository

## 🔄 Mises à jour

Pour obtenir la dernière version :
1. **Téléchargez** la nouvelle version depuis ce repository
2. **Remplacez** l'ancienne version
3. **Relancez** l'application

## 📚 Documentation Technique

- `docs/README.md` - Documentation complète
- `docs/DISTRIBUTION.md` - Guide de distribution
- `docs/PORTABILITY_CONFIRMED.md` - Confirmation de portabilité
- `src/` - Code source (pour les développeurs)
- `scripts/` - Scripts de compilation et tests
EOF

# Créer un guide utilisateur simple
echo "📖 Création du guide utilisateur..."
cat > "$GITHUB_DIR/USER_GUIDE.md" << 'EOF'
# 📖 Guide Utilisateur - Webex Archive Manager

## 🚀 Démarrage Rapide

### 1. Téléchargement
- **macOS** : Téléchargez `macos/Webex Archive Manager`
- **Windows** : Téléchargez `windows/Webex Archive Manager`

### 2. Installation
- **Aucune installation requise** - L'application est portable
- **Décompressez** le dossier téléchargé
- **Lancez** l'application

### 3. Première utilisation
1. **Obtenez un token Webex** :
   - Allez sur [developer.webex.com](https://developer.webex.com)
   - Connectez-vous avec votre compte Webex
   - Créez un nouveau token
   - Copiez le token

2. **Configurez l'application** :
   - Lancez Webex Archive Manager
   - Collez votre token dans le champ "Token Webex"
   - Cliquez sur "Charger les espaces"

3. **Archivez vos espaces** :
   - Sélectionnez les espaces à archiver
   - Cliquez sur "Archiver la sélection"
   - Attendez la fin du processus

## 📁 Où trouver vos archives

Les archives sont créées dans un dossier `Webex Archives` à côté de l'application :
```
Webex Archive Manager/
├── Webex Archive Manager        # Application
└── Webex Archives/              # Dossier des archives
    ├── Espace 1/
    ├── Espace 2/
    └── ...
```

## ⚙️ Configuration avancée

### Options d'archivage
- **Télécharger les fichiers** : Oui/Non
- **Nombre maximum de messages** : 1000 par défaut
- **Trier les messages** : Plus récents en premier
- **Export JSON** : Optionnel

### Personnalisation
- Modifiez le fichier `webexspacearchive-config.ini` dans le dossier de l'application
- Redémarrez l'application pour appliquer les changements

## 🚨 Résolution de problèmes

### macOS
- **"Application endommagée"** : Autorisez dans Préférences Système > Sécurité
- **Permissions** : Assurez-vous que l'application a accès au réseau

### Windows
- **"Windows a protégé votre PC"** : Cliquez sur "Plus d'informations" puis "Exécuter quand même"
- **Antivirus** : Ajoutez l'application aux exceptions
- **Permissions** : Exécutez en tant qu'administrateur si nécessaire

### Problèmes courants
- **Token invalide** : Vérifiez que le token est correct et actif
- **Espace vide** : Certains espaces peuvent ne pas avoir de messages
- **Erreur réseau** : Vérifiez votre connexion internet

## 📞 Support

Pour toute question ou problème :
- Consultez ce guide
- Contactez l'équipe IT interne
- Créez une issue sur le repository
EOF

# Créer un fichier de version
echo "📋 Création du fichier de version..."
cat > "$GITHUB_DIR/VERSION.md" << 'EOF'
# 📋 Version et Changelog

## Version Actuelle : 1.0.0

### Fonctionnalités
- ✅ Interface graphique moderne avec PyQt6
- ✅ Archivage en lot de plusieurs espaces
- ✅ Téléchargement automatique des fichiers
- ✅ Génération de fichiers HTML avec styles CSS
- ✅ Export optionnel en JSON
- ✅ Application totalement portable
- ✅ Support macOS et Windows

### Améliorations récentes
- 🔧 Configuration PyInstaller optimisée
- 🔧 Scripts de compilation automatisés
- 🔧 Tests de portabilité intégrés
- 🔧 Documentation complète

### Prochaines versions
- 🔮 Support Linux
- 🔮 Interface de configuration avancée
- 🔮 Archivage programmé
- 🔮 Intégration avec d'autres outils

## Historique des versions

### v1.0.0 (2024-10-28)
- 🎉 Version initiale
- ✅ Interface graphique complète
- ✅ Archivage fonctionnel
- ✅ Portabilité confirmée
EOF

# Afficher la taille du dossier GitHub
echo "📊 Taille du repository GitHub préparé:"
du -sh "$GITHUB_DIR"

echo ""
echo "✅ Repository GitHub préparé pour distribution interne dans: $GITHUB_DIR"
echo ""
echo "📋 Structure créée:"
echo "   📁 macos/ - Application macOS"
echo "   📁 windows/ - Application Windows (à compiler)"
echo "   📁 docs/ - Documentation complète"
echo "   📁 src/ - Code source (pour les développeurs)"
echo "   📁 scripts/ - Scripts de compilation et tests"
echo "   📄 README.md - Guide principal"
echo "   📄 USER_GUIDE.md - Guide utilisateur"
echo "   📄 VERSION.md - Version et changelog"
echo ""
echo "📋 Prochaines étapes:"
echo "1. Créer un repository privé sur GitHub"
echo "2. Copier le contenu de '$GITHUB_DIR' dans le repository"
echo "3. Compiler l'application Windows et l'ajouter"
echo "4. Partager le repository avec les utilisateurs internes"
echo ""
echo "🎯 Avantages pour distribution interne:"
echo "   ✅ Téléchargement direct depuis GitHub"
echo "   ✅ Pas de releases à gérer"
echo "   ✅ Historique des versions"
echo "   ✅ Documentation centralisée"
echo "   ✅ Accès contrôlé (repository privé)"
