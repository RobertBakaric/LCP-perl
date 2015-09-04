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

$VERSION = '1.00';

use strict;
use Carp;


=head1 NAME

LCP::Kasai - Longest common prefix computation 

=head1 SYNOPSIS

    use LCP::Kasai;

    my $lcp = LCP::Kasai->new();

    
    # -----        Compute suffix array        ----- #
    my @suftab = $lcp->_sort_suffixes(array => \@array);

    # -----         Compute lcp array          ----- #
    my ($height,$sufinv) =$lcp->_kasai(suftab => \@suftab, string => \@array);

=head1 DESCRIPTION

The longest common prefix (LCP) array is an auxiliary data struc-
ture to the suffix array. The array containes lengths of the longest
common prefixes (LCPs) between all pairs of consecutive suffixes
in a sorted suffix array. The algorithm presented here is an 
implementation of Kasai’s linear time LCP construction solution [1].


=head2 new

    my $lcp = LCP::Kasai->new();

Creates a new longest common prefix object.

=head2 _sort_suffixes

    my @suftab = $lcp->_sort_suffixes(array => \@array);

Where \@array is an array reference of string characters.

Function returns the lexicographically sorted array of indexes 
corresponding to starting positions of string suffixes. Function 
is a simple quicksort based sorting lagorithm with O(n log n) 
worst case runtime behaviour.

=head2 _kasai
    
    my ($height,$sufinv) =$lcp->_kasai(suftab => \@suftab, string => \@array);
    

Function requires a sorted suffix array (suftab) and a string (string)
both as array references. As a result it returns the computed LCP array
(height - term used by Kasai et al.) and a rank array (an array invers 
to the suffix array)


=head1 AUTHOR

Robert Bakaric <rbakaric@irb.hr>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=head1 ACKNOWLEDGEMENT

Kasai et al. Linear-Time Longest-Common-Prefix Computation in 
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
sub _kasai {  # Kasai's algorithm
#################################################

my ($self,%arg) = @_;

my @sufinv = ();
for (0..$#{$arg{string}}){
	$sufinv[$arg{suftab}->[$_]] = $_;
}
my $h = 0;

my @height = ();
for (0..$#{$arg{string}}){ 
	if($sufinv[$_] >= 1){
		my $k = $arg{suftab}->[$sufinv[$_] - 1];
		while($arg{string}->[$_ + $h] eq $arg{string}->[$k + $h]){
			$h++;
		}
		$height[$sufinv[$_]] = $h;
		if($h>0){
			$h--;
		}
		else{
			$h = 0;
		}
	}
}
return (\@height,\@sufinv);
}

#################################################
sub _sort_suffixes {  # Sorting
#################################################
my ($self,%arg) = @_;

return
   map  { $_->[ 0 ] }
   sort { $a->[ 1 ] cmp $b->[ 1 ] }
   map  { [ $_, join q{}, @{$arg{array}}[ $_ .. $#{$arg{array}} ] ] }
   0 .. $#{$arg{array}};

}

1;
