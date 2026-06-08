#!/bin/bash
# Proyecto Final UNIX - Parte 1
# Gestión de Alumnos con Calificaciones

ARCHIVO="alumnos.txt"

# Asegurar que el archivo existe
if [ ! -f "$ARCHIVO" ]; then
    touch "$ARCHIVO"
fi

pausa() {
    echo ""
    read -p "Presione [Enter] para continuar..."
}

alta() {
    clear
    echo "=== ALTA DE ALUMNO ==="
    read -p "Ingrese Matrícula: " matricula
    
    # Validar si ya existe
    if grep -q "^$matricula," "$ARCHIVO"; then
        echo "Error: La matrícula $matricula ya existe en el sistema."
        pausa
        return
    fi
    
    read -p "Nombre: " nombre
    read -p "Apellidos: " apellidos
    read -p "Semestre: " semestre
    read -p "Calificación Final: " calificacion
    
    echo "$matricula,$nombre,$apellidos,$semestre,$calificacion" >> "$ARCHIVO"
    echo "Alumno registrado exitosamente."
    pausa
}

baja() {
    clear
    echo "=== BAJA DE ALUMNO ==="
    read -p "Ingrese Matrícula a dar de baja: " matricula
    
    if grep -q "^$matricula," "$ARCHIVO"; then
        # Buscar la línea, mostrarla para confirmar
        alumno=$(grep "^$matricula," "$ARCHIVO")
        echo "Alumno encontrado: $alumno"
        read -p "¿Seguro que desea eliminarlo? (s/n): " confirmar
        if [ "$confirmar" == "s" ]; then
            # Eliminar la línea
            sed -i "/^$matricula,/d" "$ARCHIVO"
            echo "Alumno eliminado exitosamente."
        else
            echo "Operación cancelada."
        fi
    else
        echo "Error: Matrícula no encontrada."
    fi
    pausa
}

consulta() {
    clear
    echo "=== CONSULTA DE ALUMNO ==="
    echo "1. Buscar por Matrícula"
    echo "2. Mostrar todos los alumnos"
    read -p "Opción: " opc
    
    case $opc in
        1)
            read -p "Ingrese Matrícula: " matricula
            if grep -q "^$matricula," "$ARCHIVO"; then
                echo ""
                echo "Matrícula,Nombre,Apellidos,Semestre,Calificación"
                grep "^$matricula," "$ARCHIVO"
            else
                echo "Error: Matrícula no encontrada."
            fi
            ;;
        2)
            echo ""
            echo "Matrícula,Nombre,Apellidos,Semestre,Calificación"
            cat "$ARCHIVO"
            ;;
        *)
            echo "Opción inválida."
            ;;
    esac
    pausa
}

modificacion() {
    clear
    echo "=== MODIFICACIÓN DE CALIFICACIÓN ==="
    read -p "Ingrese Matrícula del alumno a modificar: " matricula
    
    if grep -q "^$matricula," "$ARCHIVO"; then
        alumno=$(grep "^$matricula," "$ARCHIVO")
        echo "Alumno encontrado: $alumno"
        
        # Extraer los datos actuales
        IFS=',' read -r mat nom ape sem cal <<< "$alumno"
        
        read -p "Ingrese nueva calificación (Actual: $cal): " nueva_cal
        
        # Actualizar en el archivo
        sed -i "s/^$matricula,.*/$mat,$nom,$ape,$sem,$nueva_cal/" "$ARCHIVO"
        echo "Calificación actualizada exitosamente."
    else
        echo "Error: Matrícula no encontrada."
    fi
    pausa
}

reporte1() {
    clear
    echo "=== REPORTE 1: ALUMNOS APROBADOS (>= 70) ==="
    echo "Matrícula,Nombre,Apellidos,Semestre,Calificación"
    awk -F',' '$5 >= 70 {print $0}' "$ARCHIVO"
    pausa
}

reporte2() {
    clear
    echo "=== REPORTE 2: PROMEDIO GENERAL ==="
    total_alumnos=$(wc -l < "$ARCHIVO")
    
    if [ "$total_alumnos" -eq 0 ]; then
        echo "No hay alumnos registrados."
    else
        suma_calificaciones=$(awk -F',' '{suma+=$5} END {print suma}' "$ARCHIVO")
        # Calcular promedio con 2 decimales usando bc
        promedio=$(echo "scale=2; $suma_calificaciones / $total_alumnos" | bc 2>/dev/null)
        
        # Si bc no está instalado, hacemos un workaround con awk
        if [ -z "$promedio" ]; then
            promedio=$(awk -F',' '{suma+=$5} END {print suma/NR}' "$ARCHIVO")
        fi
        
        echo "Total de Alumnos: $total_alumnos"
        echo "Promedio General: $promedio"
    fi
    pausa
}

reporte3() {
    clear
    echo "=== REPORTE 3: CONTEO DE ALUMNOS POR SEMESTRE ==="
    echo "Semestre | Cantidad"
    awk -F',' '{print $4}' "$ARCHIVO" | sort | uniq -c | awk '{print "    " $2 "      |    " $1}'
    pausa
}

# Menú principal
while true; do
    clear
    echo "====================================="
    echo "     SISTEMA GESTOR DE ALUMNOS       "
    echo "====================================="
    echo "1. Alta de Alumno"
    echo "2. Baja de Alumno"
    echo "3. Consulta de Alumno"
    echo "4. Modificación de Calificación"
    echo "5. Reporte: Alumnos Aprobados"
    echo "6. Reporte: Promedio General"
    echo "7. Reporte: Alumnos por Semestre"
    echo "8. Salir"
    echo "====================================="
    read -p "Seleccione una opción: " opcion

    case $opcion in
        1) alta ;;
        2) baja ;;
        3) consulta ;;
        4) modificacion ;;
        5) reporte1 ;;
        6) reporte2 ;;
        7) reporte3 ;;
        8) clear; echo "Saliendo..."; exit 0 ;;
        *) echo "Opción inválida."; pausa ;;
    esac
done
