# 📦 Webex Archive Manager v1.0

Application Windows pour archiver les espaces Webex en fichiers HTML.

---

## ✅ Version Finale - Production Ready

**Date :** 30 octobre 2025  
**Version :** 1.0  
**Outil de build :** cx_Freeze 8.4.1  
**Python :** 3.13.9  
**Statut :** ✅ Testé et fonctionnel

---

## 📦 Fichiers de Distribution

### Package Final
- **Fichier :** `Webex_Archive_Manager_v1.0_FINAL.zip`
- **Taille :** 74.4 MB
- **Contenu :** Application complète avec toutes les dépendances

### Ce qui est inclus
- ✅ Exécutable Windows (sans console)
- ✅ Tous les modules Python nécessaires
- ✅ PyQt6 pour l'interface graphique
- ✅ Modules réseau (_socket, _ssl, select)
- ✅ Scripts d'archivage Webex
- ✅ Configuration Qt (qt.conf)
- ✅ DLL Visual C++ Runtime

---

## 🚀 Installation pour l'Utilisateur Final

### Prérequis
- Windows 10 ou 11 (64 bits)
- ~200 MB d'espace disque
- Connexion Internet
- **Aucun logiciel supplémentaire requis**

### Étapes d'Installation

1. **Décompresser le ZIP**
   - Extraire `Webex_Archive_Manager_v1.0_FINAL.zip`
   - Choisir un emplacement (Bureau ou Documents recommandé)

2. **Lancer l'Application**
   - Double-cliquer sur `Webex Archive Manager.exe`

3. **Avertissement Windows** (normal)
   - Cliquer sur "Plus d'informations"
   - Cliquer sur "Exécuter quand même"

4. **Utilisation**
   - Obtenir un token sur https://developer.webex.com
   - Coller le token dans l'application
   - Charger les espaces
   - Archiver

---

## 🔧 Pour les Développeurs

### Structure du Projet

```
Webex_ArchivesV2/
├── webex_gui.py              # Interface graphique principale
├── main.py                   # Script d'archivage (legacy)
├── setup.py                  # Configuration cx_Freeze
├── build_cxfreeze.bat        # Script de compilation
├── qt.conf                   # Configuration Qt
├── requirements.txt          # Dépendances Python
├── Webex Archive/            # Scripts d'archivage
│   └── main.py
└── build/                    # Dossier de compilation
    └── exe.win-amd64-3.13/   # Application compilée
```

### Compilation

```powershell
# Méthode 1 : Script automatique
.\build_cxfreeze.bat

# Méthode 2 : Commande manuelle
python setup.py build
```

### Dépendances de Développement

```bash
pip install PyQt6 requests cx_Freeze
```

### Configuration cx_Freeze

Le fichier `setup.py` contient :
- Liste complète des packages à inclure
- Configuration Win32GUI (pas de console)
- Inclusion automatique de qt.conf
- Désactivation de la compression library.zip

### Points Clés de la Configuration

1. **Chemins d'application compilée**
   - Utilisation de `sys.executable` au lieu de `__file__`
   - Détection avec `getattr(sys, 'frozen', False)`

2. **Configuration Qt**
   - Fichier `qt.conf` obligatoire
   - Définit les chemins des plugins et binaires Qt

3. **Modules critiques**
   - `_socket`, `_ssl`, `select` inclus explicitement
   - Pas de compression pour éviter les problèmes de chemins

---

## 📝 Historique des Problèmes Résolus

### Problème 1 : Erreur `_socket` avec PyInstaller
- **Cause :** Incompatibilité PyInstaller + Python 3.13
- **Solution :** Migration vers cx_Freeze

### Problème 2 : Erreur chemin `library.zip`
- **Cause :** `__file__` pointait vers library.zip
- **Solution :** Utilisation de `sys.executable` pour applications compilées

### Problème 3 : Plugins Qt manquants
- **Cause :** Qt ne trouvait pas ses plugins
- **Solution :** Création du fichier `qt.conf`

### Problème 4 : Application ne démarre pas sur autre machine
- **Cause :** Fichier `qt.conf` manquant dans le package
- **Solution :** Inclusion automatique de `qt.conf` dans `setup.py`

---

## 🎯 Fonctionnalités

### Interface Graphique
- ✅ Connexion avec token Webex
- ✅ Chargement de la liste des espaces
- ✅ Sélection multiple d'espaces
- ✅ Archivage avec barre de progression
- ✅ Logs en temps réel
- ✅ Configuration des options d'archivage
- ✅ Sauvegarde des paramètres

### Archivage
- ✅ Export en HTML
- ✅ Téléchargement des fichiers (optionnel)
- ✅ Gestion des dates de début/fin
- ✅ Support multiprocessing
- ✅ Gestion des erreurs

---

## 📤 Distribution

### Créer le Package

```powershell
# 1. Compiler
.\build_cxfreeze.bat

# 2. Créer le ZIP
$source = "build\exe.win-amd64-3.13"
$dest = "Webex_Archive_Manager_v1.0.zip"
Add-Type -A 'System.IO.Compression.FileSystem'
[IO.Compression.ZipFile]::CreateFromDirectory($source, $dest)
```

### Envoyer à l'Utilisateur

- Email (via WeTransfer ou OneDrive si > 25 MB)
- Partage réseau
- Clé USB

---

## 🔄 Mises à Jour Futures

Pour créer une nouvelle version :

1. Modifier le code source
2. Incrémenter le numéro de version dans `setup.py`
3. Recompiler avec `build_cxfreeze.bat`
4. Créer un nouveau ZIP
5. Distribuer

---

## 📊 Comparaison des Outils de Packaging

| Outil | Python 3.13 | Résultat |
|-------|-------------|----------|
| PyInstaller | ❌ | Erreur _socket |
| cx_Freeze | ✅ | Fonctionne |
| Nuitka | ✅ | Non testé |

**Solution retenue :** cx_Freeze

---

## 📞 Support

### Problèmes Courants

**L'application ne démarre pas**
- Installer Visual C++ Redistributable : https://aka.ms/vs/17/release/vc_redist.x64.exe
- Vérifier l'antivirus
- Vérifier que tous les fichiers sont présents

**Erreur "Qt platform plugin"**
- Vérifier que `qt.conf` est présent
- Vérifier que le dossier `lib\PyQt6\Qt6\plugins\` existe

**Erreur de connexion Webex**
- Vérifier le token (doit commencer par "Bearer")
- Vérifier la connexion Internet
- Régénérer le token sur developer.webex.com

---

## 📄 Licence

Ce projet est destiné à un usage interne.

---

## 👤 Auteur

Joseph Deveze

---

## 🎉 Remerciements

- PyQt6 pour l'interface graphique
- cx_Freeze pour le packaging
- Webex API pour l'accès aux données

---

**Version finale testée et fonctionnelle - Prête pour la production** ✅
