#!/bin/bash

echo "What is your fav Linux distribution?"

echo "1- Arch"
echo "2- CentOS"
echo "3- Debian"
echo "4- Mint"
echo "5- Ubuntu"
echo "6- Something Else.."

read distro

case $distro in
1) echo "Arch is rolling release." ;;
2) echo "CentOS is populer on servers." ;;
3) echo "Debian is community distribution." ;;
4) echo "Mint is populer desktop and laptops" ;;
5) echo "Ubuntu is popupler for both desktop and servers." ;;
6) echo "There are many different distributions out there" ;;
*) echo "You did not enter an appropriate choise" ;;
esac
