#!/bin/bash
# Define log file path
LOG_FILE="/var/log/system_health.log"
# Thresholds
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80
# CPU usage check
cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
if (( $(echo "$cpu_usage > $CPU_THRESHOLD" | bc -l) )); then
 echo "$(date): CPU usage high: $cpu_usage%" >> $LOG_FILE
fi
# Memory usage check
memory_usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
if (( $(echo "$memory_usage > $MEMORY_THRESHOLD" | bc -l) )); then
 echo "$(date): Memory usage high: $memory_usage%" >> $LOG_FILE
fi
# Disk usage check
disk_usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
if (( $disk_usage > $DISK_THRESHOLD )); then
 echo "$(date): Disk usage high: $disk_usage%" >> $LOG_FILE
fi
# Process count
process_count=$(ps -aux | wc -l)
echo "$(date): Process count: $process_count" >> $LOG_FILE
