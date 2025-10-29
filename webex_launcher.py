"""
Launcher pour Webex Archive Manager
Ce script précharge les modules critiques avant de lancer l'application principale
"""

import sys
import os

# Ajouter le répertoire de l'exécutable au PATH système
if getattr(sys, 'frozen', False):
    exe_dir = os.path.dirname(sys.executable)
    
    # Ajouter au PATH Windows
    os.environ['PATH'] = exe_dir + os.pathsep + os.environ.get('PATH', '')
    
    # Ajouter au sys.path Python
    if exe_dir not in sys.path:
        sys.path.insert(0, exe_dir)
    
    # Forcer le chargement des DLL depuis le répertoire de l'exe
    if hasattr(os, 'add_dll_directory'):
        os.add_dll_directory(exe_dir)

# Précharger les modules critiques avec gestion d'erreur détaillée
print("[LAUNCHER] Preloading critical modules...")

try:
    import _socket
    print("[LAUNCHER] OK: _socket")
except Exception as e:
    print(f"[LAUNCHER] ERROR _socket: {e}")
    import traceback
    traceback.print_exc()

try:
    import socket  
    print("[LAUNCHER] OK: socket")
except Exception as e:
    print(f"[LAUNCHER] ERROR socket: {e}")

try:
    import _ssl
    print("[LAUNCHER] OK: _ssl")
except Exception as e:
    print(f"[LAUNCHER] ERROR _ssl: {e}")

try:
    import ssl
    print("[LAUNCHER] OK: ssl")
except Exception as e:
    print(f"[LAUNCHER] ERROR ssl: {e}")

try:
    import select
    print("[LAUNCHER] OK: select")
except Exception as e:
    print(f"[LAUNCHER] ERROR select: {e}")

print("[LAUNCHER] Preloading complete. Starting main application...")
print()

# Maintenant importer et lancer l'application principale
try:
    from webex_gui import main
    main()
except Exception as e:
    print(f"[LAUNCHER] FATAL ERROR: {e}")
    import traceback
    traceback.print_exc()
    input("Press Enter to exit...")
    sys.exit(1)
