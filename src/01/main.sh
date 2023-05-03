#!/bin/bash

if [ -z $1 ] || [ $# -ne 6 ]
then echo "Ошибка ввода. Введите 6 параметров"
    exit 0
    elif ! [ -d $1 ] && ! [[ $1 =~ ^/ ]]
        then echo "Ошибка ввода. Укажите директорию в формате: /var/log"
        exit 0
    elif ! [[ $2 =~ ^[1-9][0-9]*$ ]] || ! [[ $4 =~ ^[1-9][0-9]*$ ]]
        then echo "Ошибка ввода. Укажите корректное число"
        exit 0
    elif ! [[ $3 =~ ^[[:alpha:]]{1,7}$ ]] 
        then echo "Ошибка ввода. Укажите название директории (не более 7 знаков)"
        exit 0
    elif ! [[ $5 =~ ^[[:alpha:]]{1,7}\.[[:lower:]]{1,3}$ ]] 
        then echo "Ошибка ввода. Укажите название файла с раcширением (не более 7 знаков для имени, не более 3 знаков для расширения)"
        exit 0
    elif ! [[ $6 =~ ^(([1-9])|([1-9][0-9])|(100))kb ]]
        then echo "Ошибка ввода. Укажите размер файла (в килобайтах, но не более 100)"
        exit 0
fi

export path=$1
export namefold=$3
export file=$5
export numfold=$2
export numfile=$4
export file=$5
export date=$(echo "_")$(date +"%d%m%y")
export namefile=$(echo $5 | awk -F. '{print $1}')
export nameextension=$(echo $5 | awk -F. '{print $2}')
export size=$(echo "$6" | tr -d kb)
ogranichenie=$(df -h / | awk 'NR==2{print $4}')


while [ ${#namefold} \< 4 ]
do
    namefold+="${namefold: -1}"
done
while [ $numfold -gt 0 ]
do
    mkdir -p $path/$namefold$date
    echo -e "Директория: $path/$namefold$date" >> log.txt
        while [ $numfile -gt 0 ]
        do
            fallocate -l $size"KB" $path/$namefold$date/$namefile$date.$nameextension
                if ! [[ $ogranichenie =~ [G] ]]
                then exit 0
                fi
            echo -e "Файл: $path/$namefold$date/$namefile$date.$nameextension \n\tДата создания: $(date +"%d.%m.%y %T") \tРазмер файла: $size Kb" 
            numfile=$[ $numfile - 1 ]
            namefile+="${namefile: -1}"
        done >> log.txt
    numfile=$4
    numfold=$[ $numfold - 1 ]
    namefold+="${namefold: -1}"
done
