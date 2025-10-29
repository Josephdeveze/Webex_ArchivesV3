# Runtime hook pour forcer le chargement des modules socket et ssl
# Ce hook s'execute AVANT le code principal de l'application

import sys
import os

# CRITICAL FIX: Utiliser os.add_dll_directory() pour Python 3.8+
# C'est la methode officielle pour ajouter des chemins de recherche DLL
exe_dir = os.path.dirname(sys.executable)

print(f"[HOOK] Executable directory: {exe_dir}")

# Methode 1: add_dll_directory (Python 3.8+)
if hasattr(os, 'add_dll_directory'):
    try:
        os.add_dll_directory(exe_dir)
        print(f"[HOOK] Added DLL directory: {exe_dir}")
    except Exception as e:
        print(f"[HOOK] Failed to add DLL directory: {e}")

# Methode 2: Modifier PATH
old_path = os.environ.get('PATH', '')
os.environ['PATH'] = exe_dir + os.pathsep + old_path
print(f"[HOOK] Added to PATH: {exe_dir}")

# Methode 3: Ajouter au sys.path
if exe_dir not in sys.path:
    sys.path.insert(0, exe_dir)
    print(f"[HOOK] Added to sys.path: {exe_dir}")

print(f"[HOOK] sys.path[0:2] = {sys.path[0:2]}")

# Forcer l'import des modules critiques des le demarrage
try:
    import _socket
    print("[OK] _socket loaded successfully")
except ImportError as e:
    print(f"[ERROR] Failed to load _socket: {e}")
    
try:
    import socket
    print("[OK] socket loaded successfully")
except ImportError as e:
    print(f"[ERROR] Failed to load socket: {e}")

try:
    import _ssl
    print("[OK] _ssl loaded successfully")
except ImportError as e:
    print(f"[ERROR] Failed to load _ssl: {e}")

try:
    import ssl
    print("[OK] ssl loaded successfully")
except ImportError as e:
    print(f"[ERROR] Failed to load ssl: {e}")

try:
    import select
    print("[OK] select loaded successfully")
except ImportError as e:
    print(f"[ERROR] Failed to load select: {e}")

# Afficher les chemins de recherche pour debug
print(f"[DEBUG] sys.path: {sys.path[:3]}")
print(f"[DEBUG] sys.executable: {sys.executable}")
