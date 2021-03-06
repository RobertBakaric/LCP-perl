#  Kasai.pm
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

package LCP::Kasai;

use vars qw($VERSION);

$VERSION = '0.01';

use strict;
use Carp;


=pod

=head1 NAME

LCP::Kasai - Longest common prefix computation strategy

=head1 SYNOPSIS

    use LCP::Kasai;

    my $Kasai = LCP::Kasai->new();

    my $LCPArrayRef =$Kasai->lcp(suftab => \@suftab, string => \@strarr);

=head1 DESCRIPTION

The longest common prefix (LCP) array is an auxiliary data structure 
to a suffix array. The array containes lengths of the longest
common prefixes (LCPs) between all pairs of consecutive suffixes
in a lexicographically ordered array of string suffixes. The algorithm 
presented here is an implementation of Kasai's linear time LCP 
construction solution [1].


=head2 new

    my $Kasai = LCP::Kasai->new();

Creates a new longest common prefix object.

=head2 lcp
    
    my $LCPArrayRef =$Kasai->lcp(suftab => \@suftab, string => \@strarr);
    

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

1.     Kasai et al. Linear-Time Longest-Common-Prefix Computation in 
       Suffix Arrays and Its Applications. 2001.

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
sub lcp {  # Kasai's algorithm
#################################################

my ($self,%arg) = @_;

my @sufinv = ();
for (0..$#{$arg{string}}){
	$sufinv[$arg{suftab}->[$_]] = $_;
}
my $h = 0;

my @lcp  = (0);

for (0..$#{$arg{string}}){ 
	if($sufinv[$_] >= 1){
		my $k = $arg{suftab}->[$sufinv[$_] - 1];
		while($arg{string}->[$_ + $h] eq $arg{string}->[$k + $h]){
			$h++;
		}
		$lcp [$sufinv[$_]] = $h;
		if($h>0){
			$h--;
		}
		else{
			$h = 0;
		}
	}
}
return \@lcp ;
}

1;
