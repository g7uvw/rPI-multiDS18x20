#!/usr/bin/perl
use strict;
use warnings;

#sub get_device_IDs
#{
# The Hex IDs off all detected 1-wire devices on the bus are stored in the file
# "w1_master_slaves"

# we read this file, and make a new fixed file with all the device IDs and fixed indexes. You can also put
# calibration information into the sensors.conf file after detect.pl has created it.
# sensors.conf format is:
# 
# index , calibration factor 	, 1-Wire Device ID
# 0		,0.0					, 10-000802b67ffc
# 1		,0.0					, 10-000802b65cc2
# 2		,0.0					, 10-000802b685ca
# 3		,0.0					, 10-000802b6689e
# 4		,0.0					, 10-000802b68df3
# 5		,0.0					, 10-000802b67687

# or you can use descriptive names for the device ID, but again you'll have to edit the sensors.conf file to
# add them after detect.pl has created sensors.conf for you.
#
# index 		, calibration factor , 1-Wire Device ID
# inside		,0.0					,10-000802b67ffc
# the sun		,100.123				,10-000802b65cc2
# deepspace		,-273.1					,10-000802b685ca
# earth's core	,6000					,10-000802b6689e
# outside		,-1.2					,10-000802b68df3
# spare			,0.0					,10-000802b67687
 

# open file
open(INFILE, "/sys/bus/w1/devices/w1_bus_master1/w1_master_slaves") or die("Unable to open file");
 
# read file into an array
my @deviceIDs = <INFILE>; 
close(INFILE);

my $index;
open(OUTFILE,">", "sensors.conf") or die ("Unable to create sonsors.conf");
foreach (@deviceIDs) {
	print OUTFILE $index++ . "," . "0.0" . "," . $_;
}
close(OUTFILE);


