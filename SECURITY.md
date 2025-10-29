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
