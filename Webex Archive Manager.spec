# -*- mode: python ; coding: utf-8 -*-
import sys
import os

# Chemin vers le dossier DLLs de Python
python_dlls = os.path.join(sys.base_prefix, 'DLLs')

# Binaires critiques à inclure explicitement
critical_binaries = [
    (os.path.join(python_dlls, '_socket.pyd'), '.'),
    (os.path.join(python_dlls, '_ssl.pyd'), '.'),
    (os.path.join(python_dlls, 'select.pyd'), '.'),
    (os.path.join(python_dlls, 'libssl-3.dll'), '.'),
    (os.path.join(python_dlls, 'libcrypto-3.dll'), '.'),
]

# Filtrer uniquement les fichiers qui existent
binaries_to_add = [(src, dst) for src, dst in critical_binaries if os.path.exists(src)]

a = Analysis(
    ['webex_gui.py'],
    pathex=[],
    binaries=binaries_to_add,
    datas=[('Webex Archive', 'Webex Archive')],
    hiddenimports=[
        'socket',
        'ssl',
        'select',
        'selectors',
        'multiprocessing',
        'multiprocessing.pool',
        'multiprocessing.reduction',
        'multiprocessing.synchronize',
        'multiprocessing.spawn',
        'multiprocessing.popen_spawn_win32',
        'multiprocessing.context',
        'multiprocessing.util',
        'multiprocessing.heap',
        'multiprocessing.queues',
        'multiprocessing.managers',
        'multiprocessing.sharedctypes',
        'queue',
        'threading',
        'subprocess',
        'importlib',
        'importlib.util',
        'configparser',
        'requests',
        'urllib3',
        'urllib3.util',
        'urllib3.util.retry',
        'urllib3.util.ssl_',
        'urllib3.connection',
        'urllib3.connectionpool',
        'certifi',
        'charset_normalizer',
        'idna',
        'PyQt6.QtCore',
        'PyQt6.QtGui',
        'PyQt6.QtWidgets',
        'PyQt6.sip',
        'json',
        'pathlib',
        'shutil',
        'io',
        'traceback',
    ],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
    optimize=0,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    [],
    exclude_binaries=True,
    name='Webex Archive Manager',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)
coll = COLLECT(
    exe,
    a.binaries,
    a.datas,
    strip=False,
    upx=True,
    upx_exclude=[],
    name='Webex Archive Manager',
)
