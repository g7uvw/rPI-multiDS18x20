#!/usr/bin/perl
use strict;
use warnings;

# this creates the RRDtool db for as many devices as detect.pl locates.
# it sets up some averages too. Check RRDtool docs for more information.

# If you've run detect.pl before, sensors.conf should be a CSV file containing a list of indicies and deviceIDs
# Pull them into a hash here for processing later

my @sensornames;
my $sn;
my $commandline = "rrdtool create multirPItemp.rrd  --step 300 \\";
my $averagelines = "RRA:AVERAGE:0.5:1:12 \\RRA:AVERAGE:0.5:1:288 \\RRA:AVERAGE:0.5:12:168 \\RRA:AVERAGE:0.5:12:720 \\RRA:AVERAGE:0.5:288:365";
my $DSlines = "";

# open file
open(INFILE, "sensors.conf") or die("Can't find sensors.conf, did you run detect.pl first?");

while(<INFILE>)
{
	chomp;
	(my $index, my $cal, my $ID) = split(/,/);
	$index =~ s/\s*$//g;
	push(@sensornames, $index);
}
	close(INFILE);

foreach $sn(@sensornames)
{
	$DSlines .= "DS:". $sn . ":GAUGE:600:-30:200000 \\";
}

$commandline .= $DSlines;
$commandline .= $averagelines;
print $commandline . "\n";
system ($commandline);





