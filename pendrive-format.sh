#!/bin/bash

devices=( $( ls /sys/block/ -p1 | grep sd) )

dispositivos=""


# check YAD
if ! which yad > /dev/null; then
 xmessage -buttons Ok:0 -center "Este comando necessita do YAD instalado em sua distro" -title "Dependencia de pacote"
 exit 1
fi

for i in "${devices[@]}"
do
 ## Get devices list
 path="/sys/block/$i/removable"

 ## Get Info
 device="/dev/$i"
 vendor=$(cat /sys/block/$i/device/vendor )
 model=$(cat /sys/block/$i/device/model )
 size=$( echo "$((512* $(cat /sys//block/$i/size)/1024/1024/1024))" )

 ## Check if is removable
 removivel=$( cat $path )

 if [ $removivel == 1 ]; then
  dispositivos+="$device | $vendor - $model ( $size GB)!"
 fi
done
 ## Remove last char to do not a blank option
 dispositivos=$(sed 's/.\{1\}$//' <<< "$dispositivos")

 comando=$( yad  --height=100 --center \
 --image=drive-removable-media \
 --button="gtk-ok:0"  \
 --button="gtk-refresh:1" \
 --title "Dispositivos Removíveis" \
 --text="Selecione o dispositivo:" --text-align=center \
 --form --field="":CB "$dispositivos" "/dev/sdb!/dev/sdc" )

 foo=$?

 if [ $foo -eq 1 ]; then
  $0
 else
  retorno=$( echo "$comando" | cut -c 1-8 )
  echo $retorno
  exit 0
 fi
