#!/bin/bash

echo "Время начала работы скрипта = $(date +%T)"
workingtime=$(date +%s.%N)
if [ -z $1 ] || [ $# -ne 3 ]
then echo "Ошибка ввода. Введите 6 параметров"
exit 0
    elif ! [[ $1 =~ ^[[:alpha:]]{1,7}$ ]]
        then echo "Ошибка ввода. Укажите название директории (не более 7 знаков)"
        exit 0
    elif ! [[ $2 =~ ^[[:alpha:]]{1,7}\.[[:lower:]]{1,3}$ ]]
        then echo "Ошибка ввода. Укажите название файла с раcширением (не более 7 знаков для имени, не более 3 знаков для расширения)"
        exit 0
    elif ! [[ $3 =~ ^(([1-9])|([1-9][0-9])|(100))Mb ]]
        then echo "Ошибка ввода. Укажите размер файла (в Мегабайтах, но не более 100)"
        exit 0
fi

namefold=$1
file=$2
path=$(find / -type d 2>/dev/null | shuf | head -n 1)
namefile=$(echo $2 | awk -F. '{print $1}')
nameextension=$(echo $2 | awk -F. '{print $2}')
size=$(echo "$3" | tr -d Mb)
date=$(echo "_")$(date +"%d%m%y")
ogranichenie=$(df -h / | awk 'NR==2{print $4}')

while [ ${#namefold} \< 5 ]
do
    namefold+="${namefold: -1}"
done

if [[ $path =~ (/bin/)|(/sbin/)|(/root/)|(/proc/)|(/snap/)|(/sys/) ]]
then 
echo "Та самая $path"
else
for (( i = 0; i < $(shuf -n1 -i 1-100); i++ ))
do
    sudo mkdir -p $path/$namefold$date
    echo -e "Директория: $path/$namefold$date" >> log.txt
        for (( j = 0; j < $(shuf -n1 -i 1-100); j++ ))
        do
        echo "$path"
            sudo fallocate -l $size"MB" $path/$namefold$date/$namefile$date.$nameextension
            echo -e "Файл: $path/$namefold$date/$namefile$date.$nameextension \n\tДата создания: $(date +"%d.%m.%y %T") \tРазмер файла: $size Mb" 
            namefile+="${namefile: -1}"
                # if [[ $ogranichenie =~ G$ ]]
                # echo 'malo mesta'
                # then exit 0
                # fi
        done >> log.txt
    namefold+="${namefold: -1}"
done
fi


workingtimeout=$(echo "$(date +%s.%N)-$workingtime" | bc)
printf "Общее время работы скрипта(в секундах) = %.2f\n" $workingtimeout
echo "Время окончания работы скрипта = $(date +%T)"
