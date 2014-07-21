$pressure = `sudo python pressure.py`;
$humidity = `sudo python humidity.py 11 17`;

chomp($pressure);
chomp($humidity);
print "Pressure = $pressure Pa, Humidity = $humidity % \n";
