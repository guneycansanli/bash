#!/bin/bash


# $? is the last command output
# exit code 0 is succesfull
#exit code other tham 0 is failure

package1=htop
sudo apt install $package1 >>  package_install_results.log

echo "The exit code for the package install is: $?"
if [ $? -eq 0 ]; then
        echo "The installation is of $package1 was succesfull."
        echo "The new command is available here:"
        which $package1
else
        echo "Package failed to install"
fi

echo "--------------"


#The exit code for the package install is: 0
# package_install_results.log is out put of apt using >> We can provide output to another file 