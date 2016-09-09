
OK, here is how to do it. First add the attached script and check -

Put bcd_control.sh  in /etc/asterisk/local

Make it executable  -

chmod 750 bcd_control.sh

Get your hardware connected. The script defaults to RPI2 WPi pins 21, 22, 23, 24 - hardware pin numbers 29, 31, 33, 35

You can run the script manually standalone and see how it works. Channels are  01-16. 
They must be entered as 2 digits, preceding 0 for channels less than 10.

Channel 01-15 are BCD channels. Channel 16 is all high or front panel.

Use 'gpio readall' to see bits and how they change with the program. You can do this without anything connected to the Pi.

Once you have it working add this line to rpt.conf -

62=autopatchup,context=radio_control,noct=1,farenddisconnect=1,dialtime=7000,quiet=1

The function does not have to be 62 but that is convenient. Could be any unused code that does not conflict. 
If you are extremely slow entering digits you can set the dialtime higher but 7 seconds should be fine for 5 digits in most cases.

Then add this to your extensions.conf  file, can be at the end.

[radio_control]
exten => _xx,1,System(/etc/asterisk/local/bcd_control.sh ${EXTEN})
exten => _xx,n,Hangup()

Restart Asterisk -

astres.sh

Now you should have DTMF control of your channels.

*6201  thru *6215 = channels and *6216 would be front panel.  

You could get fancy and add Asterisk audio feedback in the script to tell you what channel it is on. If you need an example I can show you.

Let me know how it works for you. If you need more channels the script could be modified to control another bit for 32 channels.

73 Doug
WA3DSP

Note***
Additional infor about Channel Steering can be found at
http://www.repeater-builder.com/motorola/maxtrac/gm300-info.html
and http://www.repeater-builder.com/motorola/maxtrac/remote-channel-select.html

