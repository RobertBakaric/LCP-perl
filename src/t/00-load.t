#!perl -T
use 5.014;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 4;

BEGIN {
    use_ok( 'LCP::Kasai' ) || print "Bail out!\n";
    use_ok( 'LCP::Karkkainen' ) || print "Bail out!\n";
    use_ok( 'LCP::Manzini' ) || print "Bail out!\n";
    use_ok( 'LCP::Bakaric' ) || print "Bail out!\n";
}

diag( "\nTesting LCP::Kasai v$LCP::Kasai::VERSION, Perl $], $^X" );

diag( "Testing LCP::Karkkainen v$LCP::Karkkainen::VERSION, Perl $], $^X" );

diag( "Testing LCP::Manzini v$LCP::Manzini::VERSION, Perl $], $^X" );

diag( "Testing LCP::Bakaric v$LCP::Bakaric::VERSION, Perl $], $^X" );
