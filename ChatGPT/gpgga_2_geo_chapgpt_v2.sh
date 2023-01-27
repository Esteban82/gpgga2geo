#!/bin/bash

# Input file containing GPS data in GPGGA format
#input_file="gpsdata.txt"
input_file="Lago_Viedma.txt"

# Output file for geographic coordinates
output_file="geocoords.txt"

# Initialize an empty array to store the coordinates
coords=()

# Read the input file line by line
while read line; do
  # Split the line into an array of comma-separated values
  values=($(echo $line | tr "," "\n"))

  # Extract the latitude and longitude values
  lat=${values[2]}
  lon=${values[4]}

  # Convert latitude and longitude to decimal degrees
  lat_deg=$(echo "$lat / 100" | bc -l)
  lat_min=$(echo "$lat - ($lat_deg * 100)" | bc -l)
  lat_dec=$(echo "$lat_deg + ($lat_min / 60)" | bc -l)
  lon_deg=$(echo "$lon / 100" | bc -l)
  lon_min=$(echo "$lon - ($lon_deg * 100)" | bc -l)
  lon_dec=$(echo "$lon_deg + ($lon_min / 60)" | bc -l)

  # Add the hemisphere suffix to the latitude and longitude values
  if [ ${values[3]} == "S" ]; then
    lat_dec="-$lat_dec"
  fi
  if [ ${values[5]} == "W" ]; then
    lon_dec="-$lon_dec"
  fi

  # Add the coordinates to the array
  coords+=("$lat_dec,$lon_dec")
done < $input_file

# Write the coordinates to the output file
echo ${coords[@]} > $output_file


#tr -s ' ' < nombre_archivo.txt | awk '{printf "%.6f", $1}' > nombre_archivo_reducido.txt
#tr ' ' '\n' <  $output_file | awk '{printf "%.6f", $1}' > nombre_archivo_reducido.txt
#tr ' ' '\n' <  $output_file > nombre_archivo_reducido.txt 
tr ' ' '\n' < geocoords.txt | head
tr ' ' '\n' < geocoords.txt > nombre_archivo_reducido.txt 