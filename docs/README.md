# 🚀 Webex Archive Manager

Une application portable pour archiver les espaces de messages Webex en fichiers HTML avec une interface graphique moderne.

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

## 📦 Installation et utilisation

### Pour les utilisateurs finaux

1. **Téléchargez** l'application pour votre plateforme
2. **Décompressez** le fichier ZIP
3. **Lancez** l'application :
   - **macOS** : Double-cliquez sur `Webex Archive Manager.app`
   - **Windows** : Double-cliquez sur `Webex Archive Manager.exe`
   - **Linux** : Exécutez `./Webex Archive Manager`

### Première utilisation

1. **Obtenez un token Webex** sur [developer.webex.com](https://developer.webex.com)
2. **Entrez votre token** dans l'interface
3. **Cliquez sur "Charger les espaces"**
4. **Sélectionnez** les espaces à archiver
5. **Cliquez sur "Archiver la sélection"**

## 🔧 Compilation depuis les sources

### Prérequis

- Python 3.9+ 
- Git
- Environnement virtuel Python

### Installation des dépendances

```bash
# Cloner le projet
git clone <votre-repo>
cd export_webex

# Créer un environnement virtuel
python -m venv .venv

# Activer l'environnement virtuel
# Sur macOS/Linux :
source .venv/bin/activate
# Sur Windows :
.venv\Scripts\activate

# Installer les dépendances
pip install -r requirements.txt
```

### Compilation

#### Sur macOS/Linux

```bash
# Compilation automatique
./build_universal.sh

# Ou compilation manuelle
./clean_build.sh
source .venv/bin/activate
./build_app.sh
```

#### Sur Windows

```batch
REM Compilation automatique
build_windows.bat

REM Ou compilation manuelle avec Git Bash
bash build_universal.sh
```

## 📁 Structure des fichiers générés

```
Webex Archives/
├── Nom de l'espace 1/
│   ├── Nom de l'espace 1.html
│   ├── files/
│   │   └── fichiers téléchargés
│   └── images/
│       └── images téléchargées
├── Nom de l'espace 2/
│   ├── Nom de l'espace 2.html
│   └── ...
└── ...
```

## ⚙️ Configuration

L'application utilise un fichier de configuration `webexspacearchive-config.ini` avec les options suivantes :

- `download` : Type de téléchargement (no, info, images, files)
- `useravatar` : Gestion des avatars (no, link, download)
- `maxtotalmessages` : Nombre maximum de messages
- `sortoldnew` : Tri des messages (yes/no)
- `outputjson` : Export JSON (no, yes, json, txt)
- `blurring` : Floutage des noms (yes/no)

## 🚨 Résolution de problèmes

### macOS
- **"Application endommagée"** : Autorisez l'application dans Préférences Système > Sécurité et confidentialité
- **Permissions** : Assurez-vous que l'application a accès au réseau

### Windows
- **"Windows a protégé votre PC"** : Cliquez sur "Plus d'informations" puis "Exécuter quand même"
- **Antivirus** : Ajoutez l'application aux exceptions de votre antivirus
- **Permissions** : Exécutez en tant qu'administrateur si nécessaire

### Linux
- **Dépendances manquantes** : Installez `libxcb-xinerama0` et `libxcb-cursor0`
- **Permissions** : Rendez le fichier exécutable avec `chmod +x "Webex Archive Manager"`

## 🔒 Sécurité

- Les tokens Webex sont stockés localement et ne sont jamais transmis à des tiers
- Les fichiers d'archive sont créés localement sur votre machine
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
1. Vérifiez la section "Résolution de problèmes"
2. Consultez les logs dans l'interface de l'application
3. Créez une issue sur le repository du projet