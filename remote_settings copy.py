# Use this file as a template for your own remote_settings.py

# this python file is used to configure the linux build
plink = r"C:\Program Files\PuTTY\plink.exe"
pscp = r"C:\Program Files\PuTTY\pscp.exe"
git = r"C:\Program Files\Git\cmd\git.exe"

# Configuración para WSL como si fuera una PC Linux en LAN
# WSL se trata como máquina remota independiente con su propio filesystem
remote_path = "~/sptracker-build"
host = "roan@172.22.51.140"
password = "123"

# command executed to start remote build
# Primero sincroniza el código al directorio remoto, luego ejecuta el build
REMOTE_BUILD_CMD = [
    plink, "-pw", password, host,
    f"rm -rf {remote_path} && "
    f"mkdir -p {remote_path} && "
    f"cp -r /mnt/c/Users/Rodrigo/source/repos/sptracker-original-3.5.1/* {remote_path}/ && "
    f"cd {remote_path} && sh create_release.sh"
]

# command to copy the resulting tar.gz file into the local filesystem
# Copia desde el directorio nativo de Linux (no desde /mnt/c/)
# Nota: pscp no expande ~ correctamente, usar ruta absoluta
REMOTE_COPY_RESULT = [
    pscp,
    "-pw", password,
    f"{host}:/home/roan/sptracker-build/stracker/stracker_linux_x86.tgz",
    "stracker/stracker_linux_x86.tgz"
]
