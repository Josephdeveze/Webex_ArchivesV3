# 🔍 Diagnostic du Problème de Lancement

## 📋 Symptômes

- L'exécutable ne lance pas l'interface graphique
- Le processus démarre mais aucune fenêtre ne s'affiche
- Pas de message d'erreur visible

## 🎯 Cause Probable

**Plugins Qt manquants** - PyQt6 nécessite des plugins de plateforme (comme `qwindows.dll`) pour afficher les fenêtres sur Windows.

## ✅ Solutions à Essayer

### Solution 1 : Vérifier les plugins Qt (Recommandé)

Vérifiez si le dossier contient les plugins Qt :

```powershell
Get-ChildItem "build\exe.win-amd64-3.13\lib\PyQt6\Qt6\plugins\platforms" -ErrorAction SilentlyContinue
```

Vous devriez voir `qwindows.dll`. Si ce fichier manque, c'est la cause du problème.

### Solution 2 : Tester en mode développement

Lancez l'application directement avec Python pour voir si elle fonctionne :

```powershell
python webex_gui.py
```

Si ça fonctionne en Python mais pas en cx_Freeze, c'est un problème de packaging.

### Solution 3 : Vérifier les DLL Qt

```powershell
Get-ChildItem "build\exe.win-amd64-3.13\lib\PyQt6\Qt6\bin" | Select-Object Name
```

Vérifiez la présence de :
- `Qt6Core.dll`
- `Qt6Gui.dll`
- `Qt6Widgets.dll`

### Solution 4 : Variable d'environnement QT_PLUGIN_PATH

Créez un fichier `qt.conf` à côté de l'exécutable :

```ini
[Paths]
Prefix = .
Plugins = lib/PyQt6/Qt6/plugins
```

## 🔧 Fix Automatique

Créons un script qui copie manuellement les plugins Qt si nécessaire.

### Étape 1 : Vérifier la structure

```powershell
cd "build\exe.win-amd64-3.13"
tree /F lib\PyQt6\Qt6\plugins
```

### Étape 2 : Créer qt.conf

Créez un fichier `qt.conf` dans `build\exe.win-amd64-3.13\` :

```ini
[Paths]
Prefix = .
Plugins = lib/PyQt6/Qt6/plugins
Binaries = lib/PyQt6/Qt6/bin
```

### Étape 3 : Retester

```powershell
& "build\exe.win-amd64-3.13\Webex Archive Manager.exe"
```

## 🎯 Solution Alternative : Utiliser PyInstaller avec Python 3.11

Si cx_Freeze continue à poser problème avec PyQt6, la solution la plus fiable est :

1. Installer Python 3.11
2. Utiliser PyInstaller (qui fonctionne parfaitement avec Python 3.11)
3. Recompiler

### Commandes :

```powershell
# Installer Python 3.11
py -3.11 -m venv venv311
.\venv311\Scripts\activate
pip install PyQt6 requests pyinstaller

# Compiler
pyinstaller --clean --noconfirm "Webex Archive Manager.spec"
```

## 📊 Comparaison des Options

| Solution | Difficulté | Fiabilité | Temps |
|----------|------------|-----------|-------|
| Fix qt.conf | ⭐ Facile | ⭐⭐⭐ Moyenne | 5 min |
| Python 3.11 + PyInstaller | ⭐⭐ Moyenne | ⭐⭐⭐⭐⭐ Excellente | 15 min |
| Debug cx_Freeze | ⭐⭐⭐ Difficile | ⭐⭐ Incertaine | 1h+ |

## 🎯 Ma Recommandation

**Essayez d'abord la solution qt.conf** (5 minutes).

Si ça ne fonctionne pas, **passez à Python 3.11 + PyInstaller** (solution éprouvée).

---

**Prochaine étape :** Dites-moi ce que vous voyez quand vous lancez l'application :
- Rien du tout ?
- Processus qui démarre mais pas de fenêtre ?
- Une erreur ?
