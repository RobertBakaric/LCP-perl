#  SuffixArray.pm
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


package SA::SuffixArray;

use vars qw($VERSION);

$VERSION = '1.00';

use strict;
use Carp;


=head1 NAME

SA::SuffixArray - Suffix array computation 

=head1 SYNOPSIS

    use SA::SuffixArray;

    my $lcp = SA::SuffixArray->new();

    # -----         Compute sa array          ----- #
    my @suftab = $lcp->_sort_suffixes(array => \@array);

=head1 DESCRIPTION

The longest common prefix (LCP) array is an auxiliary data struc-
ture to the suffix array. The array containes lengths of the longest
common prefixes (LCPs) between all pairs of consecutive suffixes
in a sorted suffix array. The algorithm presented here is an 
implementation of Kasai’s linear time LCP construction solution [1].


=head2 new

    my $sa = SA::SuffixArray->new();

Creates a new suffix object.

=head2 _sort_suffixes

    my @suftab = $sa->Sort_Suffixes(array => \@array);

Where \@array is an array reference of string characters.

Function returns the lexicographically sorted array of indexes 
corresponding to starting positions of string suffixes. Function 
is a simple quicksort based sorting lagorithm with O(n log n) 
worst case runtime behaviour.


=head1 AUTHOR

Robert Bakaric <rbakaric@irb.hr>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=head1 ACKNOWLEDGEMENT


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
sub Sort_Suffixes {  # Sorting
#################################################
my ($self,%arg) = @_;

return
   map  { $_->[ 0 ] }
   sort { $a->[ 1 ] cmp $b->[ 1 ] }
   map  { [ $_, join q{}, @{$arg{array}}[ $_ .. $#{$arg{array}} ] ] }
   0 .. $#{$arg{array}};

}

1;
