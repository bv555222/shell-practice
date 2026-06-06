#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-06e682f318e1a348a"
INSTANCES=("mysql" "mongodb" "user" "catalogue")

for instances in ${INSTANCES[@]}
do
    echo "Creating $instances instance"
    aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type t3.micro \
    --security-group-ids $SG_ID \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instances}]"
    echo -e "${G} $instances instance is created successfully ${D}"
    echo -e "${G} \n ${D}"
done