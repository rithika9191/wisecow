#!/bin/bash

# System Health Monitoring Script

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
MEMORY_USAGE=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | tr -d '%')
PROCESS_COUNT=$(ps -e --no-headers | wc -l)

echo "=================================="
echo "       SYSTEM HEALTH REPORT"
echo "=================================="
echo "CPU Usage: ${CPU_USAGE}%"
echo "Memory Usage: ${MEMORY_USAGE}%"
echo "Disk Usage: ${DISK_USAGE}%"
echo "Running Processes: ${PROCESS_COUNT}"
echo "=================================="

# Check thresholds

if awk "BEGIN {exit !($CPU_USAGE > 80)}"; then
    echo "WARNING: High CPU usage!"
fi

if [ "$MEMORY_USAGE" -gt 80 ]; then
    echo "WARNING: High memory usage!"
fi

if [ "$DISK_USAGE" -gt 80 ]; then
    echo "WARNING: High disk usage!"
fi

echo "System health check completed."
