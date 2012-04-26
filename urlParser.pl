#!/usr/bin/perl
my $file;
open FILE, "<listOfPokemon.txt" or die("Could not open file!");

use strict;
use warnings;

use LWP::Simple;
my $pokemon = ""; 
foreach $pokemon (<FILE>){
chomp $pokemon;
my $url = "http://pokemon.wikia.com/wiki/".$pokemon;
my $website_content = get($url);

print "Name: ".$pokemon."\n";
my $name = $pokemon;
if($website_content =~ /National Dex<\/a>:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> #(.[0-9*]+)/)
{
	print "National Dex: ";
	my $index = $2;
	print $index."\n";
}

if($website_content =~ /<td colspan="2" rowspan="7"> <div class="center"><div class="floatnone"><a href="((http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:\/~\+#]*[\w\-\@?^=%&amp;\/~\+#])?)"/)
{
	use Image::Grab qw(grab);
	my $image = $1;
	print $image."\n";
	my $pic = grab(URL=>$image);
	open(IMAGE, ">".$name.".png") || die $name."png: $!";
	print IMAGE $pic;
	close(IMAGE);
}

if ( $website_content =~ /<b>Evolves From:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> (<(\w+)((?:\s+\w+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>)/) 
{
	print "Evolves From: ";
	my $evolveFrom = $2;
	if($evolveFrom =~ /<a href="\/wiki\/([a-zA-Z0-9]*)/)
        {
                my $TevolvesFrom = $1;
                print $TevolvesFrom."\n";
        }

}else {print "Evolves From: None\n";}

if($website_content =~ /<b>Evolves Into:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> (<(\w+)((?:\s+\w+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>)/)
{
	print "Evolves To: ";
	my $evolvesTo = $2;

	if($evolvesTo =~ /<a href="\/wiki\/([a-zA-Z0-9]*)/)
	{
		my $TevolvesTo = $1;
		print $TevolvesTo."\n";
	}
}

if($website_content =~ /<b>Pronunciation:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em; font:math;"> <span class="texhtml">(.*)/)
{
	print "Pronunciation: ";
	
	my $pro = $2;
	print $pro."\n";
}

if($website_content =~ /<b>HP:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> ([0-9]*)/)
{
	print "HP: ";
	my $hp = $2;
	print $hp."\n";
}
if($website_content =~ /<b>Attack:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> ([0-9]*)/)
{
	print "Attack: ";
	my $atk = $2;
	print $atk."\n";
}
if($website_content =~ /<b>Defense:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> ([0-9]*)/)
{
	print "Defense: ";
	my $def = $2;
	print $def."\n";
}
if($website_content =~ /<b>Special Atk:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> ([0-9]*)/)
{
	print "Special Atk: ";
	my $spAtk = $2;
	print $spAtk."\n";
}
if($website_content =~ /<b>Special Def:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> ([0-9]*)/)
{
	print "Special Def: ";
	my $spDef = $2;
	print $spDef."\n";
}
if($website_content =~ /<b>Speed:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> ([0-9]*)/)
{
	print "Speed: ";
	my $speed = $2;
	print $speed."\n";
}
if($website_content =~ /<b>Stat Total:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> ([0-9]*)/)
{
	print "Stat Total: ";
	my $stat = $2;
	print $stat."\n";
}
if($website_content =~ /<b>Type\(s\):<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> <a href="\/wiki(.*)/)
{
	print "Type(s): ";
	my $type = $2;
	my $temp = "";
	my $temp2 = "";
	my $type2 = "";
	if($type =~ />(.[A-Za-z0-9]*)<(.*)>(.[A-Za-b0-9]*)/){
		$temp = $1;
		$temp2 = $2;
		if($temp2 =~ />(.[A-Za-z0-9]*[^\/])</){
			$type2 = $1;
			$temp = $temp."/".$type2;
		}
			
	}
	print $temp."\n";
}
if($website_content =~ /<b>Height:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> <span class="explain" title="&#123;&#123;&#123;ImHeight}}}">(.*)</)
{
	print "Height: ";
	my $height  = $2;
	if($height =~ /(.*)>(.*)</){
		$height =$2;
	}
	print $height."\n";
}
if($website_content =~ /<b>Weight:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> <span class="explain" title="&#123;&#123;&#123;ImWeight}}}">(.*)</)
{
	print "Weight: ";
	my $weight = $2;
	if($weight =~ /(.*)>(.*).</){
		$weight = $2;
	}
	print $weight."\n";
}
if($website_content =~ />Abilities<\/a>:<\/b>(\n)(.*)/)
{
	print "Abilities: ";
	my $tempAbil = $2;
	my $abil = "";
	if($tempAbil =~ />(.[A-Za-z0-9]*[^\s])</){
		$abil = $1;
	}
		
	print $abil."\n";
}
if($website_content =~ /<b>Black<\/b>(\n)<\/th><\/tr>(\n)(\n)<tr style="horizantal-align: top;">(\n)<td style="padding-right: 1em;"><font size="2.5">(.[a-zA-Z0-9]*[\,\.\'\s.\D]*.)</)
{
	print "Bio: ";
	my $bio = $5;
	print $bio."\n";;
}
}
close($file);
