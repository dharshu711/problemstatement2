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
