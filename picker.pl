#!usr/bin/perl -w
use strict;

# Use the package
use Term::ANSIColor;
use Term::ANSIColor qw(:constants);

# These are ls options
my @options = qw{directory symbolic_Link socket pipe executable block_special character_special executable_with_setuid_bit_set executable_with_setgid_bit_set directory_writable_to_others_with_sticky_bit directory_writable_to_others_without_sticky_bit};

# Get the foreground color
my $list = qq{BLACK,RED,GREEN,YELLOW,BLUE,MAGENTA,CYAN,WHITE,BOLD BLACK,BOLD RED,BOLD GREEN,BOLD YELLOW,BOLD BLUE,BOLD MAGENTA,BOLD CYAN,BOLD WHITE};
my @foreground = split(',',$list);

# Get the background color
my @background = qw{ON_BLACK ON_RED ON_GREEN ON_YELLOW ON_BLUE ON_MAGENTA ON_CYAN ON_WHITE};

# User settings
my $setting = '';

my $result;

foreach my $option (@options)
{
	do{

		local $Term::ANSIColor::AUTORESET = 1;
		print "Set your own '".$option."' color::\n";

		my $fgCount=0;
		my $bgCount=0;

    # Display the color options for each ls option
		foreach my $fg (@foreground)
		{
			foreach my $bg (@background)
			{
				local $Term::ANSIColor::AUTORESET = 1;
				#format
				print "0" if $fgCount < 10; 
				print $fgCount.$bgCount.")";
				print colored("TEST",$fg.' '.$bg);
				print " ";
				$bgCount++;
			}
			print "\n";
			$bgCount=0;
			$fgCount++;
		}

		print "Plz type the number shown on the top.\n>> ";

		# Get the result from the user
		$result = <>;
		chomp($result);
		system("clear");
		print "Your choise is not correct! plz try again\n" if(length($result)!=3);

	}while(length($result)!=3);

	assign(substr($result,0,2),substr($result,2,1));
	print "Your setting: '".$setting."'\n";
}

print "Plz restart your bash to see the result\n";
fileIO($setting);

sub assign
{
	my ($l,$r) = @_;
	my $fg;
	my $bg;

	# Default value white foreground with black background
	$l = "07" if ($l gt "15");
	$r = "0"  if ($r gt "7");
	
	# For foreground color
	$fg = "a" if $l cmp "0"; 
	$fg = "b" if $l cmp "1"; 
	$fg = "c" if $l cmp "2"; 
	$fg = "d" if $l cmp "3"; 
	$fg = "e" if $l cmp "4"; 
	$fg = "f" if $l cmp "5"; 
	$fg = "g" if $l cmp "6"; 
	$fg = "h" if $l cmp "7"; 
	$fg = "A" if $l cmp "8"; 
	$fg = "B" if $l cmp "9"; 
	$fg = "C" if $l cmp "10"; 
	$fg = "D" if $l cmp "11"; 
	$fg = "E" if $l cmp "12"; 
	$fg = "F" if $l cmp "13"; 
	$fg = "G" if $l cmp "14"; 
	$fg = "H" if $l cmp "15"; 
	
	#for background color
	$bg = "a" if $r cmp "0"; 
	$bg = "b" if $r cmp "1"; 
	$bg = "c" if $r cmp "2"; 
	$bg = "d" if $r cmp "3"; 
	$bg = "e" if $r cmp "4"; 
	$bg = "f" if $r cmp "5"; 
	$bg = "g" if $r cmp "6"; 
	$bg = "h" if $r cmp "7"; 

	$setting .= $fg.$bg;
}

sub fileIO
{
  my ($set) = @_;
  my $path  = $ENV{HOME}."/.profile";
	my $check = 0;
  my $all;

  open IN, "<", $path;
  
  while($_ = <IN>)
  {
    $check = 1 if s/export LSCOLORS=".*"/export LSCOLORS="$set"/;
    $all .= $_; 
  }
	
	$all .= 'export LSCOLORS="$set"' if $check==0;
  open OUT, ">", $path;
  print OUT $all;
  
  close IN; 
  close OUT;
}
