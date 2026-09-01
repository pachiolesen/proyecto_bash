#!/bin/bash
cd EPNro1
#El proceso no para hasta no deternerlo por la terminal
while true; do
    #Por cada archivo txt que haya en la carpeta entrada, lo vuelca en otro archivo en la carpeta salida y el archivo original lo mueve a procesasdo.
    #En consolidar.log se anota el nombre de los archivos txt ingresados en la carpeta entrada junto a la fecha y horario del momento.
    for archivo in entrada/*.txt; do
        if [ -f "$archivo" ]; then
            cat "$archivo" >> "salida/${FILENAME}.txt"
            nombre_archivo=$(basename "$archivo")
            mv "$archivo" procesado/
            fecha=$(date +"%Y-%m-%d %H:%M:%S")
            echo "$fecha - Procesado archivo $nombre_archivo" >> "procesado.log"  
        fi
    done
    sleep 10 #Descanso para la pc asi no va tan rapido
done