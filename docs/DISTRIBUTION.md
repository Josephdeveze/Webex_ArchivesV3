# 📦 Instructions de distribution - Webex Archive Manager

## 🎯 Résumé

Votre application **Webex Archive Manager** est maintenant prête pour la distribution sur **macOS et Windows** ! 

## 📁 Fichiers créés

### Scripts de compilation
- `build_universal.sh` - Script universel pour macOS/Linux/Windows (via Git Bash)
- `build_windows.bat` - Script batch pour Windows
- `build_windows.ps1` - Script PowerShell pour Windows
- `clean_build.sh` - Script de nettoyage
- `test_app.sh` - Script de test de l'application

### Documentation
- `README.md` - Documentation complète
- `build_config.ini` - Configuration de compilation
- `requirements.txt` - Dépendances Python

## 🚀 Comment compiler pour Windows

### Option 1: Avec Git Bash (Recommandé)
```bash
# Sur Windows avec Git Bash installé
bash build_universal.sh
```

### Option 2: Avec PowerShell
```powershell
# Sur Windows avec PowerShell
.\build_windows.ps1
```

### Option 3: Avec le script batch
```batch
REM Sur Windows
build_windows.bat
```

## 📋 Prérequis pour Windows

1. **Python 3.9+** - [python.org/downloads](https://www.python.org/downloads/)
2. **Git for Windows** - [git-scm.com/download/win](https://git-scm.com/download/win)
3. **Environnement virtuel Python**

## 🔧 Installation des dépendances sur Windows

```bash
# Créer un environnement virtuel
python -m venv .venv

# Activer l'environnement virtuel
# Avec Git Bash :
source .venv/Scripts/activate
# Avec PowerShell :
.venv\Scripts\Activate.ps1

# Installer les dépendances
pip install -r requirements.txt
```

## 📦 Distribution

### Pour macOS
1. Compilez avec `./build_universal.sh`
2. Compressez `dist/Webex Archive Manager` en ZIP
3. Les utilisateurs décompressent et double-cliquent sur `Webex Archive Manager.app`

### Pour Windows
1. Compilez avec `bash build_universal.sh` (ou les autres options)
2. Compressez `dist/Webex Archive Manager` en ZIP
3. Les utilisateurs décompressent et double-cliquent sur `Webex Archive Manager.exe`

## ⚠️ Notes importantes

### macOS
- Les utilisateurs devront peut-être autoriser l'application dans Préférences Système > Sécurité et confidentialité
- Taille de l'application : ~78MB

### Windows
- Windows peut afficher un avertissement de sécurité - les utilisateurs devront cliquer sur "Plus d'informations" puis "Exécuter quand même"
- L'antivirus peut bloquer l'application - ajoutez-la aux exceptions
- Taille de l'application : ~80-100MB

## 🧪 Test de l'application

Utilisez le script de test pour vérifier que tout fonctionne :

```bash
./test_app.sh
```

Ce script vérifie :
- ✅ L'exécutable existe
- ✅ Les fichiers de configuration sont présents
- ✅ Les dépendances sont incluses
- ✅ Les permissions sont correctes
- ✅ La taille de l'application

## 🎉 Félicitations !

Votre application **Webex Archive Manager** est maintenant :
- ✅ **Portable** - Fonctionne sans installation
- ✅ **Multi-plateforme** - macOS et Windows
- ✅ **Complète** - Interface graphique + archivage
- ✅ **Testée** - Scripts de test inclus
- ✅ **Documentée** - Instructions complètes

Les utilisateurs peuvent maintenant archiver leurs espaces Webex facilement sur les deux plateformes principales !
