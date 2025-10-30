# 🔄 Changer le Remote Git

## Problème
Le dossier `Webex_ArchivesV2` est une copie de l'ancien projet et contient donc l'ancien remote Git.

## Solution

### Étape 1 : Voir le remote actuel
```bash
git remote -v
```

Vous verrez quelque chose comme :
```
origin  https://github.com/ancien-repo.git (fetch)
origin  https://github.com/ancien-repo.git (push)
```

### Étape 2 : Supprimer l'ancien remote
```bash
git remote remove origin
```

### Étape 3 : Ajouter le nouveau remote
```bash
git remote add origin https://github.com/VOTRE-USERNAME/NOUVEAU-REPO.git
```

Remplacez `VOTRE-USERNAME/NOUVEAU-REPO` par votre nouveau dépôt.

### Étape 4 : Vérifier
```bash
git remote -v
```

Vous devriez maintenant voir le nouveau remote.

---

## Alternative : Modifier le remote existant

Si vous préférez modifier le remote au lieu de le supprimer :

```bash
git remote set-url origin https://github.com/VOTRE-USERNAME/NOUVEAU-REPO.git
```

---

## Commandes Complètes (Copier-Coller)

### Option A : Supprimer et recréer
```bash
cd "C:\Users\Joseph_Deveze\Downloads\Webex_ArchivesV2"
git remote remove origin
git remote add origin https://github.com/VOTRE-USERNAME/NOUVEAU-REPO.git
git remote -v
```

### Option B : Modifier l'URL
```bash
cd "C:\Users\Joseph_Deveze\Downloads\Webex_ArchivesV2"
git remote set-url origin https://github.com/VOTRE-USERNAME/NOUVEAU-REPO.git
git remote -v
```

---

## Après avoir changé le remote

### Push vers le nouveau dépôt
```bash
# Ajouter tous les fichiers
git add .

# Commit
git commit -m "Migration vers cx_Freeze - Application fonctionnelle"

# Push (première fois)
git push -u origin main
```

Si la branche s'appelle `master` au lieu de `main` :
```bash
git push -u origin master
```

---

## En cas d'erreur "branch not found"

Si vous avez une erreur sur le nom de la branche :

```bash
# Vérifier le nom de la branche actuelle
git branch

# Renommer en main si nécessaire
git branch -M main

# Push
git push -u origin main
```

---

## 📝 Résumé Rapide

**Commande la plus simple (recommandée) :**
```bash
git remote set-url origin https://github.com/VOTRE-URL-ICI.git
```

Remplacez `https://github.com/VOTRE-URL-ICI.git` par l'URL de votre nouveau dépôt GitHub.
