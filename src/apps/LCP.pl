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
use LCP::Bakaric;
use File::Slurp;


my $lcp1K = LCP::Kasai->new();
my $lcp1B = LCP::Bakaric->new();
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
  print "\t-k\tKasai = k , Karkkainen = kkk, Bakaric = b\n";
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
my ($lcp, $plcp);
if ($kk eq 'k'){
   $lcp =$lcp1K->lcp(suftab => \@suftab,
                                        string => \@array);
}elsif($kk eq 'kkk'){
   $lcp =$lcp3K->lcp(suftab => \@suftab,
                                    string => \@array);
}elsif($kk eq 'b'){
   $lcp =$lcp1B->lcp(suftab => \@suftab,
                                       string => \@array);
}


# -----         Printing results           ----- #


my $b =0;

for(my $r=0;$r<@{$lcp};$r++){
   print $lcp->[$r] ? "$lcp->[$r]\t" : "0\t";
   print $suftab[$r]+1 . "\t";
   my @a = split("",$content);
   for(my $z = $suftab[$r];$z<@a;$z++){
      print "$a[$z]";
   }
   print "\n";
}



  








