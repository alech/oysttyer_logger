use JSON;

#use strict;
#use warnings;

sub tweet_file {
	my $year = shift;
	my $month = shift;
        my $day = shift;
	return $extpref_logger_dest . '/' . $year . "_" . $month . "_" . $day . ".js";
}

sub add_tweet_to_tweet_file {
	my $year = shift;
	my $month = shift;
        my $day = shift;
	my $ref = shift;

	my $outfilename = tweet_file($year, $month, $day);
	open(my $out, '>>', $outfilename);
	my $json = JSON->new();
	$json->utf8();
	print $out $json->encode($ref) . "\n";

	close($out);
}

$handle = sub {
	my $ref = shift;

        my $now = time;
	my ($sec, $min, $hour, $day, $month, $year, $wday, $yday, $isdst) =
                gmtime($now);
        $ref->{'__oysttyer_logger_seen_at'} = $now;

	$month += 1;
	$month = sprintf("%02d", $month);
	$year += 1900;
	add_tweet_to_tweet_file($year, $month, $day, $ref);
	
	&defaulthandle($ref);
	return 1;
}
