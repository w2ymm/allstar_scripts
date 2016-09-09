# !/bin/bash

# Script to control and strobe BCD lines to RPi2
# Call with Decimal Digit 1-16 to control
# WA3DSP 9/2015

# Can be called from rpt.conf functions, through the dial plan, cron, etc.
# As wriiten requires 2 digits - 01,02,..16
# 01 = all bits low - 16 = all bits high

#Set STROBE = 1 for systems needing a strobe bit
STROBE="0"

if [ -z $1 ] 
 then
   echo "No channel given (01-16)"
   exit 0
fi

# Define RPi2 bits - use gpio readall - wPi pins

BCD1=21
BCD2=22
BCD4=23
BCD8=24

# Define strobe bit if required

BCD_STROBE=25  

case "$1" in

  01) echo "Channel 1"
     BCD_data1=0
     BCD_data2=0
     BCD_data4=0
     BCD_data8=0
     ;;

  02) echo "Channel 2"
     BCD_data1=1
     BCD_data2=0
     BCD_data4=0
     BCD_data8=0
     ;;

  03) echo "Channel 3"
     BCD_data1=0
     BCD_data2=1
     BCD_data4=0
     BCD_data8=0
     ;;


  04) echo "Channel 4"
     BCD_data1=1
     BCD_data2=1
     BCD_data4=0
     BCD_data8=0
     ;;

  05) echo "Channel 5"
     BCD_data1=0
     BCD_data2=0
     BCD_data4=1
     BCD_data8=0
     ;;

  06) echo "channel 6"
     BCD_data1=1
     BCD_data2=0
     BCD_data4=1
     BCD_data8=0
     ;;

  07) echo "Channel 7"
     BCD_data1=0
     BCD_data2=1
     BCD_data4=1
     BCD_data8=0
     ;;

  08) echo "Channel 8"
     BCD_data1=1
     BCD_data2=1
     BCD_data4=1
     BCD_data8=0
     ;;

  09) echo "Channel 9"
     BCD_data1=0
     BCD_data2=0
     BCD_data4=0
     BCD_data8=1
     ;;

 10) echo "Channel 10"
     BCD_data1=1
     BCD_data2=0
     BCD_data4=0
     BCD_data8=1
     ;;

 11) echo "Channel 11"
     BCD_data1=0
     BCD_data2=1
     BCD_data4=0
     BCD_data8=1
     ;;

 12) echo "Channel 12"
     BCD_data1=1
     BCD_data2=1
     BCD_data4=0
     BCD_data8=1
     ;;

 13) echo "channel 13"
     BCD_data1=0
     BCD_data2=0
     BCD_data4=1
     BCD_data8=1
     ;;

 14) echo "Channel 14"
     BCD_data1=1
     BCD_data2=0
     BCD_data4=1
     BCD_data8=1
     ;;

 15) echo "Channel 15"
     BCD_data1=0
     BCD_data2=1
     BCD_data4=1
     BCD_data8=1
     ;;

 16) echo "channel 16"
     BCD_data1=1
     BCD_data2=1
     BCD_data4=1
     BCD_data8=1
     ;;

  *) echo "Invalid entry $1"
     echo "Two digits 01-16 Valid"
     exit 1
     ;;

esac

# Initialize lines

gpio mode $BCD1 out
gpio mode $BCD2 out
gpio mode $BCD4 out
gpio mode $BCD8 out

if [ "$STROBE" = "1" ]
   then
      gpio mode $BCD_STROBE out
      gpio write $BCD_STROBE 0
fi

# Setup BCD lines

gpio write $BCD1 $BCD_data1
gpio write $BCD2 $BCD_data2
gpio write $BCD4 $BCD_data4
gpio write $BCD8 $BCD_data8

if [ "$STROBE" = "1" ]
   then
    # Lower strobe for 100 ms
    gpio toggle $BCD_STROBE
    sleep .1
    gpio toggle $BCD_STROBE
    echo "Strobe bit sent"
fi

echo "Channel $1 written to BCD - $BCD_data8$BCD_data4$BCD_data2$BCD_data1"

exit 0 



