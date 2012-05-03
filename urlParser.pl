#!/usr/bin/perl
my $file;
open FILE, "<listOfPokemon.txt" or die("Could not open file!");

use strict;
use warnings;
my $curpokemon;
use LWP::Simple;
foreach $curpokemon (<FILE>){
chomp $curpokemon;


my $url = "http://pokemon.wikia.com/wiki/".$curpokemon;
my $website_content = get($url);
my $atk;
my $def;
my $spAtk;
my $spDef;
my $speed;
my $spe;
my $pro;
my $hp;
my $evolvesTo = "";
my $evolvesFrom = "None";
my $stat;
my $height;
my $weight;
my $bio;
my $abil;
my $icon;


print "Name: ".$curpokemon."\n";
my $name = $curpokemon;
if($website_content =~ /National Dex<\/a>:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> #(.[0-9*]+)/)
{
	#print "National Dex: ";
	my $index = $2;
	#print $index."\n";
}

if($website_content =~ /<td colspan="2" rowspan="7"> <div class="center"><div class="floatnone"><a href="((http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:\/~\+#]*[\w\-\@?^=%&amp;\/~\+#])?)"/)
{
	use Image::Grab qw(grab);
	my $image = $1;
	#print $image."\n";
	my $pic = grab(URL=>$image);
	open(IMAGE, ">images/".$name.".png") || die $name."png: $!";
	print IMAGE $pic;
	close(IMAGE);
}

if($website_content =~ / <b>Icon\(s\):<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> <a href="((http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:\/~\+#]*[\w\-\@?^=%&amp;\/~\+#])?)"/)
{ print "ICON:";
	use Image::Grab qw(grab);
        my $icon = $2;
        print $icon."\n";
        my $pic = grab(URL=>$icon);
        open(IMAGE, ">icons/icon_".$name.".png") || die $name."png: $!";
        print IMAGE $pic;
        close(IMAGE);

}

if ( $website_content =~ /<b>Evolves From:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> (<(\w+)((?:\s+\w+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>)/) 
{
	#print "Evolves From: ";
	 $evolvesFrom = $2;
	if($evolvesFrom =~ /<a href="\/wiki\/([a-zA-Z0-9]*)/)
        {
                 $evolvesFrom = $1;
         #       print $evolvesFrom."\n";
        }

}else {$evolvesFrom = "None";}

if($website_content =~ /<b>Evolves Into:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> (<(\w+)((?:\s+\w+(?:\s*=\s*(?:(?:"[^"]*")|(?:'[^']*')|[^>\s]+))?)*)\s*(\/?)>)/)
{
	#print "Evolves To: ";
	 $evolvesTo = $2;

	if($evolvesTo =~ /<a href="\/wiki\/([a-zA-Z0-9]*)/)
	{
		$evolvesTo = $1;
	#	print $evolvesTo."\n";
	}else{$evolvesTo = "None";}
}else{$evolvesTo ="None"};

if($website_content =~ /<b>Pronunciation:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em; font:math;"> <span class="texhtml">(.*)/)
{
	#print "Pronunciation: ";
	
	 $pro = $2;
	#print $pro."\n";
}

if($website_content =~ /<b>HP:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> ([0-9]*)/)
{
	#print "HP: ";
	 $hp = $2;
	#print $hp."\n";
}
if($website_content =~ /<b>Attack:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> ([0-9]*)/)
{
	#print "Attack: ";
	 $atk = $2;
	#print $atk."\n";
}
if($website_content =~ /<b>Defense:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> ([0-9]*)/)
{
	#print "Defense: ";
	 $def = $2;
	#print $def."\n";
}
if($website_content =~ /<b>Special Atk:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> ([0-9]*)/)
{
	#print "Special Atk: ";
	 $spAtk = $2;
	#print $spAtk."\n";
}
if($website_content =~ /<b>Special Def:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> ([0-9]*)/)
{
	#print "Special Def: ";
	 $spDef = $2;
	#print $spDef."\n";
}
if($website_content =~ /<b>Speed:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> ([0-9]*)/)
{
	#print "Speed: ";
	 $speed = $2;
	#print $speed."\n";
}
if($website_content =~ /<b>Stat Total:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> ([0-9]*)/)
{
	#print "Stat Total: ";
	 $stat = $2;
	#print $stat."\n";
}
my $temp;
if($website_content =~ /<b>Type\(s\):<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> <a href="\/wiki(.*)/)
{
	#print "Type(s): ";
	my $type = $2;
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
	#print $temp."\n";
}
if($website_content =~ /<b>Type\(s\):<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> <b><a href="\/wiki(.*)/)
{
        #print "Type(s): ";
        my $type = $2;
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
        #print $temp."\n";
}

if($website_content =~ /<b>Height:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> <span class="explain" title="&#123;&#123;&#123;ImHeight}}}">(.*)</)
{
	#print "Height: ";
	 $height  = $2;
	if($height =~ /(\d'(?:\s*\d+'')?[0-9]*.)/){
		$height =$1;
	}
	#print $height."\n";
}
if($website_content =~ /<b>Weight:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> <span class="explain" title="&#123;&#123;&#123;ImWeight}}}">(.*)</)
{
	#print "Weight: ";
	 $weight = $2;
	if($weight =~ /(.*)>(.*).</){
		$weight = $2;
	}
	#print $weight."\n";
}
if($website_content =~ />Abilities<\/a>:<\/b>(\n)(.*)/)
{
	#print "Abilities: ";
	my $tempAbil = $2;
	my $temp = "";
	 $abil = "";
	my $flag = 0;
	#print $tempAbil."\n";
	while($tempAbil =~ />(.[A-Za-z0-9^\s]*.)</g){
		if($flag == 0){
		   $abil = $1;
		   $flag =1;
		}
		else{
		   $abil = $abil."/".$1;
		}
		#print $1."\n";
		#$abil = $1;
		#$temp = $1;
	}
	#print $temp."\n";	
	#print $abil."\n";
}
if($website_content =~ /Species<\/a>:<\/b>(\n)<\/th><td style="vertical-align:top; padding-right:1em;"> (.*)/)
{
        #print "Species: ";
         $spe = $2;
        #print $spe."\n";
}
if($website_content =~ /<b>Black<\/b>(\n)<\/th><\/tr>(\n)(\n)<tr style="horizantal-align: top;">(\n)<td style="padding-rght: 1em;"><font size="2.5">(.*)</)
{
	#print "bio:";
	$bio = $5;
	#print $bio."\n";
}
if($website_content =~ /<b>Black<\/b>(\n)<\/th><\/tr>(\n)(\n)<tr style="horizantal-align: top;">(\n)<td style="padding-right: 1em;"><font size="2.5">(.[a-zA-Z0-9]*[\,\.\'\s.\D]*.)</)
{
	#print "Bio: ";
	 $bio = $5;
	#print $bio."\n";
}


#use DBI;
#my $dbh = DBI->connect("dbi:SQLite:dbname=nationaldex.sql","","");
#my $hold = "PLACEHOLDER";
#$dbh->do("INSERT INTO pokemon(name,evlovesFrom,evolvesInto,pronounce,hp,attack,defense,spAtk,spDef,speed,statTotal,species,type,height,weight,abilities,weakness,bio,layout,pic,icon) VALUES(".$name.",".$evolvesFrom.",".$evolvesTo.",".$dbh->quote($pro).",".$hp.",".$atk.",".$def.",".$spAtk.",".$spDef.",".$speed.",".$stat.",".$dbh->quote($spe).",".$temp.",".$dbh->quote($height).",".$dbh->quote($weight).",".$abil.",WEAK,".$dbh->quote($bio).",layout.png,".$name.".png,icon.png)");
#my $statment = $dbh->prepare("INSERT INTO pokemon(name,evolvesFrom,evolvesInto,pronunce,hp,attack,defense,spAtk,spDef,speed,statTotal,species,type,height,weight,abilities,weakness,bio,layout,pic,icon) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
#$statment->execute($name,$evolvesFrom,$evolvesTo,$dbh->quote($pro),$hp,$atk,$def,$spAtk,$spDef,$speed,$stat,$dbh->quote($spe),$temp,$dbh->quote($height),$dbh->quote($weight),$abil,$hold,$dbh->quote($bio),$hold,$name.".png","icon_".$name.".png");
#$dbh->disconnect();
}

close($file);


