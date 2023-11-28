#!/bin/bash

finished=0

while [ $finished -ne 1 ]; do
    echo "What is your favourite Linux distribution?"

    echo "1- Arch"
    echo "2- CentOS"
    echo "3- Debian"
    echo "4- Mint"
    echo "5- Ubuntu"
    echo "6- Something Else.."
    echo "7- Exit the script."

    read distro

    case $distro in
    1) echo "Arch is rolling release." ;;
    2) echo "CentOS is populer on servers." ;;
    3) echo "Debian is community distribution." ;;
    4) echo "Mint is populer desktop and laptops" ;;
    5) echo "Ubuntu is popupler for both desktop and servers." ;;
    6) echo "There are many different distributions out there" ;;
    7) finished=1 ;;
    *) echo "You did not enter an appropriate choise" ;;
    esac
done

echo "Thanks yoi for using this script."
