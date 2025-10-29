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
