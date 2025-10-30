# 🔍 Diagnostic - Application ne démarre pas sur autre machine

## Problème
L'application ne se lance pas quand vous double-cliquez dessus sur l'autre machine.

## ✅ Vérifications à Faire

### 1. Vérifier que TOUS les fichiers sont présents

Dans le dossier `exe.win-amd64-3.13\`, vous devez avoir :

```
☐ Webex Archive Manager.exe (23 KB)
☐ qt.conf (fichier texte, ~100 bytes) ← CRITIQUE !
☐ Dossier lib\
☐ Dossier Webex Archive\
☐ Fichiers .dll (python313.dll, vcruntime140.dll, etc.)
```

**Le fichier `qt.conf` est ESSENTIEL !** S'il manque, l'application ne démarre pas.

### 2. Tester en ligne de commande

Sur l'autre machine, ouvrez PowerShell dans le dossier et lancez :

```powershell
& ".\Webex Archive Manager.exe"
```

Cela affichera les erreurs éventuelles.

### 3. Vérifier les DLL manquantes

L'application peut manquer de DLL Visual C++ Runtime. Téléchargez et installez :

**Visual C++ Redistributable 2015-2022 (x64)**
https://aka.ms/vs/17/release/vc_redist.x64.exe

### 4. Vérifier Windows Defender

Windows Defender peut bloquer l'application. Vérifiez :
- Paramètres → Sécurité Windows → Protection contre les virus
- Historique de protection
- Si bloqué, ajouter une exception

## 🔧 Solutions

### Solution 1 : Recréer le package complet

Sur votre machine de développement :

```powershell
# 1. Aller dans le dossier
cd "C:\Users\Joseph_Deveze\Downloads\Webex_ArchivesV2"

# 2. Vérifier que qt.conf existe
Get-Content "build\exe.win-amd64-3.13\qt.conf"

# 3. Créer le ZIP avec TOUT
Compress-Archive -Path "build\exe.win-amd64-3.13\*" -DestinationPath "Webex_Archive_Complete.zip" -Force
```

### Solution 2 : Tester en mode console

Modifiez `setup.py` pour activer temporairement la console :

```python
# Ligne 68-69
base = None  # Activer la console pour voir les erreurs
# if sys.platform == "win32":
#     base = "Win32GUI"
```

Recompilez et testez sur l'autre machine. Vous verrez les erreurs.

### Solution 3 : Vérifier les dépendances

Sur l'autre machine, téléchargez et lancez :
https://github.com/lucasg/Dependencies/releases

Glissez `Webex Archive Manager.exe` dedans pour voir les DLL manquantes.

## 📋 Checklist Complète

Sur l'autre machine, vérifiez :

- [ ] Tous les fichiers du dossier sont présents
- [ ] Le fichier `qt.conf` existe
- [ ] Visual C++ Redistributable installé
- [ ] Windows Defender n'a pas bloqué l'application
- [ ] Pas d'antivirus tiers qui bloque
- [ ] Windows 10/11 64 bits

## 🎯 Test Rapide

Sur votre machine de développement, créez un script de test :

```powershell
# test_package.ps1
$folder = "build\exe.win-amd64-3.13"

Write-Host "Vérification du package..." -ForegroundColor Yellow
Write-Host ""

# Vérifier l'EXE
if (Test-Path "$folder\Webex Archive Manager.exe") {
    Write-Host "[OK] Webex Archive Manager.exe" -ForegroundColor Green
} else {
    Write-Host "[ERREUR] Webex Archive Manager.exe manquant !" -ForegroundColor Red
}

# Vérifier qt.conf
if (Test-Path "$folder\qt.conf") {
    Write-Host "[OK] qt.conf" -ForegroundColor Green
    Write-Host "    Contenu:"
    Get-Content "$folder\qt.conf" | ForEach-Object { Write-Host "    $_" }
} else {
    Write-Host "[ERREUR] qt.conf manquant ! L'application ne démarrera pas !" -ForegroundColor Red
}

# Vérifier lib
if (Test-Path "$folder\lib") {
    Write-Host "[OK] Dossier lib\" -ForegroundColor Green
} else {
    Write-Host "[ERREUR] Dossier lib\ manquant !" -ForegroundColor Red
}

# Vérifier Webex Archive
if (Test-Path "$folder\Webex Archive") {
    Write-Host "[OK] Dossier Webex Archive\" -ForegroundColor Green
} else {
    Write-Host "[ERREUR] Dossier Webex Archive\ manquant !" -ForegroundColor Red
}

# Vérifier python313.dll
if (Test-Path "$folder\python313.dll") {
    Write-Host "[OK] python313.dll" -ForegroundColor Green
} else {
    Write-Host "[ERREUR] python313.dll manquant !" -ForegroundColor Red
}

Write-Host ""
Write-Host "Vérification terminée." -ForegroundColor Yellow
```

Lancez ce script pour vérifier le package avant de le copier.

## 🚨 Cause Probable

**Le fichier `qt.conf` manque probablement !**

Ce fichier doit être créé APRÈS chaque compilation car il n'est pas inclus automatiquement par cx_Freeze.

## ✅ Solution Définitive

Modifiez `setup.py` pour inclure automatiquement `qt.conf` :

```python
"include_files": [
    ("Webex Archive", "Webex Archive"),
    ("qt.conf", "qt.conf"),  # Ajouter cette ligne
],
```

Mais d'abord, créez `qt.conf` à la racine du projet avec ce contenu :

```ini
[Paths]
Prefix = .
Plugins = lib/PyQt6/Qt6/plugins
Binaries = lib/PyQt6/Qt6/bin
```

Puis recompilez.
