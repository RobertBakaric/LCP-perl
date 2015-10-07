#  Manzini.pm
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

package LCP::Manzini;

use vars qw($VERSION);

$VERSION = '0.01';

use strict;
use Carp;

=pod
=head1 NAME

LCP::Manzini - Longest common prefix computation strategy

=head1 SYNOPSIS

    use LCP::Manzini;

    my $Manzini = LCP::Manzini->new();
    
    my $LCPArrayRef =$Manzini->lcp(suftab => \@suftab, string => \@strarr);

=head1 DESCRIPTION

The longest common prefix (LCP) array is an auxiliary data structure 
to a suffix array. The array containes lengths of the longest
common prefixes (LCPs) between all pairs of consecutive suffixes
in a lexicographically ordered array of string suffixes. The algorithm 
presented here is an implementation of Manzini's linear time space 
efficient LCP construction solution [1].


=head2 new

    my $Manzini = LCP::Manzini->new();

Creates a new longest common prefix object.

=head2 lcp
    
    my $LCPArrayRef =$Manzini->lcp(suftab => \@suftab, string => \@strarr);
    

Function requires lexicographically ordered suffix array (suftab) and a 
string array (string), both as array references. As a result it returns 
a computed LCP array reference.



=head1 AUTHOR

Robert Bakaric <rbakaric@irb.hr>

=head1 COPYRIGHT AND LICENSE

Copyright 2015 Robert Bakaric <rbakaric@irb.hr>
  
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.
  
This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
  
You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
MA 02110-1301, USA.

=head1 ACKNOWLEDGEMENT

1.  Manzini, G. and Ferragina, P. Engineering a Lightweight Suffix 
    Array Construction Algorithm.  2002.

=cut



#################################################
#               CONSTRUCTOR
#################################################
#################################################
sub new {
#################################################

my ($class)=@_;

my $hash = {};

bless ($hash,$class);

}


#################################################
#               FUNCTIONS
#################################################
#################################################
sub lcp {  # Manzini's algorithm
#################################################

my ($self,%arg) = @_;

my @lcp = (0);
my @occ = ();

my ($i,$h,$j,$k,$nextk)=(0,0,0,0,-1);

for($i = 0; $i< $#{$arg{string}}; $i++){
   $occ[ord($arg{string}->[$i])]++;
}

  $k = $self->_rank_next(string => $arg{string}, 
                 suftab =>  $arg{suftab}, 
                 occ=> \@occ, 
                 rank_next => \@lcp); 

  $h = 0;
  for($i=0; $i<$#{$arg{string}}; $i++,$k=$nextk) { 
    $nextk=$lcp[$k];
		if($k>0) {
         $j = $arg{suftab}->[$k-1];
         while($i+$h<$#{$arg{string}} && $j+$h<$#{$arg{string}} && $arg{string}->[$i+$h] eq $arg{string}->[$j+$h]){
				$h++;
         }
         $lcp[$k]=$h;
      }
      if($h>0){ $h--};
  }
return \@lcp;
}

#################################################
sub _rank_next {  
#################################################
my ($self,%arg) = @_;

my ($i,$j,$c,$r0)=(0,0,0,0);
my @count;

for($i=1;$i<256;$i++){
   $count[$i] = $count[$i-1] + $arg{occ}->[$i-1];
}

$j = ++$count[$arg{string}->[$#{$arg{string}}-1]]; 
$arg{rank_next}->[$j]=0;
for($i=1;$i<=$#{$arg{string}};$i++){
   if($arg{suftab}->[$i] == 0){
      $r0 = $i;
   }else{
      $c = $arg{string}->[$arg{suftab}->[$i] - 1];
      $count[ord($c)]++;
      $j = $count[ord($c)];
      $arg{rank_next}->[$j]=$i;
   }
}

return $r0;
}

1;
