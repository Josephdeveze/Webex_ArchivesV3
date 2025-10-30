"""
Configuration cx_Freeze pour Webex Archive Manager
Compatible avec Python 3.13
"""

import sys
from cx_Freeze import setup, Executable

# Dépendances à inclure
build_exe_options = {
    "packages": [
        # PyQt6
        "PyQt6",
        "PyQt6.QtCore",
        "PyQt6.QtGui",
        "PyQt6.QtWidgets",
        # Réseau et HTTP
        "requests",
        "urllib3",
        "certifi",
        "charset_normalizer",
        "idna",
        "socket",
        "ssl",
        "_socket",
        "_ssl",
        "select",
        # Multiprocessing
        "multiprocessing",
        "multiprocessing.pool",
        "multiprocessing.reduction",
        "multiprocessing.synchronize",
        "multiprocessing.spawn",
        "multiprocessing.context",
        "multiprocessing.util",
        # Autres modules standard
        "subprocess",
        "json",
        "configparser",
        "pathlib",
        "shutil",
        "io",
        "traceback",
        "importlib",
        "importlib.util",
    ],
    "excludes": [
        # Exclure les modules inutiles pour réduire la taille
        "tkinter",
        "unittest",
        "email",
        "http.server",
        "xmlrpc",
        "pydoc",
    ],
    "include_files": [
        # Inclure le dossier Webex Archive
        ("Webex Archive", "Webex Archive"),
        # Inclure qt.conf (CRITIQUE pour PyQt6)
        ("qt.conf", "qt.conf"),
    ],
    "include_msvcr": True,  # Inclure les DLL Visual C++ Runtime
    "zip_include_packages": [],  # Ne rien compresser dans library.zip
    "zip_exclude_packages": ["*"],  # Tout exclure de la compression
    "optimize": 0,
}

# Configuration de l'exécutable
# MODE CONSOLE ACTIVÉ POUR DEBUG
base = None
# if sys.platform == "win32":
#     base = "Win32GUI"  # Pas de console sur Windows

executables = [
    Executable(
        "webex_gui.py",
        base=base,
        target_name="Webex Archive Manager.exe",
        icon=None,  # Vous pouvez ajouter un .ico ici si vous en avez un
    )
]

# Configuration du setup
setup(
    name="Webex Archive Manager",
    version="1.0.0",
    description="Application pour archiver les espaces Webex",
    author="Joseph Deveze",
    options={"build_exe": build_exe_options},
    executables=executables,
)
