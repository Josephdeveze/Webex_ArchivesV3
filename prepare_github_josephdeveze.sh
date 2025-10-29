#!/bin/bash

# Script pour préparer le repository GitHub spécifique
# Repository: https://github.com/Josephdeveze/Webex_Archives

echo "🚀 Préparation du repository GitHub pour Webex_Archives..."
echo "📁 Repository: https://github.com/Josephdeveze/Webex_Archives"

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
GITHUB_DIR="Webex_Archives"
rm -rf "$GITHUB_DIR"
mkdir -p "$GITHUB_DIR"/{macos,windows,docs,src,scripts}

# Copier l'application compilée macOS
echo "📦 Copie de l'application macOS..."
cp -r "dist/Webex Archive Manager" "$GITHUB_DIR/macos/"

# Copier le code source
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
cp FINAL_INTERNAL_GUIDE.md "$GITHUB_DIR/docs/"

# Copier le dossier Webex Archive
cp -r "Webex Archive" "$GITHUB_DIR/src/"

# Copier le .gitignore adapté
cp .gitignore "$GITHUB_DIR/"

# Créer le README principal
echo "📝 Création du README principal..."
cp README_GITHUB.md "$GITHUB_DIR/README.md"

# Créer un guide utilisateur spécifique
echo "📖 Création du guide utilisateur..."
cat > "$GITHUB_DIR/USER_GUIDE.md" << 'EOF'
# 📖 Guide Utilisateur - Webex Archives

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
- 🔧 Repository GitHub organisé

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
- ✅ Repository GitHub créé
EOF

# Créer un fichier de contribution
echo "📝 Création du guide de contribution..."
cat > "$GITHUB_DIR/CONTRIBUTING.md" << 'EOF'
# 🤝 Guide de Contribution

## 🚀 Comment contribuer

### 1. Fork du repository
1. Forkez le repository sur GitHub
2. Clonez votre fork localement
3. Créez une branche pour votre fonctionnalité

### 2. Développement
```bash
# Cloner le repository
git clone https://github.com/votre-username/Webex_Archives.git
cd Webex_Archives

# Créer un environnement virtuel
python -m venv .venv
source .venv/bin/activate  # macOS/Linux
# ou
.venv\Scripts\activate     # Windows

# Installer les dépendances
pip install -r src/requirements.txt

# Compiler l'application
./scripts/build_universal.sh

# Tester
./scripts/test_portability.sh
```

### 3. Tests
- Exécutez les tests de portabilité
- Testez sur votre plateforme
- Vérifiez que l'interface graphique fonctionne

### 4. Soumission
1. Committez vos changements
2. Poussez vers votre fork
3. Créez une Pull Request

## 📋 Standards de code

### Python
- Utilisez des noms de variables explicites
- Commentez le code complexe
- Respectez PEP 8

### Documentation
- Mettez à jour la documentation
- Ajoutez des exemples d'utilisation
- Documentez les nouvelles fonctionnalités

## 🐛 Signaler des bugs

### Informations à fournir
- Version de l'application
- Plateforme (macOS/Windows)
- Étapes pour reproduire
- Logs d'erreur
- Capture d'écran si applicable

### Template de bug report
```markdown
## Description
Description claire du problème

## Étapes pour reproduire
1. Aller à '...'
2. Cliquer sur '...'
3. Voir l'erreur

## Comportement attendu
Description du comportement attendu

## Informations système
- OS: macOS/Windows
- Version: 1.0.0
- Python: 3.x

## Logs
Coller les logs d'erreur ici
```

## 💡 Proposer des améliorations

### Informations à fournir
- Description de l'amélioration
- Cas d'usage
- Avantages
- Implémentation suggérée

## 📞 Contact

Pour toute question sur la contribution :
- Créez une issue sur GitHub
- Contactez l'équipe de développement
- Rejoignez les discussions

## 📝 Licence

En contribuant, vous acceptez que votre code soit sous la même licence que le projet.
EOF

# Créer un fichier de sécurité
echo "🔒 Création du guide de sécurité..."
cat > "$GITHUB_DIR/SECURITY.md" << 'EOF'
# 🔒 Politique de Sécurité

## 🛡️ Sécurité de l'application

### Données locales
- Les tokens Webex sont stockés localement sur votre machine
- Les fichiers d'archive sont créés localement
- Aucune donnée n'est transmise à des serveurs externes

### Token Webex
- Le token est utilisé uniquement pour accéder à l'API Webex
- Le token n'est pas stocké de manière permanente
- Le token peut être révoqué à tout moment depuis Webex

### Fichiers d'archive
- Les fichiers sont créés localement
- Aucun upload vers des serveurs externes
- Contrôle total sur vos données

## 🚨 Signaler des vulnérabilités

### Processus de signalement
1. **Ne créez PAS d'issue publique** pour les vulnérabilités
2. **Contactez directement** l'équipe de sécurité
3. **Fournissez** des détails complets
4. **Attendez** la confirmation de réception

### Informations à fournir
- Description de la vulnérabilité
- Étapes pour reproduire
- Impact potentiel
- Version affectée
- Plateforme concernée

### Contact sécurité
- Email: security@votre-entreprise.com
- GitHub: Créer une issue privée
- Slack: Canal sécurité interne

## 🔐 Bonnes pratiques

### Pour les utilisateurs
- Utilisez des tokens Webex avec des permissions minimales
- Révoquez les tokens inutilisés
- Gardez l'application à jour
- Ne partagez pas vos tokens

### Pour les développeurs
- Ne commitez jamais de tokens
- Utilisez des variables d'environnement
- Validez toutes les entrées utilisateur
- Testez les cas limites

## 📋 Audit de sécurité

### Vérifications régulières
- Mise à jour des dépendances
- Audit du code source
- Tests de pénétration
- Révision des permissions

### Outils utilisés
- Dependabot pour les dépendances
- CodeQL pour l'analyse statique
- Tests de sécurité automatisés

## 🚨 Incident de sécurité

### En cas d'incident
1. **Isolez** le système affecté
2. **Contactez** l'équipe de sécurité
3. **Documentez** l'incident
4. **Corrigez** la vulnérabilité
5. **Communiquez** avec les utilisateurs

### Communication
- Notification aux utilisateurs affectés
- Mise à jour de sécurité
- Documentation de l'incident
- Mesures préventives

## 📞 Contact

Pour toute question de sécurité :
- Email: security@votre-entreprise.com
- GitHub: Issue privée
- Slack: Canal sécurité
EOF

# Afficher la taille du dossier GitHub
echo "📊 Taille du repository GitHub préparé:"
du -sh "$GITHUB_DIR"

echo ""
echo "✅ Repository GitHub préparé pour https://github.com/Josephdeveze/Webex_Archives"
echo ""
echo "📋 Structure créée:"
echo "   📁 macos/ - Application macOS"
echo "   📁 windows/ - Application Windows (à compiler)"
echo "   📁 docs/ - Documentation complète"
echo "   📁 src/ - Code source"
echo "   📁 scripts/ - Scripts de compilation et tests"
echo "   📄 README.md - Guide principal"
echo "   📄 USER_GUIDE.md - Guide utilisateur"
echo "   📄 VERSION.md - Version et changelog"
echo "   📄 CONTRIBUTING.md - Guide de contribution"
echo "   📄 SECURITY.md - Politique de sécurité"
echo ""
echo "📋 Prochaines étapes:"
echo "1. Copier le contenu de '$GITHUB_DIR' dans votre repository GitHub"
echo "2. Compiler l'application Windows et l'ajouter"
echo "3. Configurer les permissions du repository"
echo "4. Partager avec les utilisateurs internes"
echo ""
echo "🎯 Avantages pour distribution interne:"
echo "   ✅ Téléchargement direct depuis GitHub"
echo "   ✅ Documentation complète"
echo "   ✅ Guide de contribution"
echo "   ✅ Politique de sécurité"
echo "   ✅ Versioning et changelog"
echo ""
echo "🔗 Repository: https://github.com/Josephdeveze/Webex_Archives"
