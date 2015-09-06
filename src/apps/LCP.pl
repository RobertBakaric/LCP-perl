#!/usr/bin/perl 
#  LCP.pl
#  
#  Copyright 2015 Robert Bakaric <rbakaric@irb.hr>
#  
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#  MA 02110-1301, USA.
#  
#  


use strict;
use Getopt::Long;
use SA::SuffixArray;
use LCP::Kasai;
use LCP::Karkkainen;
use File::Slurp;


my $lcp1K = LCP::Kasai->new();
my $lcp3K = LCP::Karkkainen->new();
my $sa = SA::SuffixArray->new();


my ($help,$in,$quite,$terminator, $kk);
GetOptions ("i=s" => \$in,  # input 
            "h" => \$help,
            "q" => \$quite,
            "k=s" => \$kk,
            "t=s" => \$terminator
            );
                        
if($help || !$in){
  print "Usage:\n\n";
  print "\t-i\tinput - ASCII file\n";
  print "\t-q\tquite - quite mode\n";
  print "\t-k\tKasao = k , Karkkainine = kkk\n";
  print "\t-t\tterminating symbol\n";

  exit(0);
}

# -----              Set Defs              ----- #
$terminator = "\$" unless $terminator;
$kk = "k" unless $kk;

# -----              Read File             ----- #
my $content = read_file($in) ;

chomp($content);
$content .= $terminator;

my @array = split("",$content);

# -----        Compute suffix array        ----- #
my @suftab = $sa->Sort_Suffixes(array => \@array);


# -----         Compute lcp array          ----- #
my ($height,$sufinv, $plcp);
if ($kk eq 'k'){
   ($height,$sufinv) =$lcp1K->Kasai(suftab => \@suftab,
                                        string => \@array);
}elsif($kk eq 'kkk'){
   ($height,$plcp) =$lcp3K->Karkkainen(suftab => \@suftab,
                                    string => \@array);
}


# -----         Printing results           ----- #
if ($quite <=0){
   print "#Hight:0 @{$height}\n"; 
   print "\n#Rank:@{$sufinv}\n" if $sufinv;
   print "\nPLCP: @{$plcp}\n" if $plcp;
   print "\n#Position:@suftab\n\n" ;
}

my $b =0;

for(my $r=0;$r<@{$height};$r++){
   print $height->[$r] ? "$height->[$r]\t" : "0\t";
   print $suftab[$r]+1 . "\t";
   my @a = split("",$content);
   for(my $z = $suftab[$r];$z<@a;$z++){
      print "$a[$z]";
   }
   print "\n";
}



  








