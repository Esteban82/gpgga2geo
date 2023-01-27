#!/bin/bash

# Define el nombre del archivo de entrada y salida
#input_file="gps_data.txt"
input_file="Lago_Viedma.txt"
output_file="geo_coordinates.txt"

# Crea un bucle para leer cada línea del archivo de entrada
while IFS='' read -r line || [[ -n "$line" ]]; do
    # Utiliza el comando cut para obtener los valores de latitud y longitud
    lat=$(echo $line | cut -d ',' -f 2)
    lon=$(echo $line | cut -d ',' -f 4)
    lat_dir=$(echo $line | cut -d ',' -f 3)
    lon_dir=$(echo $line | cut -d ',' -f 5)

    # Convierte los valores de latitud y longitud a grados decimales
    dec_lat=$(echo $lat | awk '{printf "%.6f", substr($0,0,2)+(substr($0,3)/60)}')
    dec_lon=$(echo $lon | awk '{printf "%.6f", substr($0,0,3)+(substr($0,4)/60)}')

    # Si la dirección es Sur o Oeste se multiplica por -1 para obtener un valor negativo
    [[ $lat_dir == "S" ]] && dec_lat=$(echo $dec_lat*-1 | bc)
    [[ $lon_dir == "W" ]] && dec_lon=$(echo $dec_lon*-1 | bc)

    # Escribe los valores de latitud y longitud en el archivo de salida
    echo "$dec_lat $dec_lon" >> $output_file
done < "$input_file"