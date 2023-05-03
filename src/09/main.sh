#!/bin/bash

while [ 1 ]
do
cpu0user=$(cat /proc/stat | awk '/cpu0/{print $2/100}')
cpu0nice=$(cat /proc/stat | awk '/cpu0/{print $3/100}')
cpu0system=$(cat /proc/stat | awk '/cpu0/{print $4/100}')
cpu0idle=$(cat /proc/stat | awk '/cpu0/{print $5/100}')
cpu0iowait=$(cat /proc/stat | awk '/cpu0/{print $6/100}')
cpu0irq=$(cat /proc/stat | awk '/cpu0/{print $7/100}')
cpu0softirq=$(cat /proc/stat | awk '/cpu0/{print $8/100}')
cpu0steal=$(cat /proc/stat | awk '/cpu0/{print $9/100}')
cpu1user=$(cat /proc/stat | awk '/cpu1/{print $2/100}')
cpu1nice=$(cat /proc/stat | awk '/cpu1/{print $3/100}')
cpu1system=$(cat /proc/stat | awk '/cpu1/{print $4/100}')
cpu1idle=$(cat /proc/stat | awk '/cpu1/{print $5/100}')
cpu1iowait=$(cat /proc/stat | awk '/cpu1/{print $6/100}')
cpu1irq=$(cat /proc/stat | awk '/cpu1/{print $7/100}')
cpu1softirq=$(cat /proc/stat | awk '/cpu1/{print $8/100}')
cpu1steal=$(cat /proc/stat | awk '/cpu1/{print $9/100}')
memTotal=$(free -b | awk 'NR==2{printf "%1.9e", $2}')
memFree=$(free -b | awk 'NR==2{printf "%1.7e", $4}')

echo -e "# HELP node_cpu_seconds_total Seconds the CPUs spent in each mode.
# TYPE node_cpu_seconds_total counter
node_cpu_seconds_total{cpu=\"0\",mode=\"idle\"} $cpu0idle
node_cpu_seconds_total{cpu=\"0\",mode=\"iowait\"} $cpu0iowait
node_cpu_seconds_total{cpu=\"0\",mode=\"irq\"} $cpu0irq
node_cpu_seconds_total{cpu=\"0\",mode=\"nice\"} $cpu0nice
node_cpu_seconds_total{cpu=\"0\",mode=\"softirq\"} $cpu0softirq
node_cpu_seconds_total{cpu=\"0\",mode=\"steal\"} $cpu0steal
node_cpu_seconds_total{cpu=\"0\",mode=\"system\"} $cpu0system
node_cpu_seconds_total{cpu=\"0\",mode=\"user\"} $cpu0user
node_cpu_seconds_total{cpu=\"1\",mode=\"idle\"} $cpu1idle
node_cpu_seconds_total{cpu=\"1\",mode=\"iowait\"} $cpu1iowait
node_cpu_seconds_total{cpu=\"1\",mode=\"irq\"} $cpu1irq
node_cpu_seconds_total{cpu=\"1\",mode=\"nice\"} $cpu1nice
node_cpu_seconds_total{cpu=\"1\",mode=\"softirq\"} $cpu1softirq
node_cpu_seconds_total{cpu=\"1\",mode=\"steal\"} $cpu1steal
node_cpu_seconds_total{cpu=\"1\",mode=\"system\"} $cpu1system
node_cpu_seconds_total{cpu=\"1\",mode=\"user\"} $cpu1user
# HELP node_memory_MemFree_bytes Memory information field MemFree_bytes.
# TYPE node_memory_MemFree_bytes gauge
node_memory_MemFree_bytes $memFree
# HELP node_memory_MemTotal_bytes Memory information field MemTotal_bytes.
# TYPE node_memory_MemTotal_bytes gauge
node_memory_MemTotal_bytes $memTotal" > metric.html
sleep 3
done