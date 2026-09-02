# Trabajo Práctico Bash

## Descripción

Este trabajo consiste en un script en Bash que permite gestionar archivos mediante un menú interactivo. Incluye además un proceso en segundo plano (consolidar.sh) que monitorea la llegada de nuevos archivos y los procesa automáticamente.

## Funcionalidades

1. Crear el entorno de trabajo
2. Procesar archivos en segundo plano (background)
3. Listar alumnos ordenados por número de padrón
4. Mostrar las 10 notas más altas
5. Buscar un alumno por padrón
6. Visualizar el archivo log

## Estructura de carpetas

```
EPNro1/
 ├── entrada/
 ├── salida/
 └── procesado/
```
entrada/: acá se colocan los archivos .txt a procesar.
procesado/: destino de los archivos ya procesados.
salida/: resultados generados por el script (listados, búsquedas, etc.).

## Requisitos y ejecucion

Definir la variable de entorno FILENAME, que indica el nombre base del archivo a usar:

```
export FILENAME=alumnos
```
Dar permisos de ejecución:

```
chmod +x script.sh
chmod +x consolidar.sh
```
Ejecutar el programa:

```
./script.sh
```

## Uso

1. Ejecutar el script y seleccionar la opción 1 para crear el entorno
2. Agregar archivos .txt en la carpeta entrada/.
3. Seleccionar la opción 2 para procesar los archivos (esto inicia consolidar.sh en segundo plano).
4. Utilizar las demás opciones del menú según lo que se necesite.

## Formato de los archivos

Los archivos deben tener el siguiente formato:

```
Nro_Padrón Nombre Apellido Email Nota
```

Ejemplo:

```
122332 Juan Lopez jlopez@fi.uba.ar 8
100998 Pedro Valdez pvaldez@fi.uba.ar 5
```

## Notas

Los archivos de prueba no se incluyen en el repositorio, ya que se generan únicamente para verificar el funcionamiento del script.

