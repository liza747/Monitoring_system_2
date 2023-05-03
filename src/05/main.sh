#!/bin/bash
for (( i = 1; i < 6; i++ ))
do
case $1 in
1) awk '{print $0 | "sort -n -k9"}' ../04/nginx_log_$i.log;;
2) awk '{print $1 | "uniq -u"}' ../04/nginx_log_$i.log;;
3) awk '$9~"^4|^5"{print $6, $7, $8}' ../04/nginx_log_$i.log;;
4) awk '$9~"^4|^5"{print $1 | "uniq -u"}' ../04/nginx_log_$i.log;;
*) echo "Введите один параметр от 1 до 4"
exit 0;;
esac
done