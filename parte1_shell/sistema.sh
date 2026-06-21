# Proyecto Final UNIX - Parte 1
# Gestión de alumnos con calificaciones en un txt

ARCHIVO="alumnos.txt"

# nos aseguramos de que el archivo si existe
if [ ! -f "$ARCHIVO" ]; then
    touch "$ARCHIVO"
fi

pausa() {
    echo ""
    read -p "Presione enter para continuar..."
}

alta() {
    clear
    echo "ALTA DE ALUMNO "
    read -p "Ingrese ID: " ID
    
    # Validar si ya existe
    if grep -q "^$ID," "$ARCHIVO"; then
        echo "Error: La ID $ID ya existe en el sistema."
        pausa
        return
    fi
    
    read -p "Nombre: " nombre
    read -p "Apellidos: " apellidos
    read -p "Semestre: " semestre
    read -p "Calificación Final: " calificacion
    
    echo "$ID,$nombre,$apellidos,$semestre,$calificacion" >> "$ARCHIVO"
    echo "Alumno registrado exitosamente."
    pausa
}

baja() {
    clear
    echo "BAJA DE ALUMNO "
    read -p "Ingrese ID a dar de baja: " ID
    
    if grep -q "^$ID," "$ARCHIVO"; then
        #buscamos la linea, y la mostramos para confirmar
        alumno=$(grep "^$ID," "$ARCHIVO")
        echo "Alumno encontrado: $alumno"
        read -p "¿Seguro que deseas eliminarlo? s/n: " confirmar
        if [ "$confirmar" == "s" ]; then
            #eliminamos la lineaa
            sed -i "/^$ID,/d" "$ARCHIVO"
            echo "Alumno eliminado exitosamente."
        else
            echo "Operación cancelada."
        fi
    else
        echo "Error: ID no encontrado."
    fi
    pausa
}

consulta() {
    clear
    echo "CONSULTA DE ALUMNO"
    echo "1. Buscar por ID"
    echo "2. Mostrar todos los alumnos"
    read -p "Opción: " opc
    
    case $opc in
        1)
            read -p "Ingrese ID: " ID
            if grep -q "^$ID," "$ARCHIVO"; then
                echo ""
                echo "ID,Nombre,Apellidos,Semestre,Calificación"
                grep "^$ID," "$ARCHIVO"
            else
                echo "Error: ID no encontrado."
            fi
            ;;
        2)
            echo ""
            echo "ID,Nombre,Apellidos,Semestre,Calificación"
            cat "$ARCHIVO"
            ;;
        *)
            echo "Opción invalida."
            ;;
    esac
    pausa
}

modificacion() {
    clear
    echo "MODIFICACIÓN DE CALIFICACIÓN"
    read -p "Ingrese ID del alumno a modificar: " ID
    
    if grep -q "^$ID," "$ARCHIVO"; then
        alumno=$(grep "^$ID," "$ARCHIVO")
        echo "Alumno encontrado: $alumno"
        #extraemos los datos actuales
        IFS=',' read -r mat nom ape sem cal <<< "$alumno"
        read -p "Ingrese nueva calificación (Actual: $cal): " nueva_cal
        #ahora si lo actualizamos en el archivo
        sed -i "s/^$ID,.*/$mat,$nom,$ape,$sem,$nueva_cal/" "$ARCHIVO"
        echo "Calificación actualizada exitosamente."
    else
        echo "Error: ID no encontrado"
    fi
    pausa
}

reporte1() {
    clear
    echo "REPORTE 1: ALUMNOS APROBADOS (>= 70)"
    echo "ID,Nombre,Apellidos,Semestre,Calificación"
    awk -F',' '$5 >= 70 {print $0}' "$ARCHIVO"
    pausa
}

reporte2() {
    clear
    echo "REPORTE 2: PROMEDIO GENERAL"
    total_alumnos=$(wc -l < "$ARCHIVO")
    if [ "$total_alumnos" -eq 0 ]; then
        echo "No hay alumnos registrados."
    else
        suma_calificaciones=$(awk -F',' '{suma+=$5} END {print suma}' "$ARCHIVO")
        #calculamos el promedio con dos decimales usando bc
        promedio=$(echo "scale=2; $suma_calificaciones / $total_alumnos" | bc 2>/dev/null)
        # si bc no esta instalado, que se use awk
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
    echo "REPORTE 3: CONTEO DE ALUMNOS POR SEMESTRE"
    echo "Semestre | Cantidad"
    awk -F',' '{print $4}' "$ARCHIVO" | sort | uniq -c | awk '{print "    " $2 "      |    " $1}'
    pausa
}

#menu
while true; do
    clear
    echo "     SISTEMA GESTOR DE ALUMNOS       "
    echo "-------------------------------------"
    echo "1. Alta de Alumno"
    echo "2. Baja de Alumno"
    echo "3. Consulta de Alumno"
    echo "4. Modificación de Calificación"
    echo "5. Reporte: Alumnos Aprobados"
    echo "6. Reporte: Promedio General"
    echo "7. Reporte: Alumnos por Semestre"
    echo "8. Salir"
    echo "-------------------------------------"
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
