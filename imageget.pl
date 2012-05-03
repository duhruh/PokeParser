#!/usr/bin/perl
my $file;
open FILE, "<listOfPokemon.txt" or die("Could not open file!");
use strict;
use warnings;
my $curpokemon;
use LWP::Simple;
use DBI;

print "Name: ";
foreach $curpokemon (<FILE>){
chomp $curpokemon;
print $curpokemon;


open IMAGE, "images/".$curpokemon.".png" or die $!;

my ($image, $buff);

binmode IMAGE;
my ($buf, $data, $n);
while (($n = read IMAGE, $data, 4) != 0) {
  #print "$n bytes read\n";
  $buf .= $data;
}

my $dbh = DBI->connect("dbi:SQLite:dbname=nationaldex.sql",{ RaiseError => 1 }) or die $DBI::errstr;

my $stm = $dbh->prepare("INSERT INTO images(filename, data) VALUES (?,?)");
my $filename = $curpokemon.".png";
$stm->bind_param(1, $filename);
$stm->bind_param(2, $buf, DBI::SQL_BLOB);

$stm->execute();

close(IMAGE);
$stm->finish();
$dbh->disconnect();
}
