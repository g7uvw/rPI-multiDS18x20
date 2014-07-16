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
rrdtool graph mhour.png -A --start -24h \
DEF:mercurytemp=multirPItemp.rrd:mercury:AVERAGE \
DEF:venustemp=multirPItemp.rrd:venus:AVERAGE \
DEF:earthtemp=multirPItemp.rrd:earth:AVERAGE \
DEF:marstemp=multirPItemp.rrd:mars:AVERAGE \
DEF:jupitertemp=multirPItemp.rrd:jupiter:AVERAGE \
DEF:saturntemp=multirPItemp.rrd:saturn:AVERAGE \
CDEF:mercurytrend=mercurytemp,1200,TREND \
CDEF:venustrend=venustemp,1200,TREND \
CDEF:earthtrend=earthtemp,1200,TREND \
CDEF:marstrend=marstemp,1200,TREND \
CDEF:jupitertrend=jupitertemp,1200,TREND \
CDEF:saturntrend=saturntemp,1200,TREND \
LINE2:mercurytemp$CYAN:"mercury temperature" \
LINE1:mercurytrend$TRENDCOLOUR:"20 min average" \
LINE2:venustemp$GREEN:"venus temperature" \
LINE1:venustrend$TRENDCOLOUR \
LINE2:earthtemp$BLUE:"earth temperature" \
LINE1:earthtrend$TRENDCOLOUR \
LINE2:marstemp$RED:"mars temperature" \
LINE1:marstrend$TRENDCOLOUR \
LINE2:jupitertemp$YELLOW:"jupiter temperature" \
LINE1:jupitertrend$TRENDCOLOUR \
LINE2:saturntemp$PINK:"saturn temperature" \
LINE1:saturntrend$TRENDCOLOUR


rrdtool graph mercury.png -A --start -24h \
DEF:mercurytemp=multirPItemp.rrd:mercury:AVERAGE \
CDEF:mercurytrend=mercurytemp,1200,TREND \
LINE2:mercurytemp$CYAN:"mercury temperature" \
LINE1:mercurytrend$BLACK:"20 min average" 

rrdtool graph venus.png -A --start -24h \
DEF:venustemp=multirPItemp.rrd:venus:AVERAGE \
CDEF:venustrend=venustemp,1200,TREND \
LINE2:venustemp$GREEN:"venus temperature" \
LINE1:venustrend$BLACK:"20 min average" 

rrdtool graph earth.png -A --start -24h \
DEF:earthtemp=multirPItemp.rrd:earth:AVERAGE \
CDEF:earthtrend=earthtemp,1200,TREND \
LINE2:earthtemp$BLUE:"earth temperature" \
LINE1:earthtrend$BLACK:"20 min average" 

rrdtool graph mars.png -A --start -24h \
DEF:marstemp=multirPItemp.rrd:mars:AVERAGE \
CDEF:marstrend=marstemp,1200,TREND \
LINE2:marstemp$RED:"mars temperature" \
LINE1:marstrend$BLACK:"20 min average" 

rrdtool graph jupiter.png -A --start -24h \
DEF:jupitertemp=multirPItemp.rrd:jupiter:AVERAGE \
CDEF:jupitertrend=jupitertemp,1200,TREND \
LINE2:jupitertemp$YELLOW:"jupiter temperature" \
LINE1:jupitertrend$BLACK:"20 min average" 

rrdtool graph saturn.png -A --start -24h \
DEF:saturntemp=multirPItemp.rrd:saturn:AVERAGE \
CDEF:saturntrend=saturntemp,1200,TREND \
LINE2:saturntemp$PINK:"saturn temperature" \
LINE1:saturntrend$BLACK:"20 min average" 
