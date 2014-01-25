psmouse-dkms-alpsv7
===================

Linux kernel driver for newer ALPS touchpads (as of Jan 2014)

QUICK START
===========
Just run install.sh as root, it will build and install the module psmouse.ko.
# ./install.sh


INTRODUCTION
============

Some new machines, like the Lenovo Ideapad Flex 15 have a new alps touchpad
which uses a protocol different from previous versions. The folks at the 
linux kernel input devices mailing list were very helpful and pointed me 
to the right patches, I have simply gathered them together and added a dkms.conf
file to make it easier to build. Here is how you install and build the module

Thanks specially to Tommy Will from the linux-input@vger.kernel.org mailing list
and to Elaine (Qiting) who actually wrote the code :) 


BUILDING and INSTALLING
=======================

Pre-requisites:
---------------
* dkms:
     pacman -S dkms  #will install dkms in archlinux based distros
                     #use apt-get install dkms in debian or rpm 
                     # in redhat distros
    
* linux headers      #this will be installed as a dependency


Build and install psmouse.ko
----------------------------
As root do the following from the directory where this README is found:
All this is done automatically by the install.sh script.

# dkms add .
# dkms build -m psmouse-dkms-alpsv7 -v 1.0
# dkms autoinstall -m psmouse-dkms-alpsv7 -v 1.0

