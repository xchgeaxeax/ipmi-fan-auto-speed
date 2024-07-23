# ipmi-fan-auto-speed
Dell PowerEdge R730XD FanSpeed Controls via IPMI

## background

R730XD can auto control the fan speed by default, but when plug in a PCIe device which is not in the iDRAC database, the fan speed will boost almost max.
Formerly, with ESXi installed on the server, the sensor readings can not be easily got neither in vm nor in host just use `sensors`.
To automatically adjust the speed, I use `ipmitools` to get sensor readings.

After Broadcom acquired VMware, I uninstalled all VMware products. I use Proxmox VE on my server now.
then I can directly get sensor readings from host without network. It is much safer to prevent the server get overheat when the network is down.

## how to

I use cron to exec this script every minute.

install ipmitool use your package manager such as `apt-get install ipmitool -y`

upload the script such as `/root/autospeed.sh`

`chmod +x /root/autospeed.sh`

`echo "* * * * * root /root/autospeed.sh" | sudo tee -a /etc/crontab`

`systemctl restart cron`


### In VM

use autospeed.sh, and set variables in the script to make connection.

### Linux host

just use autospeed-host.sh.
