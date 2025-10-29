"""
Script post-build pour copier les fichiers .pyd critiques à la racine
Ce script doit être exécuté APRÈS pyinstaller
"""

import os
import shutil
import sys

# Chemins
python_dlls = os.path.join(sys.base_prefix, 'DLLs')
dist_root = os.path.join(os.path.dirname(__file__), 'dist', 'Webex Archive Manager')

# Fichiers à copier
files_to_copy = [
    '_socket.pyd',
    '_ssl.pyd',
    'select.pyd',
    'libssl-3.dll',
    'libcrypto-3.dll',
]

print("=" * 80)
print("POST-BUILD FIX: Copie des fichiers .pyd à la racine")
print("=" * 80)

for filename in files_to_copy:
    src = os.path.join(python_dlls, filename)
    dst = os.path.join(dist_root, filename)
    
    if os.path.exists(src):
        try:
            shutil.copy2(src, dst)
            print(f"[OK] Copie: {filename}")
        except Exception as e:
            print(f"[ERROR] Erreur pour {filename}: {e}")
    else:
        print(f"[WARNING] Fichier source introuvable: {filename}")

print("=" * 80)
print("FIX TERMINÉ - Les fichiers sont maintenant à la racine du dossier dist")
print("=" * 80)
