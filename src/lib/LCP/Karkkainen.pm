#  Karkkainen.pm
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


package LCP::Karkkainen;

use vars qw($VERSION);

$VERSION = '1.00';

use strict;
use Carp;


=head1 NAME

LCP::Kasai - Longest common prefix computation 

=head1 SYNOPSIS

    use LCP::Karkkainen;

    my $lcp = LCP::Karkkainen->new();

    # -----         Compute lcp array          ----- #
    my ($lcparray,$plcparray) =$lcp->Karkkainen(suftab => \@suftab, string => \@array);

=head1 DESCRIPTION

The longest common prefix (LCP) array is an auxiliary data struc-
ture to the suffix array. The array containes lengths of the longest
common prefixes (LCPs) between all pairs of consecutive suffixes
in a sorted suffix array. The algorithm presented here is an 
implementation of Kasai’s linear time LCP construction solution [1].


=head2 new

    my $lcp = LCP::Karkkainen->new();

Creates a new longest common prefix object.

=head2 Karkkainen
    
    my ($lcparray,$plcparray) =$lcp->Karkkainen(suftab => \@suftab, string => \@array);
    

Function requires a sorted suffix array (suftab) and a string (string)
both as array references. As a result it returns the computed LCP array
and a PLCP array (an array of permuted PLCP values as they appear in a 
string)


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
sub Karkkainen {  # Karkkainen's algorithm
#################################################

my ($self,%arg) = @_;

my @fi = ();
my @plcp = ();
my @lcp = ();

#  --  Compute fi array  --  #
for (0..$#{$arg{string}}){
	$fi[$arg{suftab}->[$_]] = $arg{suftab}->[$_-1];
}

my $h = 0;
my $k=0;

#  --  Compute plcp array  --  #

for (0..$#{$arg{string}}){

   $k = $fi[$_];
   while($arg{string}->[$_ + $h] eq $arg{string}->[$k + $h]){
      $h++;
   }
   $plcp[$_] = $h;
   ($h>0) ? ($h--) : ($h = 0);
}

#  --  Compute lcp array  --  #

for (0..$#{$arg{string}}){
   $lcp[$_] = $plcp[$arg{suftab}->[$_]];
}

return (\@lcp,\@plcp);
}

1;
