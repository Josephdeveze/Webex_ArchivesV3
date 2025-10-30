# Webex Archive Manager

Application Windows pour archiver les espaces Webex en fichiers HTML.

![Version](https://img.shields.io/badge/version-1.0-blue)
![Python](https://img.shields.io/badge/python-3.13-blue)
![Platform](https://img.shields.io/badge/platform-Windows-blue)
![Status](https://img.shields.io/badge/status-production-green)

---

## 📋 Table des Matières

- [À Propos](#à-propos)
- [Fonctionnalités](#fonctionnalités)
- [Installation Utilisateur](#installation-utilisateur)
- [Utilisation](#utilisation)
- [Installation Développeur](#installation-développeur)
- [Compilation](#compilation)
- [Structure du Projet](#structure-du-projet)
- [Dépannage](#dépannage)
- [Documentation](#documentation)
- [Licence](#licence)

---

## 🎯 À Propos

**Webex Archive Manager** est une application Windows standalone qui permet d'archiver vos espaces Webex en fichiers HTML consultables hors ligne.

### Caractéristiques Principales

- ✅ **Standalone** - Aucune installation Python requise
- ✅ **Interface Graphique** - PyQt6 moderne et intuitive
- ✅ **Archivage HTML** - Export des conversations en HTML
- ✅ **Téléchargement de Fichiers** - Option de télécharger les fichiers partagés
- ✅ **Multiprocessing** - Archivage parallèle pour plus de rapidité
- ✅ **Portable** - Fonctionne sur n'importe quel PC Windows

### Informations Techniques

- **Version :** 1.0
- **Date :** 30 octobre 2025
- **Python :** 3.13.9
- **Outil de Build :** cx_Freeze 8.4.1
- **Interface :** PyQt6
- **Plateforme :** Windows 10/11 (64 bits)

---

## ✨ Fonctionnalités

### Interface Utilisateur

- 🔐 **Authentification** - Connexion via token Webex
- 📋 **Liste des Espaces** - Chargement et affichage de tous vos espaces
- ☑️ **Sélection Multiple** - Archivage de plusieurs espaces simultanément
- 📊 **Barre de Progression** - Suivi en temps réel de l'archivage
- 📝 **Logs** - Affichage détaillé des opérations

### Archivage

- 📄 **Export HTML** - Conversations exportées en HTML lisible
- 📁 **Téléchargement de Fichiers** - Option de télécharger les fichiers partagés
- 📅 **Filtrage par Date** - Archivage d'une période spécifique
- ⚡ **Multiprocessing** - Jusqu'à 10 processus parallèles
- 💾 **Sauvegarde Locale** - Archives stockées sur votre PC

### Configuration

- ⚙️ **Options Personnalisables** - Téléchargement, processus, dates
- 💾 **Sauvegarde des Paramètres** - Token et configuration conservés
- 🔄 **Réutilisable** - Paramètres sauvegardés entre les sessions

---

## 📦 Installation Utilisateur

### Prérequis

- Windows 10 ou 11 (64 bits)
- ~200 MB d'espace disque
- Connexion Internet
- Visual C++ Redistributable 2015-2022 ([Télécharger](https://aka.ms/vs/17/release/vc_redist.x64.exe))

### Étapes d'Installation

1. **Télécharger** le fichier `Webex_Archive_Manager_v1.0_FINAL.zip`

2. **Décompresser** le ZIP
   - Clic droit → "Extraire tout..."
   - Choisir un emplacement (Bureau ou Documents)

3. **Lancer** l'application
   - Double-cliquer sur `Webex Archive Manager.exe`

4. **Avertissement Windows** (normal)
   - Cliquer sur "Plus d'informations"
   - Cliquer sur "Exécuter quand même"

> **Note :** Aucune installation Python ou autre logiciel n'est nécessaire. Tout est inclus dans l'application.

---

## 🚀 Utilisation

### 1. Obtenir un Token Webex

1. Aller sur [developer.webex.com](https://developer.webex.com)
2. Se connecter avec votre compte Webex
3. Copier le token (commence par "Bearer...")

### 2. Charger les Espaces

1. Coller le token dans le champ "Token Webex"
2. Cliquer sur "🔄 Charger les espaces"
3. Attendre que la liste s'affiche

### 3. Sélectionner et Archiver

1. Cocher les espaces à archiver
2. (Optionnel) Configurer les options dans l'onglet "Configuration"
3. Cliquer sur "📦 Archiver la sélection"
4. Attendre la fin de l'archivage

### 4. Consulter les Archives

Les archives sont créées dans :
```
C:\Users\[VotreNom]\Webex Archives\
```

Chaque espace a son propre dossier avec :
- `index.html` - Messages de l'espace
- Fichiers téléchargés (si activé)

---

## 💻 Installation Développeur

### Prérequis

- Python 3.13.9
- pip
- Git

### Installation

```bash
# Cloner le dépôt
git clone https://github.com/votre-username/Webex_ArchivesV2.git
cd Webex_ArchivesV2

# Installer les dépendances
pip install -r requirements.txt
```

### Dépendances

```
PyQt6>=6.6.0
requests>=2.31.0
cx_Freeze>=8.4.1
```

### Lancer en Mode Développement

```bash
python webex_gui.py
```

---

## 🔨 Compilation

### Compiler l'Application

```bash
# Méthode 1 : Script automatique (recommandé)
.\build_cxfreeze.bat

# Méthode 2 : Commande manuelle
python setup.py build
```

### Résultat de la Compilation

L'application compilée se trouve dans :
```
build\exe.win-amd64-3.13\
```

### Créer le Package de Distribution

```powershell
# Créer le ZIP
$source = "build\exe.win-amd64-3.13"
$dest = "Webex_Archive_Manager_v1.0.zip"
Add-Type -A 'System.IO.Compression.FileSystem'
[IO.Compression.ZipFile]::CreateFromDirectory($source, $dest)
```

---

## 📁 Structure du Projet

```
Webex_ArchivesV2/
├── webex_gui.py              # Interface graphique principale
├── main.py                   # Script d'archivage (legacy)
├── setup.py                  # Configuration cx_Freeze
├── build_cxfreeze.bat        # Script de compilation
├── qt.conf                   # Configuration Qt
├── requirements.txt          # Dépendances Python
├── README.md                 # Ce fichier
├── GUIDE_UTILISATEUR.txt     # Guide utilisateur
├── VERSION_PRODUCTION.txt    # Info version
├── SUCCES_CXFREEZE.md        # Documentation technique
├── Webex Archive/            # Scripts d'archivage
│   ├── main.py
│   └── README.md
└── build/                    # Dossier de compilation
    └── exe.win-amd64-3.13/   # Application compilée
```

---

## 🔧 Dépannage

### L'application ne démarre pas

**Solution :**
1. Installer Visual C++ Redistributable : [Télécharger](https://aka.ms/vs/17/release/vc_redist.x64.exe)
2. Vérifier l'antivirus
3. Lancer en tant qu'administrateur

### Erreur "Token invalide"

**Solution :**
1. Aller sur [developer.webex.com](https://developer.webex.com)
2. Copier un nouveau token
3. Coller dans l'application

### Erreur "Qt platform plugin"

**Solution :**
1. Vérifier que `qt.conf` est présent
2. Vérifier que le dossier `lib\PyQt6\Qt6\plugins\` existe
3. Recompiler l'application

### Archivage très lent

**Solution :**
1. Désactiver "Télécharger les fichiers"
2. Réduire le nombre de processus à 1
3. Archiver moins d'espaces à la fois

---

## 📚 Documentation

### Pour les Utilisateurs

- **[GUIDE_UTILISATEUR.txt](GUIDE_UTILISATEUR.txt)** - Guide d'installation et d'utilisation complet
- **[PACKAGE_FINAL_INSTRUCTIONS.txt](PACKAGE_FINAL_INSTRUCTIONS.txt)** - Instructions de distribution

### Pour les Développeurs

- **[SUCCES_CXFREEZE.md](SUCCES_CXFREEZE.md)** - Explication technique de la solution cx_Freeze
- **[VERSION_PRODUCTION.txt](VERSION_PRODUCTION.txt)** - Récapitulatif de la version finale

---

## 🔍 Historique des Problèmes Résolus

### Problème 1 : Erreur `_socket` avec PyInstaller
- **Cause :** Incompatibilité PyInstaller + Python 3.13
- **Solution :** Migration vers cx_Freeze

### Problème 2 : Erreur chemin `library.zip`
- **Cause :** `__file__` pointait vers library.zip au lieu du dossier réel
- **Solution :** Utilisation de `sys.executable` pour applications compilées

### Problème 3 : Plugins Qt manquants
- **Cause :** Qt ne trouvait pas ses plugins
- **Solution :** Création du fichier `qt.conf`

### Problème 4 : Application ne démarre pas sur autre machine
- **Cause :** Fichier `qt.conf` manquant dans le package
- **Solution :** Inclusion automatique de `qt.conf` dans `setup.py`

---

## 🛠️ Technologies Utilisées

- **Python 3.13.9** - Langage de programmation
- **PyQt6** - Interface graphique
- **cx_Freeze** - Packaging pour Windows
- **Requests** - API Webex
- **Multiprocessing** - Traitement parallèle

---

## 📊 Comparaison des Outils de Packaging

| Outil | Python 3.13 | Résultat |
|-------|-------------|----------|
| PyInstaller | ❌ | Erreur _socket |
| cx_Freeze | ✅ | Fonctionne parfaitement |
| Nuitka | ✅ | Non testé |

**Solution retenue :** cx_Freeze 8.4.1

---

## 🔄 Mises à Jour

### v1.0 (30/10/2025)
- ✅ Version initiale
- ✅ Migration vers cx_Freeze
- ✅ Correction des problèmes de packaging
- ✅ Tests réussis sur plusieurs machines
- ✅ Documentation complète

---

## 📄 Licence

Ce projet est destiné à un usage interne.

---

## 👤 Auteur

**Joseph Deveze**

---

## 🙏 Remerciements

- **PyQt6** - Pour l'interface graphique moderne
- **cx_Freeze** - Pour le packaging Windows fiable
- **Webex API** - Pour l'accès aux données

---

## 📞 Support

Pour toute question ou problème :
1. Consulter le [GUIDE_UTILISATEUR.txt](GUIDE_UTILISATEUR.txt)
2. Vérifier la section [Dépannage](#dépannage)
3. Contacter le support IT

---

**Version 1.0 - Production Ready** ✅

*Dernière mise à jour : 30 octobre 2025*
