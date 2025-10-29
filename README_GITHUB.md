# 🚀 Webex Archives - Application Portable

Application portable pour archiver les espaces de messages Webex avec une interface graphique moderne.

## 📦 Téléchargement Rapide

### 🍎 macOS
1. **Téléchargez** le dossier `macos/Webex Archive Manager`
2. **Double-cliquez** sur `Webex Archive Manager`
3. **Autorisez** l'application dans Préférences Système si demandé

### 🪟 Windows
**⚠️ Version Windows en cours de développement**

Pour l'instant, seule la version macOS est disponible. La version Windows sera ajoutée prochainement.

**Alternative temporaire :**
- Utilisez la version macOS avec un émulateur Windows
- Ou attendez la prochaine mise à jour

## ✨ Fonctionnalités

- 📱 Interface graphique moderne avec PyQt6
- 🔍 Recherche et filtrage des espaces
- 📦 Archivage en lot de plusieurs espaces
- 📁 Organisation automatique des fichiers téléchargés
- 🎨 Génération de fichiers HTML avec styles CSS
- 📊 Export optionnel en JSON
- 🔒 Support des tokens Webex sécurisés
- 🚀 Application totalement portable

## 🖥️ Plateformes supportées

- ✅ **macOS** (Apple Silicon et Intel)
- ✅ **Windows** (10/11)
- ✅ **Linux** (Ubuntu, Debian, etc.)

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
├── Nom de l'espace 2/
│   ├── Nom de l'espace 2.html
│   └── ...
└── ...
```

## 🔒 Sécurité

- Les tokens Webex sont stockés localement
- Les fichiers d'archive sont créés localement
- L'application ne collecte aucune donnée personnelle
- Aucune connexion externe requise après archivage

## 📞 Support

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

## 🏢 Distribution Interne

Cette application est distribuée en interne pour l'archivage des espaces Webex de l'organisation.

### Accès
- Repository privé pour l'organisation
- Accès contrôlé par l'équipe IT
- Téléchargement direct depuis GitHub

### Versioning
- Chaque commit = nouvelle version
- Historique des versions disponible
- Changelog dans `VERSION.md`

## 📝 Licence

Ce projet utilise le script d'archivage Webex original sous licence Cisco Sample Code License, Version 1.1.

## 🤝 Contribution

Les contributions sont les bienvenues ! N'hésitez pas à :
- Signaler des bugs
- Proposer des améliorations
- Soumettre des pull requests

---

**Développé par l'équipe IT interne pour l'archivage des espaces Webex de l'organisation.**
