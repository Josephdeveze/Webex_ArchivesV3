# 📁 Structure recommandée pour GitHub

## ✅ **Ce qu'il faut inclure dans le repository**

### Code source et configuration
- `webex_gui.py` - Interface graphique principale
- `main.py` - Script principal
- `Webex Archive/` - Dossier avec les scripts d'archivage
  - `webex-space-archive.py`
  - `generate_space_batch.py`
  - `webexspacearchive-config.ini`
  - `README.md`

### Scripts de compilation
- `build_universal.sh` - Script de compilation universel
- `build_app.sh` - Script de compilation macOS
- `build_windows.bat` - Script batch Windows
- `build_windows.ps1` - Script PowerShell Windows
- `clean_build.sh` - Script de nettoyage

### Scripts de test
- `test_portability.sh` - Test de portabilité
- `test_windows_gui.sh` - Test interface graphique
- `test_app.sh` - Test général

### Configuration et documentation
- `requirements.txt` - Dépendances Python
- `build_config.ini` - Configuration de compilation
- `README.md` - Documentation principale
- `DISTRIBUTION.md` - Guide de distribution
- `PORTABILITY_CONFIRMED.md` - Confirmation de portabilité

## ❌ **Ce qu'il faut EXCLURE du repository**

### Fichiers générés automatiquement
- `dist/` - Dossier de distribution (227MB)
- `build/` - Fichiers de build temporaires
- `*.spec` - Fichiers PyInstaller temporaires
- `temp_webex_archive/` - Dossier temporaire
- `__pycache__/` - Cache Python
- `.pytest_cache/` - Cache de tests

### Environnement virtuel
- `.venv/` - Environnement virtuel Python
- `venv/` - Autre environnement virtuel

### Fichiers système
- `.DS_Store` - Fichiers macOS
- `Thumbs.db` - Fichiers Windows
- `*.pyc` - Fichiers Python compilés
- `*.pyo` - Fichiers Python optimisés

## 📋 **Fichier .gitignore recommandé**

```gitignore
# Fichiers de build et distribution
dist/
build/
*.spec
temp_webex_archive/

# Environnement virtuel
.venv/
venv/
env/
ENV/

# Cache Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
.pytest_cache/

# Fichiers système
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# IDE
.vscode/
.idea/
*.swp
*.swo

# Logs
*.log

# Fichiers temporaires
*.tmp
*.temp
```

## 🚀 **Workflow recommandé**

1. **Créer le repository** avec le code source
2. **Ajouter le .gitignore** pour exclure les fichiers générés
3. **Publier les releases** avec les fichiers compilés
4. **Documenter** comment compiler l'application

## 📦 **Stratégie de distribution**

### Option 1: Releases GitHub (Recommandée)
- Code source dans le repository principal
- Fichiers compilés dans les "Releases"
- Chaque release contient les ZIP pour macOS et Windows

### Option 2: Repository séparé
- Repository principal : code source
- Repository `webex-archive-releases` : fichiers compilés

### Option 3: Assets GitHub
- Code source dans le repository
- Fichiers compilés attachés aux releases
- Téléchargement direct depuis GitHub
