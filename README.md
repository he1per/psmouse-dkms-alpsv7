psmouse-dkms-alpsv7
===================

Linux kernel driver for newer ALPS touchpads (as of Mar 2014)

QUICK START
-----------
Make sure you have `dkms` installed in your system:
```
    pacman -S dkms   #for archlinux
```

Run the following commands in your shell **__as root__**:
```
    cd /tmp
    git clone http://github.com/he1per/psmouse-dkms-alpsv7
    cd psmouse-dkms-alpsv7
    ./install.sh
```

This will build and install the updated `psmouse` module for your current kernel.


INTRODUCTION
------------

Some new machines, like the Lenovo Ideapad Flex 15 have a new ALPS touchpad
which uses a protocol different from previous versions. The linux kernel (as of
3.13) does not recognize them as an ALPS touchpad, and they end up being
recognized only as a PS/2 mouse. For this reason there is no scrolling, no
middle button emulation, no two finger recognition, etc.

The folks at the linux kernel input devices mailing list were very helpful and
pointed me to the right patches, I have simply gathered them together and added
a dkms.conf file to make it easier to build. This page
(https://github.com/he1per/psmouse-dkms-alpsv7) explains how you install
and build the module.

Thanks specially to Tommy Will from the linux-input@vger.kernel.org mailing list
and to Elaine (Qiting) who actually wrote the code :) The original patch from 
Elaine is found here:

http://www.spinics.net/lists/linux-input/msg29084.html

DO I NEED THIS MODULE?
----------------------

If you get an error like this from `dmesg`:
```
psmouse serio1: alps: Unknown ALPS touchpad: E7=73 03 0a, EC=88 b6 06
```

then you need this module. Your touchpad will be recognized after you install it.

If you have a Toshiba Z30-A, you need to update to kernel 3.17  and you won't
need this patch.


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


### Manual build and install of psmouse.ko

It is better to use `install.sh`, but if you want to build and install
manually you can follow these instructions.

As root do the following from the directory where this README is found:
(all this is done automatically by the `install.sh` script)

```bash
    dkms add .  
    dkms build -m psmouse-dkms-alpsv7 -v 1.1  
    dkms install -m psmouse-dkms-alpsv7 -v 1.1  
    modprobe psmouse
```
