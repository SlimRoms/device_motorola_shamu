#!/system/bin/sh
#------------------------------------
# Yank555.lu - activate swap on shamu
#------------------------------------

# - zSwap activation - 1024Mb
if [ -e /sys/block/vnswap0/disksize ] ; then

  /system/xbin/swapoff /dev/block/vnswap0

  echo 1073741824 > /sys/block/vnswap0/disksize

  /system/xbin/mkswap /dev/block/vnswap0

  /system/xbin/swapon /dev/block/vnswap0
  
fi

# - swappiness set to 60 (stock)
echo 60 > /proc/sys/vm/swappiness

