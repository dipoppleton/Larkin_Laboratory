#/usr/bin/perl -w
use strict;
use Data::Dumper;
require "/home/mf485/scripts/modules/mergeBlocks.pm";

#Parses mashmap.out files to EH format
#Joana Damas & Marta Farre
#22 November 2018

my $input = $ARGV[0]; #input coord file
#Format: tar_ID tar_len tar_start tar_end dir ref_ID ref_len ref_start ref_end %identity 
#Scaffold_1;HRSCAF=3 87124392 0 65199999 + Scaffold_4060;HRSCAF=4164 86449535 14451 64684615 99.7292
my $output = $ARGV[1]; #output file without extension
my $refID = $ARGV[2];
my $tarID = $ARGV[3];
my $resolution = $ARGV[4];

my $new_res = $resolution - 1;
$resolution = $new_res; 

my %data;

my $cnt = 0;
open (IN, $input) or die "Couldn't open $input!\n";
while (<IN>) {
	chomp;
	my @tmp = split(/\s+/, $_);
	my $tarid = $tmp[0];
	if (exists $data{$tarid}) {
		#print "$tarid broken\n";
		push(@{$data{$tarid}}, join("*", @tmp));
	}
	else {
		@{$data{$tarid}} = join("*", @tmp);
	}
}
close IN;
#print Dumper %data;

#Convert to EH format
open (EHOUT, ">$output.EH") or die "Couldn't create $output.EH";
foreach my $key (keys %data){
	foreach my $val (@{$data{$key}}){
		my @tmp = split(/\*/, $val);
		my $lentar = $tmp[3] - $tmp[2]; 
		my $lenref = $tmp[8] - $tmp[7];
		#print "$lenref\t$lentar\n";
		if ($lenref >= $resolution && $lentar >= $resolution){
			my $or = "+1";
			if ($tmp[4] eq "-"){ $or = "-1"; }
			my $nstart = $tmp[2];
			my $nend = $tmp[3];
			my $nrstart = $tmp[7];
			my $nrend = $tmp[8];

			my $chr1 = $tmp[5];
			# $chr1 =~ s/[Cc]hr//;
			# $chr1 =~ s/[Ss]caffold//;
			# $chr1 =~ s/[Cc]ontig/ctg/;

			my $chr2 = $tmp[0];
			# $chr2 =~ s/[Cc]hr//;
			# $chr2 =~ s/[Ss]caffold/scf/;
			# $chr2 =~ s/[Cc]ontig/ctg/;

			#0		1		2		  3		  4	  5		 6		 7		   8	   9
			#tar_ID tar_len tar_start tar_end dir ref_ID ref_len ref_start ref_end %identity 
			print EHOUT "$refID,$chr1,$nrstart,$nrend,$nstart,$nend,$or,$tarID,$chr2,$chr2\n";
		}
	}
	
}
close EHOUT;

MergeBlocks::mergeBlocks("$output.EH", $resolution);
