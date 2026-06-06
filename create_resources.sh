#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-0ab148400ac1bbfb5"
INSTANCES=("mysql2")

for instances in "${INSTANCES[@]}"; 
do 
    echo "Creating instance: $instances"
    aws ec2 run-instances \ 
    --image-id $AMI_ID \
    --security-group-ids $SG_ID \
    --instance-type t3.micro \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instances}]" | tee -a logs.txt
    echo -e "${G} $instances instance is created successfully ${D}"
    echo -e "${G} \n ${D}"
done
