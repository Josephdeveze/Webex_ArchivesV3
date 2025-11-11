# Webex Archive Manager - User Guide / Guide Utilisateur

**Version:** 1.2.0  
**Last Update / Dernière mise à jour:** November 11, 2025

---

## 🇬🇧 English Version

### 📦 Installation

1. **Extract the ZIP file**
   - Right-click on `Webex_Archive_Manager_v1.2_FINAL.zip`
   - Select "Extract All..."
   - Choose a location (Desktop or Documents recommended)

2. **Open the folder**
   - You will see several files and folders
   - **Important:** Keep all files together, do not separate them!

3. **Launch the application**
   - Double-click on `Webex Archive Manager.exe`

4. **Windows Security Warning** (Normal)
   - If Windows displays "Unrecognized app"
   - Click "More info"
   - Click "Run anyway"

### ⚙️ System Requirements

- Windows 10 or 11 (64-bit)
- ~200 MB disk space
- Internet connection
- **No additional software required** (Python, libraries, etc. are included)

---

### 🚀 Quick Start Guide

#### Step 1: Get Your Webex Token

1. Go to [developer.webex.com](https://developer.webex.com)
2. Log in with your Webex account
3. Copy the token (starts with "Bearer...")

#### Step 2: Load Your Spaces

1. Paste the token in the "Webex Token" field
2. Click "🔄 Load Spaces"
3. Wait for the list to appear

#### Step 3: Select Spaces to Archive

1. Check the spaces you want to archive
2. Or click "✅ Select All"

#### Step 4: Configure Options (Optional)

Go to the **"⚙️ Configuration"** tab:

**Download Options:**
- **Download files:** Choose what to download
  - `no` - Text only (fastest)
  - `info` - File information only
  - `images` - Images only
  - `files` - All files (slowest)
- **User avatars:** Display options for user pictures

**Archive Limit:**
- **Limit by number of messages**
  - Archive the last X messages (e.g., 1000)
  - Fixed size, predictable
  
- **Limit by time period** ⭐
  - Archive the last X days/months/years
  - Examples:
    - `30 last days` - Recent activity
    - `6 last months` - Quarterly archive
    - `7 last years` - Legal compliance

**Message Options:**
- ☑ **Sort from oldest to newest** - Chronological order
- ☐ **Export to JSON** - Also create JSON file
- ☐ **Blur names in HTML** - Anonymize names

#### Step 5: Start Archiving

1. Click "📦 Archive Selection"
2. Wait for completion (progress bar shows status)
3. Done! ✅

---

### 📁 Where Are My Archives?

Archives are created in:
```
C:\Users\[YourName]\Webex Archives\
```

Each space has its own folder containing:
- `index.html` - Main archive file (open with any browser)
- Downloaded files (if enabled)

---

### 💡 Feature Details

#### Archive Limit Options

**When to use "Limit by messages":**
- ✅ You want a fixed number of messages
- ✅ Predictable archive size
- ✅ General backup

**When to use "Limit by time period":**
- ✅ Legal compliance (e.g., 7 years)
- ✅ Regular archiving (e.g., monthly)
- ✅ Recent activity only (e.g., 30 days)
- ✅ Control archive size for very active spaces

#### Examples

**Example 1: Recent Activity**
- Limit: `30 last days`
- Result: Only messages from the last 30 days
- Use case: Very active space, focus on recent

**Example 2: Quarterly Archive**
- Limit: `6 last months`
- Result: Messages from the last 6 months
- Use case: Regular archiving every quarter

**Example 3: Legal Compliance**
- Limit: `7 last years`
- Result: All messages from the last 7 years
- Use case: Legal requirements, audit

**Example 4: Fixed Size**
- Limit: `1000 messages`
- Result: The last 1000 messages
- Use case: General backup, predictable size

---

### 🔧 Troubleshooting

#### Application Won't Start

**Solution:**
1. Download and install: [Visual C++ Redistributable](https://aka.ms/vs/17/release/vc_redist.x64.exe)
2. Restart your computer
3. Try again

#### "Invalid Token" Error

**Solution:**
1. Go to [developer.webex.com](https://developer.webex.com)
2. Copy a NEW token (tokens expire after 12 hours)
3. Paste in the application
4. Try again

#### "Connection Error"

**Solution:**
1. Check your internet connection
2. Verify the token is valid
3. Try again in a few minutes

#### Archiving is Very Slow

**Solution:**
1. Disable "Download files" (use `no - Text only`)
2. Use time limit instead of all messages
3. Archive fewer spaces at once

#### Windows Defender Blocks the Application

**Solution:**
1. Open "Windows Security"
2. Go to "Virus & threat protection"
3. Check "Protection history"
4. If blocked, click "Allow"

---

### ⚠️ Important Notes

- **Token expires after 12 hours** - You'll need to get a new one
- **Keep all files together** - Don't separate the application files
- **Archives are local** - Stored on your computer only
- **Internet required** - To access Webex API

---

### 📞 Need Help?

If you encounter any issues:
1. Check this guide
2. Verify Visual C++ Redistributable is installed
3. Check that antivirus is not blocking the application
4. Contact your IT support

---

## 🇫🇷 Version Française

### 📦 Installation

1. **Extraire le fichier ZIP**
   - Clic droit sur `Webex_Archive_Manager_v1.2_FINAL.zip`
   - Sélectionner "Extraire tout..."
   - Choisir un emplacement (Bureau ou Documents recommandé)

2. **Ouvrir le dossier**
   - Vous verrez plusieurs fichiers et dossiers
   - **Important :** Gardez tous les fichiers ensemble, ne les séparez pas !

3. **Lancer l'application**
   - Double-cliquer sur `Webex Archive Manager.exe`

4. **Avertissement Windows** (Normal)
   - Si Windows affiche "Application non reconnue"
   - Cliquer sur "Plus d'informations"
   - Cliquer sur "Exécuter quand même"

### ⚙️ Prérequis Système

- Windows 10 ou 11 (64 bits)
- ~200 Mo d'espace disque
- Connexion Internet
- **Aucun logiciel supplémentaire requis** (Python, bibliothèques, etc. sont inclus)

---

### 🚀 Guide de Démarrage Rapide

#### Étape 1 : Obtenir Votre Token Webex

1. Aller sur [developer.webex.com](https://developer.webex.com)
2. Se connecter avec votre compte Webex
3. Copier le token (commence par "Bearer...")

#### Étape 2 : Charger Vos Espaces

1. Coller le token dans le champ "Token Webex"
2. Cliquer sur "🔄 Charger les espaces"
3. Attendre que la liste s'affiche

#### Étape 3 : Sélectionner les Espaces à Archiver

1. Cocher les espaces que vous voulez archiver
2. Ou cliquer sur "✅ Tout sélectionner"

#### Étape 4 : Configurer les Options (Optionnel)

Aller dans l'onglet **"⚙️ Configuration"** :

**Options de téléchargement :**
- **Télécharger les fichiers :** Choisir quoi télécharger
  - `no` - Texte seulement (plus rapide)
  - `info` - Informations fichiers seulement
  - `images` - Images seulement
  - `files` - Tous les fichiers (plus lent)
- **Avatars utilisateurs :** Options d'affichage des photos

**Limite d'archivage :**
- **Limiter par nombre de messages**
  - Archiver les X derniers messages (ex: 1000)
  - Taille fixe, prévisible
  
- **Limiter par période** ⭐
  - Archiver les X derniers jours/mois/années
  - Exemples :
    - `30 derniers jours` - Activité récente
    - `6 derniers mois` - Archive trimestrielle
    - `7 dernières années` - Conformité légale

**Options des messages :**
- ☑ **Trier du plus ancien au plus récent** - Ordre chronologique
- ☐ **Exporter aussi en JSON** - Créer aussi un fichier JSON
- ☐ **Flouter les noms dans le HTML** - Anonymiser les noms

#### Étape 5 : Lancer l'Archivage

1. Cliquer sur "📦 Archiver la sélection"
2. Attendre la fin (la barre de progression indique l'avancement)
3. Terminé ! ✅

---

### 📁 Où Sont Mes Archives ?

Les archives sont créées dans :
```
C:\Users\[VotreNom]\Webex Archives\
```

Chaque espace a son propre dossier contenant :
- `index.html` - Fichier d'archive principal (ouvrir avec n'importe quel navigateur)
- Fichiers téléchargés (si activé)

---

### 💡 Détails des Fonctionnalités

#### Options de Limite d'Archivage

**Quand utiliser "Limiter par nombre de messages" :**
- ✅ Vous voulez un nombre fixe de messages
- ✅ Taille d'archive prévisible
- ✅ Sauvegarde générale

**Quand utiliser "Limiter par période" :**
- ✅ Conformité légale (ex: 7 ans)
- ✅ Archivage régulier (ex: mensuel)
- ✅ Activité récente uniquement (ex: 30 jours)
- ✅ Contrôler la taille pour espaces très actifs

#### Exemples

**Exemple 1 : Activité Récente**
- Limite : `30 derniers jours`
- Résultat : Seulement les messages des 30 derniers jours
- Cas d'usage : Espace très actif, focus sur le récent

**Exemple 2 : Archive Trimestrielle**
- Limite : `6 derniers mois`
- Résultat : Messages des 6 derniers mois
- Cas d'usage : Archivage régulier tous les trimestres

**Exemple 3 : Conformité Légale**
- Limite : `7 dernières années`
- Résultat : Tous les messages des 7 dernières années
- Cas d'usage : Exigences légales, audit

**Exemple 4 : Taille Fixe**
- Limite : `1000 messages`
- Résultat : Les 1000 derniers messages
- Cas d'usage : Sauvegarde générale, taille prévisible

---

### 🔧 Dépannage

#### L'Application Ne Démarre Pas

**Solution :**
1. Télécharger et installer : [Visual C++ Redistributable](https://aka.ms/vs/17/release/vc_redist.x64.exe)
2. Redémarrer votre ordinateur
3. Réessayer

#### Erreur "Token Invalide"

**Solution :**
1. Aller sur [developer.webex.com](https://developer.webex.com)
2. Copier un NOUVEAU token (les tokens expirent après 12 heures)
3. Coller dans l'application
4. Réessayer

#### Erreur "Erreur de Connexion"

**Solution :**
1. Vérifier votre connexion Internet
2. Vérifier que le token est valide
3. Réessayer dans quelques minutes

#### L'Archivage Est Très Lent

**Solution :**
1. Désactiver "Télécharger les fichiers" (utiliser `no - Texte seulement`)
2. Utiliser une limite temporelle au lieu de tous les messages
3. Archiver moins d'espaces à la fois

#### Windows Defender Bloque l'Application

**Solution :**
1. Ouvrir "Sécurité Windows"
2. Aller dans "Protection contre les virus et menaces"
3. Vérifier "Historique de protection"
4. Si bloqué, cliquer sur "Autoriser"

---

### ⚠️ Notes Importantes

- **Le token expire après 12 heures** - Vous devrez en obtenir un nouveau
- **Gardez tous les fichiers ensemble** - Ne séparez pas les fichiers de l'application
- **Les archives sont locales** - Stockées uniquement sur votre ordinateur
- **Internet requis** - Pour accéder à l'API Webex

---

### 📞 Besoin d'Aide ?

Si vous rencontrez des problèmes :
1. Consulter ce guide
2. Vérifier que Visual C++ Redistributable est installé
3. Vérifier que l'antivirus ne bloque pas l'application
4. Contacter votre support informatique

---

## 📊 Quick Reference / Référence Rapide

### English

| Feature | Description | Example |
|---------|-------------|---------|
| **Limit by messages** | Archive last X messages | 1000 messages |
| **Limit by days** | Archive last X days | 30 last days |
| **Limit by months** | Archive last X months | 6 last months |
| **Limit by years** | Archive last X years | 7 last years |
| **Download files** | Download shared files | `no`, `info`, `images`, `files` |
| **Export JSON** | Also create JSON file | Yes/No |

### Français

| Fonctionnalité | Description | Exemple |
|----------------|-------------|---------|
| **Limite par messages** | Archiver les X derniers messages | 1000 messages |
| **Limite par jours** | Archiver les X derniers jours | 30 derniers jours |
| **Limite par mois** | Archiver les X derniers mois | 6 derniers mois |
| **Limite par années** | Archiver les X dernières années | 7 dernières années |
| **Télécharger fichiers** | Télécharger les fichiers partagés | `no`, `info`, `images`, `files` |
| **Export JSON** | Créer aussi un fichier JSON | Oui/Non |

---

## 🎯 Best Practices / Bonnes Pratiques

### 🇬🇧 English

**For Daily Use:**
- Use "30 last days" limit
- Disable file download for speed
- Archive regularly

**For Legal Compliance:**
- Use "7 last years" limit
- Enable file download
- Archive monthly

**For Large Spaces:**
- Use time limit instead of message limit
- Disable file download initially
- Test with small period first

### 🇫🇷 Français

**Pour Utilisation Quotidienne :**
- Utiliser limite "30 derniers jours"
- Désactiver téléchargement fichiers pour vitesse
- Archiver régulièrement

**Pour Conformité Légale :**
- Utiliser limite "7 dernières années"
- Activer téléchargement fichiers
- Archiver mensuellement

**Pour Grands Espaces :**
- Utiliser limite temporelle au lieu de limite messages
- Désactiver téléchargement fichiers initialement
- Tester avec petite période d'abord

---

**Version:** 1.2.0  
**Support:** Contact your IT department / Contactez votre service informatique  
**Last Update / Dernière mise à jour:** November 11, 2025
