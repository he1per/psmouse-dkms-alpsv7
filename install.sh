#!/bin/sh

source ./dkms.conf

MDIR="/usr/lib/modules/$(uname -r)"
NEWMDIR="$MDIR/${DEST_MODULE_LOCATION[0]}"

MFILE="$MDIR/kernel/drivers/input/mouse/${BUILT_MODULE_NAME[0]}.ko"
NEWMFILE="$NEWMDIR/${BUILT_MODULE_NAME[0]}.ko"

M=psmouse-dkms-alpsv7
V=1.0

#Print error message and exit
abort()
{
   echo "▶▶▶▶ Error: $1"
   exit 2
}


#Make sure script is ran from base directory
if ! grep -q psmouse-dkms-alpsv7 dkms.conf; then
   echo "Please run this script from the source directory for '$M'".
   exit 1
fi

#Build module
echo "────── Building with dkms ───────"
echo
dkms add .
dkms build -m "$M" -v "$V" || abort "Build failed" 

#Backup old module
if [ -f "$MFILE" ]; then
   mv "$MFILE" "$MFILE.orig" || abort "Unable to backup old module. Aborting." 
   cp "$NEWMFILE" "$MFILE"
   echo " ** Old module backed up as:"
   echo "    '$MFILE.orig'"

elif [ -f "$MFILE.gz" ]; then
   mv "$MFILE.gz" "$MFILE.gz.orig" || abort "Unable to backup old module. Aborting." 
   cp "$NEWMFILE" "$MFILE"
   echo " ** Old module backed up as:"
   echo "    '$MFILE.gz.orig'"
   gzip -9 "$MFILE"
   GZIP=.gz
fi


#Install module and gzip it if old module was gzipped
echo
echo
echo "────── Installing with dkms ───────"
echo
dkms install -m "$M" -v "$V" || abort "Install failed"
echo "Install completed."
if [ -f "$MFILE$GZIP" ]; then
   echo "Install succeded, new module found."
fi

#Remove old module and modprobe new one
echo "Removing old module."
rmmod psmouse 2>&1 > /dev/null
echo "modprobe of new module..."
if ! modprobe psmouse; then
   #Restore backup if modprobe failed
   echo "modprobe psmouse failed, restoring old module."
   mv "$MFILE$GZIP.orig" "$MFILE$GZIP" 
   rmmod psmouse
   modprobe psmouse || abort "Unable to modprobe old module! Sorry!"
fi
echo "ok."
