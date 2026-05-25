#!/bin/bash
set -euo pipefail

INSTANCES=("mysql" "mongodb" "user" "catalogue")

if ! command -v aws >/dev/null 2>&1; then
    echo "ERROR:: aws CLI is not installed or not on PATH"
    exit 1
fi

for name in "${INSTANCES[@]}"
do
    echo "Terminating $name instance"

    instance_ids=$(aws ec2 describe-instances \
        --filters "Name=tag:Name,Values=$name" "Name=instance-state-name,Values=pending,running,stopping,stopped" \
        --query 'Reservations[].Instances[].InstanceId' --output text 2>/dev/null)

    if [ -z "$instance_ids" ]; then
        echo "No matching AWS instance found with Name tag '$name'"
        continue
    fi

    aws ec2 terminate-instances --instance-ids $instance_ids >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "$name instance terminate request submitted"
    else
        echo "Failed to terminate $name instance"
    fi
    echo

done