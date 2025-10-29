# 🚀 Commandes Git pour uploader sur GitHub

## 📋 **Commandes complètes**

### **1. Aller dans le dossier du projet**
```bash
cd /Users/Joseph/Documents/export_webex
```

### **2. Initialiser Git (si pas déjà fait)**
```bash
git init
```

### **3. Ajouter le remote GitHub**
```bash
git remote add origin https://github.com/Josephdeveze/Webex_Archives.git
```

### **4. Copier le contenu préparé**
```bash
# Copier le contenu du dossier préparé vers le dossier courant
cp -r Webex_Archives/* .
```

### **5. Ajouter tous les fichiers**
```bash
git add .
```

### **6. Commiter les changements**
```bash
git commit -m "Version 1.0.0 - Application portable Webex Archive Manager

- Interface graphique moderne avec PyQt6
- Archivage en lot de plusieurs espaces
- Application totalement portable
- Support macOS et Windows
- Documentation complète
- Tests de portabilité intégrés"
```

### **7. Pousser vers GitHub**
```bash
git push -u origin main
```

## 🔄 **Commandes alternatives (si branche master)**

Si votre repository utilise `master` au lieu de `main` :

```bash
git push -u origin master
```

## 📋 **Script complet**

```bash
#!/bin/bash

echo "🚀 Upload du repository Webex_Archives sur GitHub..."

# Aller dans le dossier du projet
cd /Users/Joseph/Documents/export_webex

# Initialiser Git
echo "📁 Initialisation de Git..."
git init

# Ajouter le remote
echo "🔗 Ajout du remote GitHub..."
git remote add origin https://github.com/Josephdeveze/Webex_Archives.git

# Copier le contenu préparé
echo "📋 Copie du contenu préparé..."
cp -r Webex_Archives/* .

# Ajouter tous les fichiers
echo "➕ Ajout des fichiers..."
git add .

# Commiter
echo "💾 Commit des changements..."
git commit -m "Version 1.0.0 - Application portable Webex Archive Manager

- Interface graphique moderne avec PyQt6
- Archivage en lot de plusieurs espaces
- Application totalement portable
- Support macOS et Windows
- Documentation complète
- Tests de portabilité intégrés"

# Pousser vers GitHub
echo "🚀 Push vers GitHub..."
git push -u origin main

echo "✅ Repository uploadé avec succès sur GitHub !"
echo "🔗 https://github.com/Josephdeveze/Webex_Archives"
```

## 🚨 **En cas d'erreur**

### **Erreur : "remote origin already exists"**
```bash
git remote remove origin
git remote add origin https://github.com/Josephdeveze/Webex_Archives.git
```

### **Erreur : "fatal: refusing to merge unrelated histories"**
```bash
git pull origin main --allow-unrelated-histories
```

### **Erreur : "Authentication failed"**
```bash
# Utiliser un token GitHub au lieu du mot de passe
git remote set-url origin https://votre-token@github.com/Josephdeveze/Webex_Archives.git
```

## 📋 **Vérification**

Après l'upload, vérifiez que tout est correct :

```bash
# Vérifier le remote
git remote -v

# Vérifier le statut
git status

# Vérifier les commits
git log --oneline
```

## 🎯 **Résultat attendu**

Après ces commandes, votre repository GitHub contiendra :
- ✅ Application macOS dans `macos/`
- ✅ Code source dans `src/`
- ✅ Scripts dans `scripts/`
- ✅ Documentation complète
- ✅ README.md professionnel
- ✅ Guides utilisateur et contributeur
- ✅ Politique de sécurité

**Exécutez ces commandes et votre repository sera uploadé sur GitHub !** 🚀
