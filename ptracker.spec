# -*- mode: python ; coding: utf-8 -*-


block_cipher = None


a = Analysis(
    ['ptracker-server-dist.py'],
    pathex=['stracker'],
    binaries=[],
    datas=[],
    hiddenimports=[],
    hookspath=['stracker/pyinstaller-hooks'],
    hooksconfig={},
    runtime_hooks=[],
    excludes=['acsys', 'ac', 'apps', '_ctypes', 'unicodedata', '_imagingft', 'ptracker_lib.stdlib', 'ptracker_lib.stdlib64'],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
    noarchive=False,
)
pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.zipfiles,
    a.datas,
    [],
    name='ptracker',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=False,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)
