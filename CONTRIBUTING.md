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
