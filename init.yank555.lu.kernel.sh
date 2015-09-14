#!/system/bin/sh
#--------------------------------------------------
# Yank555.lu - generated kernel options init script
#--------------------------------------------------

log_file="/data/kernel-boot.log"

echo "----------------------------------------------------" >$log_file
echo "Yank555.lu - execution of kernel options init script" >>$log_file
echo "----------------------------------------------------" >>$log_file
echo "Kernel version : `uname -a`" >>$log_file
echo "Busybox used   : `which busybox`" >>$log_file

echo `date +"%F %R:%S : Checking for Yank555.lu kernel..."` >>$log_file

if [ "`uname -r | grep Yank555.lu`" == "" ]
  then
    echo `date +"%F %R:%S : No Yank555.lu kernel found, skip executing the config file"` >>$log_file
    exit
fi;

echo `date +"%F %R:%S : Yank555.lu kernel found, continue executing the config file..."` >>$log_file

echo `date +"%F %R:%S : Waiting for Android to start..."` >>$log_file

# Wait until we see some android processes to consider boot is more or less complete (credits to AndiP71)
while ! pgrep com.android ; do
  sleep 1
done

echo `date +"%F %R:%S : Android is starting up, let's wait another 30 seconds..."` >>$log_file

# Now that is checked, let's just wait another tiny little bit
sleep 30

echo `date +"%F %R:%S : Starting kernel configuration..."` >>$log_file

#----------------------------------------------------

# - SELinux Enforcing
setenforce 1
echo `date +"%F %R:%S : SELinux set to enforcing."` >>$log_file

# - init.d support by kernel/ramdisk not installed
echo `date +"%F %R:%S : Init.d script execution support disabled."` >>$log_file
ls -al /system/etc/init.d >>$log_file

# Set Userspace DVFS access to ignore
echo 1 > /sys/kernel/cpufreq_hardlimit/userspace_dvfs_lock
echo `date +"%F %R:%S : Userspace DVFS access set to ignore."` >>$log_file

# Set CPU Governor
echo "yankactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu1/online
echo "yankactive" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu2/online
echo "yankactive" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
echo 1 > /sys/devices/system/cpu/cpu3/online
echo "yankactive" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
echo `date +"%F %R:%S : CPU governor set to yankactive."` >>$log_file
restorecon_recursive /sys/devices/system/cpu/cpufreq
echo `date +"%F %R:%S : Restore SELinux context for CPU governor."` >>$log_file

# Set CPU min. screen on frequency
echo 300000 > /sys/kernel/cpufreq_hardlimit/scaling_min_freq_screen_on
echo `date +"%F %R:%S : CPU min. screen on frequency hardlimit set to 0.30GHz."` >>$log_file

# Set CPU min. screen off frequency
echo 300000 > /sys/kernel/cpufreq_hardlimit/scaling_min_freq_screen_off
echo `date +"%F %R:%S : CPU min. screen off frequency hardlimit set to 0.30GHz."` >>$log_file

# Set CPU max. screen on frequency hardlimit
echo 2649600 > /sys/kernel/cpufreq_hardlimit/scaling_max_freq_screen_on
echo `date +"%F %R:%S : CPU max. screen on frequency hardlimit set to 2.65GHz."` >>$log_file

# Set CPU max. screen off frequency hardlimit
echo 2649600 > /sys/kernel/cpufreq_hardlimit/scaling_max_freq_screen_off
echo `date +"%F %R:%S : CPU max. screen off frequency hardlimit set to 2.65GHz."` >>$log_file

# Set CPU min. wakeup kick frequency
echo 1958400 > /sys/kernel/cpufreq_hardlimit/wakeup_kick_freq
echo `date +"%F %R:%S : CPU min. wakeup kick frequency set to 1.96GHz."` >>$log_file

# Set CPU min. wakeup kick delay
echo 3000 > /sys/kernel/cpufreq_hardlimit/wakeup_kick_delay
echo `date +"%F %R:%S : CPU min. wakeup kick delay set to 3 seconds."` >>$log_file

# Set CPU min. touchboost delay
echo 1000 > /sys/kernel/cpufreq_hardlimit/touchboost_delay
echo `date +"%F %R:%S : CPU min. touchboost delay set to 1 second."` >>$log_file

# Set CPU min. touchboost eventcount
echo 4 > /sys/kernel/cpufreq_hardlimit/touchboost_eventcount
echo `date +"%F %R:%S : CPU min. touchboost eventcount set to 4."` >>$log_file

# Set CPU touchboost low frequency
echo 883200 > /sys/kernel/cpufreq_hardlimit/touchboost_lo_freq
echo `date +"%F %R:%S : CPU min. touchboost low frequency set to 0.88GHz."` >>$log_file

# Set CPU touchboost high frequency
echo 1267200 > /sys/kernel/cpufreq_hardlimit/touchboost_hi_freq
echo `date +"%F %R:%S : CPU min. touchboost high frequency set to 1.27GHz."` >>$log_file

# Set CPU Hotplug driver
stop mpdecision
echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
echo 2649600 > /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
echo 1 > /sys/devices/system/cpu/cpu1/online
echo 300000 > /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_min_freq
echo 2649600 > /sys/devices/system/cpu/cpu1/cpufreq/cpuinfo_max_freq
echo 1 > /sys/devices/system/cpu/cpu2/online
echo 300000 > /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_min_freq
echo 2649600 > /sys/devices/system/cpu/cpu2/cpufreq/cpuinfo_max_freq
echo 1 > /sys/devices/system/cpu/cpu3/online
echo 300000 > /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_min_freq
echo 2649600 > /sys/devices/system/cpu/cpu3/cpufreq/cpuinfo_max_freq
echo `date +"%F %R:%S : CPU min / max reset (thanx mpdecision for the mess)."` >>$log_file
echo 1 > /sys/module/intelli_plug/parameters/intelli_plug_active
echo 0 > /sys/module/intelli_plug/parameters/touch_boost_active
echo `date +"%F %R:%S : CPU Hotplug driver set to IntelliPlug."` >>$log_file

# Set CPU Hotplug driver
echo 2 > /sys/module/intelli_plug/parameters/nr_run_profile_sel
echo `date +"%F %R:%S : IntelliPlug Profile set to Conservative."` >>$log_file

# Set CPU Hotplug driver
echo 4 > /sys/module/intelli_plug/parameters/nr_run_hysteresis
echo `date +"%F %R:%S : IntelliPlug Hysteresis set to fast (4)."` >>$log_file

# Set CPU Hotplug driver
echo 3500 > /sys/module/intelli_plug/parameters/cpu_nr_run_threshold
echo `date +"%F %R:%S : IntelliPlug Runqueue Threshold set to normal zombie (3500)."` >>$log_file

# Set CPU Thermal driver
stop thermal-engine
echo 1 > /sys/module/msm_thermal/parameters/enabled
echo 12 > /sys/module/msm_thermal/parameters/core_control_mask
echo 15 > /sys/module/msm_thermal/parameters/freq_control_mask
echo `date +"%F %R:%S : CPU Thermal driver set to IntelliThermal."` >>$log_file

# Set CPU Thermal driver
echo 80 > /sys/module/msm_thermal/parameters/limit_temp_degC
echo `date +"%F %R:%S : IntelliThermal Frequency Throttle limit set to 80 degrees celcius."` >>$log_file

# Set CPU Thermal driver
echo 85 > /sys/module/msm_thermal/parameters/core_limit_temp_degC
echo `date +"%F %R:%S : IntelliThermal Core Throttle limit set to 85 degrees celcius."` >>$log_file

# This is now an option in the ROM under Other Sounds settings
# - Vibrator strength
#echo 80 > /sys/vibrator/pwmvalue
#echo `date +"%F %R:%S : Vibrator strength set to normal (80)."` >>$log_file

# This is now an option in the ROM under Display settings
# - Enable d2tw
#echo AUTO > /sys/bus/i2c/devices/1-004a/tsp
#chmod 444 /sys/bus/i2c/devices/1-004a/tsp
#echo `date +"%F %R:%S : Double-tap to wake enabled and userspace access locked down."` >>$log_file

# Wait for everything to become ready
echo `date +"%F %R:%S : Waiting 60 seconds..."` >>$log_file
sleep 60
# Internal MMC readahead buffer size
echo 1024 > /sys/block/mmcblk0/bdi/read_ahead_kb
echo `date +"%F %R:%S : Internal MMC Readahead set to 1024Kb."` >>$log_file

# Internal MMC I/O scheduler
echo "fiops" > /sys/block/mmcblk0/queue/scheduler
echo `date +"%F %R:%S : Internal MMC scheduler set to FIOPS."` >>$log_file

# - Set color calibration to 6500k (reference)

echo "250 250 255" > /sys/devices/platform/kcal_ctrl.0/kcal
echo "243" > /sys/devices/platform/kcal_ctrl.0/kcal_sat
echo "255" > /sys/devices/platform/kcal_ctrl.0/kcal_cont
echo "1515" > /sys/devices/platform/kcal_ctrl.0/kcal_hue
echo "250" > /sys/devices/platform/kcal_ctrl.0/kcal_val
echo 1 > /sys/devices/platform/kcal_ctrl.0/kcal_enable
echo `date +"%F %R:%S : Color calibration set to "reference" 6500k (RGB=250,250,255/SAT=243/CONT=255/HUE=1515/GAMMA=250)."` >>$log_file

# - zSwap activation - 1024Mb
if [ -e /sys/block/vnswap0/disksize ] ; then

  swapoff /dev/block/vnswap0

  echo 1073741824 > /sys/block/vnswap0/disksize

  mkswap /dev/block/vnswap0

  swapon /dev/block/vnswap0

fi
echo `date +"%F %R:%S : 1024Mb zSwap support enabled."` >>$log_file

# - swappiness set to 80
echo 80 > /proc/sys/vm/swappiness;
echo `date +"%F %R:%S : Swappiness set to 80."` >>$log_file

# Set msm-adreno-tz GPU governor
echo "msm-adreno-tz" > /sys/devices/fdb00000.qcom,kgsl-3d0/devfreq/fdb00000.qcom,kgsl-3d0/governor
echo `date +"%F %R:%S : GPU governor set to msm-adreno-tz."` >>$log_file

# Set Simple GPU algorithm (faux123)
echo 1 > /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate
echo `date +"%F %R:%S : Simple GPU algorithm set to enabled."` >>$log_file

# Set Simple GPU algorithm laziness (faux123)
echo 0 > /sys/module/simple_gpu_algorithm/parameters/simple_laziness
echo `date +"%F %R:%S : Simple GPU algorithm laziness set to 0."` >>$log_file

# Set Simple GPU algorithm ramp down threshold (faux123)
echo 0 > /sys/module/simple_gpu_algorithm/parameters/simple_ramp_threshold
echo `date +"%F %R:%S : Simple GPU algorithm ramp down threshold set to 0."` >>$log_file

# Set GPU max freq to 600MHz
echo 600000000 > /sys/devices/fdb00000.qcom,kgsl-3d0/devfreq/fdb00000.qcom,kgsl-3d0/max_freq
echo `date +"%F %R:%S : GPU max. freq. set to 600MHz."` >>$log_file

echo `date +"%F %R:%S : Finished kernel configuration."` >>$log_file

chmod 644 $log_file

#--------------------------------------------------
# End of generated script
#--------------------------------------------------
