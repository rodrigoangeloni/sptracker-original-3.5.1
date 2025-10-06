# Configuración para build con WSL Debian# Configuración mínima para build solo en Windows

# Este archivo configura tanto builds de Windows como de Linux via WSLgit = r"C:\Program Files\Git\bin\git.exe"



git = r"C:\Program Files\Git\bin\git.exe"# No usamos build remoto (solo Windows)

REMOTE_BUILD_CMD = None

# Configuración para build remoto en WSL DebianREMOTE_COPY_RESULT = None

remote_path = "/mnt/c/Users/Rodrigo.DESKTOP-I1TEA6K/source/repos/sptracker-original-3.5.1"
wsl_distro = "Debian"
host = "local-wsl"  # Identificador para WSL local

# Comando para ejecutar build en WSL Debian
# WSL comparte el filesystem de Windows, así que no necesitamos plink/ssh
# El script build_linux.sh maneja toda la configuración automáticamente
REMOTE_BUILD_CMD = [
    "wsl", 
    "-d", wsl_distro, 
    "--cd", remote_path,
    "bash", "-c",
    "chmod +x build_linux.sh && dos2unix build_linux.sh 2>/dev/null || true && ./build_linux.sh 3.5.2"
]

# No necesitamos copiar resultados porque WSL comparte el filesystem
# El resultado estará directamente en stracker/dist/stracker
REMOTE_COPY_RESULT = None

# Notas:
# - WSL permite acceder a archivos de Windows via /mnt/c/
# - El build_linux.sh creará su propio virtualenv Linux
# - Los binarios quedan en la misma carpeta del proyecto
# - No se requiere plink, putty, ni SSH
