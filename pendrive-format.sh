#!/bin/bash
echo " "
echo "Lista de discos removiveis"
echo "--------------------------"
echo " "
devices=( $( ls /sys/block/ -p1 | grep sd) )

dispositivos=""

for i in "${devices[@]}"
do
        path="/sys/block/$i/removable"
        vendor=$(cat /sys/block/$i/device/vendor )
        model=$(cat /sys/block/$i/device/model )
        size=$( echo "$((512* $(cat /sys//block/$i/size)/1024/1024/1024))" )

        removivel=$( cat $path )

        if [ $removivel == 1 ]; then
                dispositivos+="$vendor - $model ( $size GB)!"
        fi
done

        yad --width=500 --height=100 --center --button="gtk-ok:0" --title "Dispositivos Removíveis" --text="\n Selecione o dispositivo: \n" --text-align=center --form $
echo " "
