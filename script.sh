#!/bin/bash
#Si en la terminal el usuario pone como primer parametro "-d" se borrara el directorio "EPNro1", su contenido y los porcesos en background
if [ "$1" == "-d" ]; then
    if [ -d "EPNro1" ]; then
        rm -r EPNro1
        echo "El directorio EPNro1 y su contenido fueron borrados"
    else
        echo "No existe el directorio EPNro1"
    fi
    pkill -f consolidar.sh #mato el proceso en background
    echo "El proceso en background fue detenido"
    exit 0
fi
#Si el usuario no ingresa la variable de ambiente el script dejara de ejecutarse
if [ -z "$FILENAME" ]; then
    echo "La variable de ambiente FILENAME no esta definida, deberias definirla antes de ejecutar el script"
    exit 1 #Use exit "1" para informar que tuve que cerrar el script por un error
fi
numero_menu=0
#Mientras numero_menu sea distinto de 7 el menu va a seguir en funcionamiento
while [ "$numero_menu" != "7" ]; do
    echo "Menu:
    1)Crear entorno
    2)Correr proceso
    3)Ver el listado de alumnos ordenados por numero de padron
    4)Ver las 10 notas mas altas del listado
    5)Ingresar nro. de padron y ver datos del alumno correspondiente
    6)Ver log
    7)Salir
    read -p "Ingrese el numero del menu que desea ejecutar: " numero_menu
    case "$numero_menu" in
        1)
            #Si no existe el directorio "EPNro1" lo crea con sus carpetas de adentro
            if [ ! -d "EPNro1" ]; then
                mkdir EPNro1
                mkdir EPNro1/entrada
                mkdir EPNro1/salida
                mkdir EPNro1/procesado
                cp consolidar.sh EPNro1/
                echo "El entorno fue creado"
            else
                echo "El entorno ya fue creado, no podes hacerlo mas de una vez"    
            fi    
            ;;
        2)
            #Si existe el directorio EPNro1 corre el proceso en background
            if [ -d "EPNro1" ]; then
                bash EPNro1/consolidar.sh &
                echo "El proceso en background ya esta funcionando"
            else
                echo "Debes entrar a la opcion 1 del menu para asi se crea el entorno antes de querer entrar a la opcion 2"
            fi    
            ;;
        3)  if [ -d "EPNro1" ]; then
                #Si esta $FILENAME.txt en la carpeta salida, muestra por pantalla el listado de alumnos ordenados por nro. de padron
                if [ -f "EPNro1/salida/$FILENAME.txt" ]; then
                    sort -n "EPNro1/salida/$FILENAME.txt"
                else
                    echo "No se encontro $FILENAME.txt, deberas ingresar un archvio .txt en la carpeta entrada"
                fi
            else
                echo "Debes entrar a la opcion 1 del menu para asi se crea el entorno antes de querer entrar a la opcion 3"
            fi
            ;;
        4)
            if [ -d "EPNro1" ]; then
                #Si existe $FILENAME.txt en la carpeta salida, muestra por pantalla las 10 notas mas altas del listado
                if [ -f "EPNro1/salida/$FILENAME.txt" ]; then
                    sort -k5 -n -r "EPNro1/salida/$FILENAME.txt" | head -10
                else
                    echo "No se encontro $FILENAME.txt, deberas ingresar un archvio .txt en la carpeta entrada"
                fi
            else
                echo "Debes entrar a la opcion 1 del menu para asi se crea el entorno antes de querer entrar a la opcion 4"
            fi
            ;;
        5)  
            if [ -d "EPNro1" ]; then
                #Si existe $FILENAME.txt en la carpeta salida, muestra por pantalla los datos del alumno del padron correspondiente
                if [ -f "EPNro1/salida/$FILENAME.txt" ]; then
                    read -p "Ingrese el nro. de padron del alumno que desea ver sus datos: " nro_padron
                    #Si el usuario quiere dejar de buscar alumnos por nro. de padron, debera ingresar exit
                    while [ "$nro_padron" != "exit" ]; do
                        resultado=$(grep "^$nro_padron " "EPNro1/salida/$FILENAME.txt") #Use el ^ para indicar que el nro_padron tiene que coincidir respetando el orden de los numeros
                        if [ -n "$resultado" ]; then
                            echo "$resultado"
                        else
                            echo "El nro. de padron no se encuentra"
                        fi
                        read -p "Si desea buscar otro alumno ingrese el numero de padron, en caso contrario escriba 'exit': " nro_padron
                    done
                else
                    echo "No se encontro $FILENAME.txt, deberas ingresar un archvio .txt en la carpeta entrada"
                fi
            else
                echo "Debes entrar a la opcion 1 del menu para asi se crea el entorno antes de querer entrar a la opcion 5"
            fi
            ;;
        6)
            if [ -d "EPNro1" ]; then
                #Si existe procesado.log mostralo por pantalla
                if [ -f "EPNro1/procesado.log" ]; then
                    cat EPNro1/procesado.log
                else
                    echo "No existe el archivo procesado.log"
                fi
            else
                echo "Debes entrar a la opcion 1 del menu para asi se crea el entorno antes de querer entrar a la opcion 6"
            fi
            ;;
        7)
            echo "Adios"
            ;;
    esac
done
