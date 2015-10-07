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

$VERSION = '0.01';

use strict;
use Carp;

=pod

=head1 NAME

LCP::Karkkainen - Longest common prefix computation strategy 

=head1 SYNOPSIS

    use LCP::Karkkainen;

    my $Karkkainen = LCP::Karkkainen->new();

    my $lcparray =$Karkkainen->lcp(suftab => \@suftab, string => \@array);
    
    my $plcparray =$Karkkainen->plcp(suftab => \@suftab, string => \@array);

=head1 DESCRIPTION

The longest common prefix (LCP) array is an auxiliary data structure 
to the suffix array. The array containes lengths of the longest
common prefixes (LCPs) between all pairs of consecutive suffixes
in a sorted suffix array. The algorithm presented here is an 
implementation of Karkkainen's linear time PLCP and LCP construction 
strategies [1].


=head2 new

    my $Karkkainen = LCP::Karkkainen->new();

Creates a new longest common prefix object.

=head2 lcp
    
    my $lcparray =$Karkkainen->lcp(suftab => \@suftab, string => \@array);
 
Function requires a sorted suffix array (suftab) and a string (string)
both as array references. As a result it returns computed LCP array.

=head2 plcp

    my $plcparray =$Karkkainen->plcp(suftab => \@suftab, string => \@array);

Function requires a sorted suffix array (suftab) and a string (string)
both as array references. As a result it returns computed PLCP array
(an array of permuted LCP values as they appear in the string)


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

1.  Karkkainen et al. Permuted Longest-Common-Prefix Array. 2009.

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
sub lcp {  # plcp to lcp conversion algorithm
#################################################

my ($self,%arg) = @_;

my @lcp = ();

my $plcp = $self->plcp(string => $arg{string}, 
                         suftab => $arg{suftab});


for (0..$#{$arg{string}}){
   $lcp[$_] = $plcp->[$arg{suftab}->[$_]];
}

return \@lcp;
}



#################################################
sub plcp {  # Karkkainen's plcp algorithm
#################################################

my ($self,%arg) = @_;

my @fi = ();
my @plcp = ();

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

return \@plcp;
}

1;
