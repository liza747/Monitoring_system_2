#!/bin/bash

case $1 in
1) read -p "Укажите абсолютный путь до log файла: " txt
loglist=$(awk '/Файл|Директория/{print $2}' $txt)
for path in ${loglist[*]}
do
    sudo rm -rf $path
done;;

2) echo "Укажите промежуток времени создания файлов в формате yyyy-mm-dd hh:mm"
read -p "Старт: " OTdate DOtime
read -p "Окончание:" DOdate DOtime
sudo find / -newermt "$OTdate $OTtime" ! -newermt "$DOdate $DOtime" -delete 2>/dev/null;;

3) read -p "Укажите название файла в формате name_ddmmhh: " mask 
masksim=$(echo $mask | awk -F_ '{print $1}')
maskdate=$(echo $mask | awk -F_ '{print $2}')
    sudo rm -rf;;
    
*) echo "Введите один параметр от 1 до 3"
exit 0;;
esac