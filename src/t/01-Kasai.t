use Test::More;
use lib '../lib';
use LCP::Kasai;

plan tests => 1;

my $output =   "0 0 0 0 0 0 1 1 1 0 1 0 2 1 2 4 0 0 0 1 1 0 1 2 1 0 0 0 0 1 2 1 0 1 1 0 2 1 1 1 1 3 0 5 1 2 2 1 1 1 2";
my @strarr = qw(t h i s i s a t e s t t o t e s t t h e c o r r e c t n e s s o f L C P K a s a i a l g o r i t h m $);
my @suftab = qw(50 34 36 33 35 39 41 37 6 20 25 19 24 28 14 8 32 43 18 1 48 40 4 2 46 42 49 27 31 44 21 12 23 45 22 38 5 3 30 29 15 9 13 7 17 0 47 26 11 16 10);

my $Kasai = LCP::Kasai->new();


my $lcp = $Kasai->lcp(suftab => \@suftab,
                      string => \@strarr);

my $lcpstr = join(" ",@{$lcp});

ok( $lcpstr eq $output, "Kasai");

done_testing;
