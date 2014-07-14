#!/usr/bin/perl
use strict;
use warnings;

#made sure we've got the 1-wire modules loaded
&check_modules;

#load up the device ID file.
&get_device_IDs;

use vars qw(%deviceIDs %deviceCal);

my $count = 0;
my $reading = -1;
my $device = -1;
#my @deviceIDs;
my @temp_readings;
my %T_readings  = ();
my $templateline = " --template ";
my $updateline = " N:";
my $commandline = "rrdtool update multirPItemp.rrd"; #change to match your file locations


for my $key ( keys %deviceIDs ) {
    my $ID = $deviceIDs{$key};
    $reading = &read_device($ID);
    if ($reading == 9999) {
       $reading = "U";
    }
    $T_readings{$key} = $reading + $deviceCal{$key};
    $templateline .= $key;
    $templateline .= ":";
    $updateline .= $T_readings{$key} . ":";
    }

#ditch extra ":" that makes rrdtool fail
chop($templateline);
chop($updateline);

$commandline .= $templateline;
$commandline .= $updateline;
print $commandline ."\n";
system ($commandline);


sub check_modules
{
   my $mods = `cat /proc/modules`;
if ($mods =~ /w1_gpio/ && $mods =~ /w1_therm/)
{
 #print "w1 modules already loaded \n";
}
else 
{
print "loading w1 modules \n";
	`sudo modprobe wire`;
    `sudo modprobe w1-gpio`;
    `sudo modprobe w1-therm`;
} 
}



sub get_device_IDs
{
# If you've run detect.pl before, sensors.conf should be a CSV file containing a list of indicies and deviceIDs
# Pull them into a hash here for processing later

# open file
open(INFILE, "sensors.conf") or die("Unable to open file");

while(<INFILE>)
{
	chomp;
	(my $index, my $cal, my $ID) = split(/,/);
	$index =~ s/\s*$//g;
	$deviceIDs{$index} = $ID;
	$deviceCal{$index} = $cal;
}

close(INFILE);
}




sub read_device
{
    #takes one parameter - a device ID
    #returns the temperature if we have something like valid conditions
    #else we return "9999" for undefined

    my $deviceID = $_[0];
    $deviceID =~ s/\R//g;
 
    my $ret = 9999; # default to return 9999 (fail)
   
    my $sensordata = `cat /sys/bus/w1/devices/${deviceID}/w1_slave 2>&1`;
    #print "Read: $sensordata";


   if(index($sensordata, 'YES') != -1) {
      #fix for negative temps from http://habrahabr.ru/post/163575/
      $sensordata =~ /t=(\D*\d+)/i;
      #$sensor_temp =~ /t=(\d+)/i;
      $sensordata = (($1/1000));
      $ret = $sensordata;
   } else {
      print ("CRC Invalid for device $deviceID.\n");
   }

   return ($ret);
}
