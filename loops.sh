#!/bin/bash

PACKAGES=("ansible" "mysql" "nginx")
R="\e[31m"
G="\e[32m"
Y="\e[33m"
D="\e[0m"

USER=$(id -u)

if [ $USER -ne 0 ]
then 
    echo -e "${R} You do not have root permission..\n
          Please run as root user ${D}"
else
    echo -e "${G} Running the command as Root user ${D}"
fi



#check ansible successfully installed or not
VALIDATE()
{
    if [ $1 -ne 0 ]
    then
        echo -e "${R} Installing $2 is ... FAILURE ${D}"
    else
        echo -e "${G} Installing $2 is ... SUCCESS ${D}"
    fi
}

#check  packages are already installed or not
INSTALL_PACKAGE()
{
    echo  -e "${Y} Checking $1 package is already installed or not ${D}"
    dnf list installed $1 &> /dev/null
    if [ $? -eq 0 ]
    then 
        echo -e "${G} $1 is already installed ${D}"
    else
        echo -e "${Y} $1 is not installed... going to install it ${D}"
        dnf install $1 -y &> /dev/null
        VALIDATE $? "$1"
    fi
}

#check if all the packages istalled or not
STATUS()
{
    echo -e "${Y} PACKAGE INSTALLATION STATUS ${D}"
    for i in ${PACKAGES[@]}
    do
        dnf list installed $i &> /dev/null
        if [ $? -eq 0 ]
        then 
            echo -e "${G} $i is installed Successfully ${D}"
        else
            echo -e "${R} $i installation failed ${D}"
        fi
    done
}


for i in ${PACKAGES[@]}
do
    echo "Package: $i"
    INSTALL_PACKAGE $i
    echo -e "${G} \n ${D}"
done
STATUS