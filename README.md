# Proyecto Final UNIX

Este repositorio contiene las dos partes del proyecto final de la materia de UNIX.

## Parte 1: Sistema Gestor de Alumnos (Bash)
Ubicado en la carpeta `parte1_shell`. Es un script en Bash que gestiona un archivo de datos (`alumnos.txt`) permitiendo realizar altas, bajas, consultas, modificaciones y 3 reportes.

## Parte 2: Juego Snake en C (Makefile)
Ubicado en la carpeta `parte2_compilado`. Es una versión del clásico juego Snake para terminal, escrito en C y automatizado con un `Makefile`.

---

## 🛠️ Guía Completa de Instalación y Ejecución (Para los miembros del equipo)

Para poder correr este proyecto en sus computadoras con Windows, necesitan tener un entorno UNIX instalado. Sigan estos pasos al pie de la letra para instalar y configurar **WSL (Windows Subsystem for Linux)**.

### Paso 1: Instalación de WSL
1. Abran **PowerShell** como Administrador (clic derecho -> Ejecutar como administrador).
2. Ejecuten el siguiente comando:
   ```powershell
   wsl --install
   ```
3. Dejen que termine el proceso y **REINICIEN SU COMPUTADORA**.

### Paso 2: Solución de Problemas (Si WSL no "despierta")
Si al reiniciar abren Ubuntu y les sale el error `0x8007019e (The Windows Subsystem for Linux has not been enabled)` o `Package could not be registered`, hagan lo siguiente:
1. Vuelvan a abrir **PowerShell como Administrador**.
2. Ejecuten estos dos comandos uno por uno para forzar el encendido de los motores de Linux:
   ```powershell
   dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
   dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
   ```
3. **Vuelvan a reiniciar su computadora.**
4. Abran la aplicación de la **Microsoft Store** (Tienda de Windows).
5. Busquen **"Ubuntu"** y denle en Instalar u Obtener.
6. Abran Ubuntu desde su menú de inicio, dejen que termine de instalar ("Installing, this may take a few minutes...") y creen su usuario y contraseña de Linux.

### Paso 3: Instalación de Dependencias del Proyecto
Una vez que ya estén dentro de la terminal negra de Ubuntu (`usuario@DESKTOP:~$`), necesitan instalar el compilador y las librerías gráficas para el juego. Ejecuten este comando (les pedirá la contraseña que acaban de crear, al escribirla no se verá nada, solo escriban y den Enter):
```bash
sudo apt update
sudo apt install make gcc libncurses-dev -y
```

### Paso 4: Ejecutar la Parte 1 (Script de Bash)
1. Desde Ubuntu, naveguen a la carpeta de Windows donde clonaron este repositorio. Recuerden que en Linux, el disco C está en `/mnt/c/`. Por ejemplo:
   ```bash
   cd "/mnt/c/Users/TuUsuario/Desktop/ProyectoFinalUNIX/parte1_shell"
   ```
2. Limpien el formato de saltos de línea de Windows (para evitar errores raros de Bash) y ejecuten el script:
   ```bash
   sed -i 's/\r$//' sistema.sh
   bash sistema.sh
   ```

### Paso 5: Ejecutar la Parte 2 (Juego en C)
1. Naveguen a la carpeta de la parte 2:
   ```bash
   cd ../parte2_compilado
   ```
2. Usen los comandos de `make` para compilar y jugar:
   ```bash
   make          # Compila el código C y crea el ejecutable
   make run      # Ejecuta el juego (muévanse con las flechas)
   make clean    # Limpia los archivos compilados para dejar la carpeta limpia
   ```
