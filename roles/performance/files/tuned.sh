swapoff -a

for disk in /sys/block/sd?
do
echo 1 > $disk/queue/nomerges
echo 8 > $disk/queue/read_ahead_kb
echo deadline > $disk/queue/scheduler
done

for cpu in /sys/devices/system/cpu/cpu?
do
echo performance > $cpu/cpufreq/scaling_governor
done

