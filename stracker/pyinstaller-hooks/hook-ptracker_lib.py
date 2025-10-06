# PyInstaller hook for ptracker_lib package
# Forces inclusion of ALL modules in ptracker_lib since --hidden-import isn't working

from PyInstaller.utils.hooks import collect_submodules

# Collect all submodules from ptracker_lib
hiddenimports = collect_submodules('ptracker_lib')

print(f"ptracker_lib hook: Found {len(hiddenimports)} submodules: {hiddenimports}")
