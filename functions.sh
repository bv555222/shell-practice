#!/bin/bash

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
        echo "Installing $2 is ... FAILURE"
    else
        echo "Installing $2 is ... SUCCESS"
    fi
}

dnf list installed ansible
if [ $? -eq 0 ]
then 
    echo "Ansible is already installed"
    exit 1
else
    echo "Ansible is not installed... going to install it"
    dnf install ansible -y
    VALIDATE $? "Ansible"
fi
