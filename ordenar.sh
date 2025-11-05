#!/bin/bash

# ---------------------- Colores ----------------------
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

# ---------------------- ctrl + c ----------------------
trap ctrl_c INT
function ctrl_c(){
  echo -e "\n\n${redColour}[!] saliendo...${endColour}${greenColour}\[>_<]/${endColour}\n"
  tput cnorm && exit 1 #recuperar el cursor y salir (por si las moscas)
}

arg_value=0
# --------------------- functions ---------------------

function ordenar_nombre(){
  cd ..
  tput civis

  i=1
  number_file=1
  limit_file=$(ls -ltr | grep -v "^t" | grep -v "^d" | awk 'NF{print $NF}' | wc -l)
  echo -e "[+] Límite detectado: $limit_file"

  while [ $i -lt $limit_file ] || [ $i -eq $limit_file ]; do
    file="$(ls -ltr | grep -v "^t" | grep -v "^d" | awk 'NF{print $NF}' | head -n$i | tail -n1)"
    echo -e "[!] cambiando nombre del archivo $file\n"
    mv $file fondo$number_file.jpg
    let i+=1
    let number_file+=1
  done
  tput cnorm
  ls -l | grep -v "^d" | grep -v "^t" | awk 'NF{print $NF}' | xargs chmod 755
 }

while getopts "oh" arg; do
  case $arg in
    o) let arg_value+=1;;
    h) ;;
  esac
done

if [ $arg_value -eq 1 ]; then
  ordenar_nombre
fi

# wlp2s0
