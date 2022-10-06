#!/usr/bin/env bash

set -euo pipefail

# Input is in JSON format, this will read it into a shell variable
# Expected format is:
# first_public_ip first_private_ip;second_public_ip second_private_ip;
# For example:
# 3.71.195.141 10.0.1.241;3.75.232.57 10.0.2.220
eval "$(jq -r '@sh "input=\(.ips)"')"

IFS=';' read -ra instances <<< "$input"

# In order to use this script as a data source, Terraform requires a JSON formatted output
output="{"

number_of_instances=${#instances[@]}
for ((i = 0; i < $number_of_instances; ++i)); do
    this_public_ip=`echo ${instances[$i]} | cut -d ' ' -f 1`
    this_private_ip=`echo ${instances[$i]} | cut -d ' ' -f 2`

    next_instance_index=$(( ($i + 1) % $number_of_instances ))
    next_public_ip=`echo ${instances[$next_instance_index]} | cut -d ' ' -f 1`
    next_private_ip=`echo ${instances[$next_instance_index]} | cut -d ' ' -f 2`

    if ssh -o "StrictHostKeyChecking=no" -i ~/.ssh/id_rsa.pub ec2-user@$this_public_ip ping -w 2 -c 1 $next_private_ip > /dev/null; then
        output+="\"${this_private_ip}_$next_private_ip\":\"success\","
    else
        output+="\"${this_private_ip}_$next_private_ip\":\"failure\","
    fi
done

output+="}"
jq -n $output
