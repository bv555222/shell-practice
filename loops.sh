#!/bin/bash

PACKAGES=("ansible" "mysql" "nginx")
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

for i in ${PACKAGES[@]}
do
    echo "Package: $i"
    INSTALL_PACKAGE $i
done

#check ansible successfully installed or not
VALIDATE()
{
    if [ $1 -ne 0 ]
    then
        echo -e "$R Installing $2 is ... FAILURE $D"
        exit 1
    else
        echo -e "$G Installing $2 is ... SUCCESS $D"
        exit 0
    fi
}

#check  packages are already installed or not
INSTALL_PACKAGE()
{
    echo  -e "$G Checking $1 package is already installed or not $D"
    dnf list installed $1
    if [ $? -eq 0 ]
    then 
        echo -e "$G $1 is already installed $D"
        exit 0
    else
        echo -e "$Y $1 is not installed... going to install it $D"
        dnf install $1 -y
        VALIDATE $? "$1"
    fi
}


