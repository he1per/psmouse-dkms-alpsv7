#!/bin/sh

M=psmouse-dkms-alpsv7
V=1.0

abort()
{
   echo "▶▶▶▶ Error: $1"
   exit 2
}

if ! grep -q psmouse-dkms-alpsv7 dkms.conf; then
   echo "Please run this script from the source directory for '$M'".
   exit 1
fi

echo "────── Building with dkms ───────"
echo
dkms add .
dkms build -m "$M" -v "$V" || abort "Build failed" 


echo "────── Installing with dkms ───────"
echo
dkms autoinstall -m "$M" -v "$V" || abort "Install failed"
echo "Install completed."
