#!usr/bin/perl -w
use strict;

# dxfxgacabxfxhxhxhxhxhx

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

osCheck();

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
		chomp($result = <>);

		system("clear");
		print "Your choise is not correct! plz try again\n" if(length($result)!=3);

	}while(length($result)!=3);

	assign(substr($result,0,2),substr($result,2,1));
	print "Your setting: '".$setting."'\n";
}

print "Plz restart your bash to see the result\n";
store($setting);

sub assign
{
	my ($l,$r) = @_;
	my $fg;
	my $bg;

	# Default value white foreground with black background
	$l = "07" if $l gt "15";
	$r = "0"  if $r gt "7";
	
	# For foreground color
	$fg = "a" if $l eq "00"; 
	$fg = "b" if $l eq "01"; 
	$fg = "c" if $l eq "02"; 
	$fg = "d" if $l eq "03"; 
	$fg = "e" if $l eq "04"; 
	$fg = "f" if $l eq "05"; 
	$fg = "g" if $l eq "06"; 
	$fg = "h" if $l eq "07"; 
	$fg = "A" if $l eq "08"; 
	$fg = "B" if $l eq "09"; 
	$fg = "C" if $l eq "10"; 
	$fg = "D" if $l eq "11"; 
	$fg = "E" if $l eq "12"; 
	$fg = "F" if $l eq "13"; 
	$fg = "G" if $l eq "14"; 
	$fg = "H" if $l eq "15"; 
	
	#for background color
	$bg = "a" if $r eq "0"; 
	$bg = "b" if $r eq "1"; 
	$bg = "c" if $r eq "2"; 
	$bg = "d" if $r eq "3"; 
	$bg = "e" if $r eq "4"; 
	$bg = "f" if $r eq "5"; 
	$bg = "g" if $r eq "6"; 
	$bg = "h" if $r eq "7"; 

	$setting .= $fg.$bg;
}

sub store
{
  my ($set) = @_;
  my $path  = $ENV{HOME}."/.profile";
  my $all;

  # If it exists
  if(-e $path)
  {
    open IN, "<", $path;
    while(<IN>)
    {
      s/export LSCOLORS=".*"/export LSCOLORS="$set"/;
      $all .= $_; 
    }
    close IN; 
  }
  else
  {
    $all .= "export LSCOLORS=\"$set\"";
  }

  open OUT, ">", $path;
  print OUT $all;
  close OUT;
}

sub osCheck
{
  die("Support Mac OS X only!") if $^O ne "darwin";
}
