psmouse-dkms-alpsv7
===================

Linux kernel driver for newer ALPS touchpads (as of Jan 2014)

QUICK START
-----------
Just run `install.sh` as root, it will build and install the updated `psmouse` module.


INTRODUCTION
------------

Some new machines, like the Lenovo Ideapad Flex 15 have a new alps touchpad
which uses a protocol different from previous versions. The folks at the 
linux kernel input devices mailing list were very helpful and pointed me 
to the right patches, I have simply gathered them together and added a dkms.conf
file to make it easier to build. Here is how you install and build the module

Thanks specially to Tommy Will from the linux-input@vger.kernel.org mailing list
and to Elaine (Qiting) who actually wrote the code :) 

If you get an error like this from `dmesg`:
```
psmouse serio1: alps: Unknown ALPS touchpad: E7=73 03 0a, EC=88 b6 06
```

then you need this module. Your touchpad will be recognized after you install it.


BUILDING and INSTALLING
-----------------------

### Pre-requisites:

* __dkms__:  
    ```bash
     pacman -S dkms   #will install dkms in archlinux based distros
                      #use apt-get install dkms in debian or rpm 
                      # in redhat distros
    ```

* __linux headers__       will be installed as a dependency if you use any
  of the commands above.


### Build and install psmouse.ko

As root do the following from the directory where this README is found:
(all this is done automatically by the `install.sh` script)

```bash
    dkms add .  
    dkms build -m psmouse-dkms-alpsv7 -v 1.0  
    dkms autoinstall -m psmouse-dkms-alpsv7 -v 1.0  
```
