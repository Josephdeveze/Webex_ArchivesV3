# 🚀 Webex Archive Manager (Windows)

Application portable pour archiver les espaces de messages Webex avec une interface graphique moderne. Ce dépôt a été simplifié pour un usage Windows (build et exécution). Toutes les fonctionnalités sont conservées.

## ✨ Fonctionnalités

- 📱 Interface graphique moderne (PyQt6)
- 🔍 Recherche et filtrage des espaces
- 📦 Archivage en lot de plusieurs espaces
- 📁 Organisation automatique des fichiers téléchargés
- 🎨 Génération de fichiers HTML avec CSS
- 📊 Export optionnel en JSON
- 🔒 Token Webex conservé localement (profil utilisateur)

## 📦 Téléchargement et exécution (Windows 10/11)

1. Téléchargez `dist\Webex_Archive_Manager_Windows.zip`
2. Décompressez le ZIP
3. Double‑cliquez sur `Webex Archive Manager.exe`
4. Si SmartScreen s’affiche: “Plus d’informations” > “Exécuter quand même”

## 🧭 Utilisation

1. Obtenez un token Webex sur `developer.webex.com`
2. Collez le token dans l’interface
3. Cliquez sur “Charger les espaces”
4. Sélectionnez les espaces
5. Cliquez sur “Archiver la sélection”

Notes:
- La configuration `webexspacearchive-config.ini` est gérée automatiquement dans un dossier inscriptible à côté de l’exécutable: `Webex Archive\webexspacearchive-config.ini`
- Les archives sont générées dans: `Webex Archives\<Nom de l’espace>\...`

## 🛠️ Rebuild local (développeurs)

Prérequis: Python 3.9+, pip.

```powershell
pip install -r requirements.txt
pyinstaller --noconfirm --clean --name "Webex Archive Manager" --windowed --add-data "Webex Archive;Webex Archive" webex_gui.py
```

Ou via scripts:

- CMD: `build_windows.bat`
- PowerShell: `powershell -ExecutionPolicy Bypass -File .\build_windows.ps1`

Le binaire se trouve dans `dist\Webex Archive Manager\Webex Archive Manager.exe` et un ZIP prêt à l’emploi peut être créé dans `dist\Webex_Archive_Manager_Windows.zip`.

## 📁 Structure minimale conservée

```
Webex_Archives-master/
├── Webex Archive/
│   ├── webex-space-archive.py
│   ├── webexspacearchive-config.ini
│   └── README.md
├── webex_gui.py
├── requirements.txt
├── build_windows.bat
├── build_windows.ps1
├── build_universal.sh
├── docs/
└── dist/
```

## 🔒 Sécurité

- Le token Webex est stocké localement (fichier de préférences utilisateur)
- Les archives sont créées localement, aucune donnée envoyée à des tiers

## 📝 Licence

Ce projet utilise le script d’archivage Webex original sous licence Cisco Sample Code License, Version 1.1.

## 🤝 Support et contribution

- Consultez `docs/`
- Créez une issue pour tout bug/évolution
- Les MR/PR sont les bienvenues
