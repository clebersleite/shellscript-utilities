#!/bin/bash
echo " "
echo "List Removable Devices - Mass Storage"
echo "--------------------------"
echo " "
devices=( $( ls /sys/block/ -p1 | grep sd) )

for i in "${devices[@]}"
do
        path="/sys/block/$i/removable"
        vendor=$(cat /sys/block/$i/device/vendor )
        model=$(cat /sys/block/$i/device/model )
        size=$( echo "$((512* $(cat /sys//block/$i/size)/1024/1024/1024))" )

        removivel=$( cat $path )
        if [ $removivel == 1 ]; then
                echo "$vendor - $model ( $size GB)"
        fi

done
echo " "
