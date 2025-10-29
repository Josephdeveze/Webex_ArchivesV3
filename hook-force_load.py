# Hook PyInstaller pour forcer le chargement des modules C
# Ce fichier doit être dans le dossier du projet

from PyInstaller.utils.hooks import collect_dynamic_libs, collect_data_files
import os
import sys

# Forcer l'inclusion des binaires
binaries = []
datas = []

# Chemin vers les DLLs Python
if sys.platform == 'win32':
    python_dir = os.path.dirname(sys.executable)
    dlls_dir = os.path.join(python_dir, 'DLLs')
    
    # Liste des fichiers critiques
    critical_files = [
        '_socket.pyd',
        '_ssl.pyd',
        'select.pyd',
        'libssl-3.dll',
        'libcrypto-3.dll',
        'libffi-8.dll',
    ]
    
    for filename in critical_files:
        src = os.path.join(dlls_dir, filename)
        if os.path.exists(src):
            # Copier à la racine ET dans _internal
            binaries.append((src, '.'))
            binaries.append((src, '_internal'))
