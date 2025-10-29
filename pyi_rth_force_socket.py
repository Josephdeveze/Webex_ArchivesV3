# Runtime hook pour forcer le chargement des modules socket et ssl
# Ce hook s'execute AVANT le code principal de l'application

import sys
import os

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
