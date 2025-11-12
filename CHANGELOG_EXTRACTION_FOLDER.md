# Modification - Dossier d'Extraction

**Date :** 12 novembre 2025 11:58  
**Version :** 1.2.1  
**Modification :** Changement du dossier de sortie des archives

---

## 🔄 Changement Effectué

### Avant (v1.2.0)
Les archives étaient créées dans :
- **"Webex Archives"** - Dossier de sortie des archives HTML
- **"Webex Archive"** - Dossier de configuration

### Après (v1.2.1)
Les archives sont créées dans :
- **"extraction"** - Dossier unique pour les archives ET la configuration

---

## 📝 Détails Techniques

### Fichier Modifié
- `webex_gui.py` (lignes 51 et 61)

### Modifications
```python
# AVANT
output_dir = os.path.join(app_dir, "Webex Archives")
external_webex_dir = os.path.join(app_dir, "Webex Archive")

# APRÈS
output_dir = os.path.join(app_dir, "extraction")
external_webex_dir = os.path.join(app_dir, "extraction")
```

### Résultat
- ✅ Dossier unique "extraction" pour toutes les données
- ✅ Configuration et archives au même endroit
- ✅ Plus simple et plus clair pour l'utilisateur

---

## 📂 Nouvelle Structure

```
Webex Archive Manager/
├── Webex Archive Manager.exe
├── qt.conf
├── README_UTILISATEUR.md
├── QUICK_START.txt
├── lib/
├── Webex Archive/
└── extraction/                    ← NOUVEAU
    ├── webexspacearchive-config.ini
    ├── Archive_Espace1.html
    ├── Archive_Espace2.html
    └── Espace1_files/
```

---

## ✅ Avantages

1. **Clarté** - Un seul dossier pour les données
2. **Organisation** - Configuration et archives ensemble
3. **Portabilité** - Facile à sauvegarder/déplacer
4. **Nettoyage** - Supprimer "extraction" = supprimer tout

---

## 🔄 Compatibilité

### Anciennes Archives
Les archives créées avec v1.2.0 dans "Webex Archives" restent accessibles.

### Migration
Aucune migration nécessaire. Les utilisateurs peuvent :
1. Garder les anciennes archives dans "Webex Archives"
2. Créer les nouvelles dans "extraction"

---

## 📦 Package Mis à Jour

**Fichier :** `Webex_Archive_Manager_v1.2_FINAL.zip`  
**Date :** 12 novembre 2025 11:58  
**Taille :** 74.41 MB

---

## 🎯 Prochaines Étapes

Aucune action requise. L'application fonctionne normalement avec le nouveau dossier "extraction".

---

**Statut :** ✅ Complété et testé
