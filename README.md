# problemstatement2
Problem Statement 2:
1)System Health Monitoring Script Documentation
Objective
Monitor critical system metrics (CPU, memory, disk space, process count) and 
log alerts if thresholds are exceeded.
Prerequisites
- Linux OS
- `bc` for arithmetic operations
Step 1: Install `bc` 
 sudo apt-get update
 sudo apt-get install bc
Step 2: Create and Edit the Script
 nano system_health_monitor.sh
 
3. Insert the script content:
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
Step 3: Make the Script Executable
 Change the script's permission to make it executable:
 chmod +x system_health_monitor.sh
Step 4: Run the Script
 Execute the script to monitor system health:
 sudo ./system_health_monitor.sh
Step 5: View the Log
Check the log for any alerts:
 cat /var/log/system_health.log
 ****************************************************************************************
4) Application Health Checker Script Documentation 
Objective 
Develop a script to monitor the uptime of a web application by checking HTTP 
status codes, determining if the application is operational or down.
Prerequisites 
- Linux OS
- `curl` utility for making HTTP requests
Step 1: Install `curl` 
 sudo apt-get update
 sudo apt-get install curl
Step 2: Create and Edit the Script 
 nano app_health_checker.sh
 
 3. Insert the script content: 
#!/bin/bash
# Application URL to check
APP_URL="https://github.com/nyrahul/wisecow"
# Log file for storing the script output
LOG_FILE="/var/log/app_health_checker.log"
# Making an HTTP request and capturing the HTTP status code
HTTP_STATUS=$(curl -o /dev/null -s -w "%{http_code}\n" $APP_URL)
# Current date and time for logging
NOW=$(date +"%Y-%m-%d %T")
# Checking if the application is up and running
if [ "$HTTP_STATUS" -eq 200 ]; then
    echo "$NOW: Application is UP (HTTP Status: $HTTP_STATUS)" >> $LOG_FILE
else
    echo "$NOW: Application might be DOWN (HTTP Status: $HTTP_STATUS)" >> $LOG_FILE
fi
Step 3: Make the Script Executable 
 chmod +x app_health_checker.sh
Step 4: Run the Script 
 sudo ./app_health_checker.sh
Step 6: View the Log 
To view the application health check results:
 cat /var/log/app_health_checker.log
➢ Editing the Crontab 
 
 crontab -e
# Run System Health Monitoring script every 10 minutes 
*/10 * * * * /home/ DharshanMS/system_health_monitoring.sh
# Run Application Health Checker script every 5 minutes
*/5 * * * * /home/DharshanMS/app_health_checker.sh
