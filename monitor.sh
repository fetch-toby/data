#!/bin/bash
ALERT=50
EXCLUDE_LIST="/dev/xvda1|/sys/*|/run/*|udev|none|shm"
function main_program() {
while read output;
do
echo output
  alert=$(echo $output | awk '{ print $1}' | cut -d'%' -f1)
  if [ $alert -ge $ALERT ] ; then
     sudo rm /var/www/html/index.html
  fi
done
}
if [ "$EXCLUDE_LIST" != "" ] ; then
  df -H | grep -vE "^Filesystem|tmpfs|cdrom|${EXCLUDE_LIST}" | awk '{print $5 " " $6}' | main_program
else
  df -H | grep -vE "^Filesystem|tmpfs|cdrom" | awk '{print $5 " " $6}' | main_program
fi
