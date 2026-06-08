# Proyecto Final UNIX

Este repositorio contiene las dos partes del proyecto final de la materia de UNIX.

## Parte 1: Sistema Gestor de Alumnos (Bash)
Ubicado en la carpeta `parte1_shell`. Es un script en Bash que gestiona un archivo de datos (`alumnos.txt`) permitiendo realizar altas, bajas, consultas, modificaciones y 3 reportes.

## Parte 2: Juego Snake en C (Makefile)
Ubicado en la carpeta `parte2_compilado`. Es una versión del clásico juego Snake para terminal, escrito en C y automatizado con un `Makefile`.

---

## Instrucciones para los compañeros (Cómo ejecutar el proyecto)

Para poder correr este proyecto en sus computadoras, necesitan tener instalado **WSL (Windows Subsystem for Linux)** con Ubuntu.

### 1. Preparativos
Abran su terminal de Ubuntu y ejecuten los siguientes comandos una sola vez para instalar las herramientas necesarias (`make`, el compilador de C y la librería gráfica del juego):
```bash
sudo apt update
sudo apt install make gcc libncurses-dev -y
```

### 2. Ejecutar la Parte 1 (Script de Bash)
1. Naveguen a la carpeta donde clonaron este repositorio y entren a `parte1_shell`.
2. Ejecuten el script con Bash:
```bash
cd parte1_shell
sed -i 's/\r$//' sistema.sh   # Para limpiar formatos de Windows
bash sistema.sh
```

### 3. Ejecutar la Parte 2 (Juego en C)
1. Naveguen a la carpeta `parte2_compilado`.
2. Usen los comandos de `make` para compilar y jugar:
```bash
cd parte2_compilado
make          # Compila el juego
make run      # Ejecuta el juego
make clean    # Limpia los archivos compilados
```
