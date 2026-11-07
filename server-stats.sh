#!/bin/bash

echo "======================================"
echo "      SERVER PERFORMANCE STATS"
echo "======================================"

# CPU Usage
echo -e "\n--- CPU Usage ---"
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
echo "Total CPU Usage: ${cpu_usage}%"

# Memory Usage
echo -e "\n--- Memory Usage ---"
free -m | awk 'NR==2{
total=$2;
used=$3;
free=$4;
printf "Total: %d MB\nUsed: %d MB (%.2f%%)\nFree: %d MB (%.2f%%)\n",
total, used, used*100/total, free, free*100/total
}'

# Disk Usage
echo -e "\n--- Disk Usage ---"
df -h / | awk 'NR==2{
print "Total: "$2;
print "Used: "$3" ("$5")";
print "Free: "$4;
}'

# Top 5 CPU Processes
echo -e "\n--- Top 5 Processes by CPU Usage ---"
ps -eo pid,comm,%cpu --sort=-%cpu | head -6

# Top 5 Memory Processes
echo -e "\n--- Top 5 Processes by Memory Usage ---"
ps -eo pid,comm,%mem --sort=-%mem | head -6

# OS Version
echo -e "\n--- OS Version ---"
grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"'

# Uptime
echo -e "\n--- Uptime ---"
uptime -p

# Load Average
echo -e "\n--- Load Average ---"
uptime | awk -F'load average:' '{print $2}'

# Logged-in Users
echo -e "\n--- Logged In Users ---"
who | wc -l

echo "======================================"