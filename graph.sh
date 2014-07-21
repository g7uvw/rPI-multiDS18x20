#!/bin/bash
INCOLOUR="#FF0000"
OUTCOLOUR="#0000FF"
TRENDCOLOUR="#000000"

CRIMSON="#B0171F"
PINK="#FFC0CB"
PURPLE="#9B30FF"
BLUE="#0000FF"
CYAN="#00EEEE"
GREEN="#00C957"
LIME="#00FF00"
YELLOW="#FFFF00"
ORANGE="#FFA500"
RED="#FF0000"
BLACK="#000000"

#plot graphs for the 6 sensors in the example


#hour
rrdtool graph inside-outside.png -A --start -24h \
DEF:intemp=multirPItemp.rrd:Inside:AVERAGE \
DEF:outtemp=multirPItemp.rrd:Outside:AVERAGE \
CDEF:intrend=intemp,1200,TREND \
CDEF:outtrend=outtemp,1200,TREND \
LINE2:intemp$RED:"Inside temperature" \
LINE2:outtemp$BLUE:"Outside temperature" \
LINE1:intrend$BLACK:"20 min average" \
LINE1:outtrend$BLACK: 


rrdtool graph pressure.png -A --start -24h -L 6 \
DEF:pressure=multirPItemp.rrd:Humidity:AVERAGE \
CDEF:pressuretrend=pressure,1200,TREND \
LINE2:pressure$GREEN:"Pressure Pa" \
LINE1:pressuretrend$BLACK:"20 min average" \
GPRINT:pressure:LAST:"Current\:%8.2lf %s"  \
GPRINT:pressure:AVERAGE:"Average\:%8.2lf %s"  \
GPRINT:pressure:MAX:"Maximum\:%8.2lf %s\n" 

rrdtool graph humidity.png -A --start -24h \
DEF:humidity=multirPItemp.rrd:Pressure:AVERAGE \
CDEF:humiditytrend=humidity,1200,TREND \
LINE2:humidity$YELLOW:"Humidity %" \
LINE1:humiditytrend$BLACK:"20 min average" \
GPRINT:humidity:LAST:"Current\:%8.2lf %s"  \
GPRINT:humidity:AVERAGE:"Average\:%8.2lf %s"  \
GPRINT:humidity:MAX:"Maximum\:%8.2lf %s\n" 
