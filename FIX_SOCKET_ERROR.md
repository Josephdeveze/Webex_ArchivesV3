# 🔧 Solution pour l'erreur "No module named '_socket'"

## 📋 Problème

Lorsque l'application compilée est lancée sur un autre ordinateur Windows, l'erreur suivante apparaît :

```
ModuleNotFoundError: No module named '_socket'
```

Cette erreur se produit dans les fichiers suivants :
- `pyi_rth_multiprocessing.py`
- `pyimod02_importers.py`
- `multiprocessing/__init__.py`
- `multiprocessing/context.py`
- `multiprocessing/reduction.py`
- `socket.py`

## ✅ Solution appliquée

### 1. Mise à jour du fichier `.spec`

Le fichier `Webex Archive Manager.spec` a été modifié pour inclure tous les modules cachés nécessaires :

```python
hiddenimports=[
    '_socket',           # Module socket C (CRITIQUE)
    'socket',            # Module socket Python
    'select',            # Sélection I/O
    'selectors',         # Sélecteurs modernes
    '_ssl',              # SSL C
    'ssl',               # SSL Python
    'multiprocessing',   # Multiprocessing principal
    'multiprocessing.pool',
    'multiprocessing.reduction',
    'multiprocessing.synchronize',
    'multiprocessing.spawn',
    'multiprocessing.popen_spawn_win32',  # Spécifique Windows
    'multiprocessing.context',
    'multiprocessing.util',
    'queue',             # Files d'attente
    'threading',         # Threads
    'subprocess',        # Sous-processus
    'importlib',         # Import dynamique
    'importlib.util',
    'configparser',      # Configuration INI
    'requests',          # Requêtes HTTP
    'urllib3',           # Backend de requests
    'certifi',           # Certificats SSL
    'charset_normalizer',
    'idna',
    'PyQt6.QtCore',      # PyQt6
    'PyQt6.QtGui',
    'PyQt6.QtWidgets',
    'PyQt6.sip',
]
```

### 2. Script de compilation amélioré

Un nouveau script PowerShell `build_windows_fixed.ps1` a été créé avec :
- Vérification automatique de Python
- Installation/mise à jour des dépendances
- Nettoyage des anciens builds
- Compilation avec les bons paramètres
- Test optionnel de l'application

## 🚀 Comment recompiler l'application

### Méthode 1 : PowerShell (Recommandé)

1. Ouvrez PowerShell dans le dossier du projet
2. Exécutez :
   ```powershell
   .\build_windows_fixed.ps1
   ```

### Méthode 2 : Ligne de commande manuelle

```bash
# Nettoyer
rmdir /s /q build dist

# Compiler
pyinstaller --clean --noconfirm "Webex Archive Manager.spec"
```

## 📦 Distribution de l'application

Après compilation :

1. **Compressez** le dossier `dist\Webex Archive Manager` en ZIP
2. **Envoyez** le fichier ZIP à vos utilisateurs
3. **Instructions utilisateur** :
   - Décompresser le ZIP
   - Lancer `Webex Archive Manager.exe`
   - Si Windows affiche un avertissement :
     - Cliquer sur "Plus d'informations"
     - Puis "Exécuter quand même"

## 🔍 Pourquoi cette erreur se produit ?

PyInstaller ne détecte pas automatiquement tous les modules C intégrés à Python, notamment :

- **`_socket`** : Module C pour les sockets réseau (utilisé par `requests`)
- **`_ssl`** : Module C pour SSL/TLS (utilisé par HTTPS)
- **Modules multiprocessing** : Nécessaires pour PyQt6 et les threads

Ces modules doivent être explicitement déclarés dans `hiddenimports` du fichier `.spec`.

## ⚠️ Modules critiques pour Windows

Sur Windows, ces modules sont particulièrement importants :

- `multiprocessing.popen_spawn_win32` : Gestion des processus Windows
- `_socket` : Sockets réseau
- `_ssl` : Connexions HTTPS sécurisées
- `PyQt6.sip` : Interface C++ de PyQt6

## 🧪 Vérification

Pour vérifier que l'application fonctionne correctement :

1. **Sur votre machine de développement** :
   - Compilez avec le nouveau script
   - Testez l'exécutable dans `dist\`

2. **Sur une machine vierge** (sans Python installé) :
   - Copiez le dossier `dist\Webex Archive Manager`
   - Lancez l'exécutable
   - Testez les fonctionnalités principales :
     - Connexion avec token Webex
     - Chargement des espaces
     - Archivage d'un espace

## 📝 Notes techniques

- **PyInstaller version** : ≥5.13.0 recommandé
- **Python version** : 3.8+ recommandé
- **PyQt6 version** : ≥6.4.0 requis
- **Taille de l'application** : ~150-200 MB (normal pour PyQt6)

## 🆘 En cas de problème

Si l'erreur persiste après recompilation :

1. Vérifiez que vous utilisez le fichier `.spec` mis à jour
2. Supprimez complètement les dossiers `build` et `dist`
3. Recompilez avec `--clean`
4. Vérifiez les logs de PyInstaller pour d'autres erreurs

## 📚 Ressources

- [PyInstaller Documentation](https://pyinstaller.org/)
- [PyQt6 Documentation](https://www.riverbankcomputing.com/static/Docs/PyQt6/)
- [Python multiprocessing](https://docs.python.org/3/library/multiprocessing.html)
