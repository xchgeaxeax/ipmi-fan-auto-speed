#!/bin/bash


# Set variables

host="ip"
user="root"
password="pass"

# define some temp for server
low="50"
mid1="58"
mid2="66"
high="74"
hot="89"

maxtemp=0

# Read the max CPU temp from sensors (ipmitools)
# On Dell R730XD this can figure out the temp of CPU 1 and 2, then use the max value
tempCpu1=$(ipmitool  sdr entity 3.1|grep Temp|sed 's/Temp             | 0Eh | ok  |  3.1 | //' | sed 's/ degrees C//')
tempCpu2=$(ipmitool  sdr entity 3.2|grep Temp|sed 's/Temp             | 0Fh | ok  |  3.2 | //' | sed 's/ degrees C//')


if [ "$tempCpu1" -gt "$tempCpu2" ]; then
    maxtemp=$tempCpu1
else
    maxtemp=$tempCpu2
fi



# Define CPU limit


if [ $maxtemp -le $low ] ; then

        ipmitool  raw 0x30 0x30 0x01 0x00 >> /dev/null
        ipmitool  raw 0x30 0x30 0x02 0xff 21 >> /dev/null

elif [ $maxtemp -le $mid1 ] ; then

        ipmitool  raw 0x30 0x30 0x01 0x00 >> /dev/null
        ipmitool  raw 0x30 0x30 0x02 0xff 23 >> /dev/null

elif [ $maxtemp -le $mid2 ] ; then

        ipmitool  raw 0x30 0x30 0x01 0x00 >> /dev/null
        ipmitool  raw 0x30 0x30 0x02 0xff 27 >> /dev/null

elif [ $maxtemp -le $high ] ; then

        ipmitool  raw 0x30 0x30 0x01 0x00 >> /dev/null
        ipmitool  raw 0x30 0x30 0x02 0xff 31 >> /dev/null

elif [ $maxtemp -le $hot ] ; then

        ipmitool  raw 0x30 0x30 0x01 0x00 >> /dev/null
        ipmitool  raw 0x30 0x30 0x02 0xff 35 >> /dev/null

# If temp higher than hot, give fan control back to BIOS
else
        ipmitool  raw 0x30 0x30 0x01 0x01 >> /dev/null

fi

