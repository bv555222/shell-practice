#!/bin/bash


R="\e[31m"
G="\e[32m"
Y="\e[33m"
D="\e[0m"

USER=$(id -u)

if [ $USER -ne 0 ]
then 
    echo "You do not have root permission..\
          Please run as root user"
else
    echo "Running the command as Root user"
fi

#check and install ansible package
VALIDATE()
{
    if [ $1 -ne 0 ]
    then
        echo "$R Installing $2 is ... FAILURE $D"
        exit 1
    else
        echo "$G Installing $2 is ... SUCCESS $D"
        exit 0
    fi
}

echo  "$G Checking Ansible package is already installed or not $D"
dnf list installed ansible
if [ $? -eq 0 ]
then 
    echo "$G Ansible is already installed $D"
    exit 0
else
    echo "$Y Ansible is not installed... going to install it $D"
    dnf install ansible -y
    VALIDATE $? "Ansible"
fi
