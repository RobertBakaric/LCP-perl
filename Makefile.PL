use ExtUtils::MakeMaker;

mkdir "./lib";
mkdir "./lib/LCP";
mkdir "./lib/SA";
mkdir "./t/";
system("cp src/lib/LCP/* ./lib/LCP");
system("cp  src/lib/SA/* ./lib/SA");
system("cp  src/t/* ./t/");
system("cp  src/apps/* ./bin/");


WriteMakefile(
	NAME		=> 'LCP',
	AUTHOR   => q{Robert Bakaric <rbakaric@irb.hr>},
	LICENSE  => 'GNU GENERAL PUBLIC LICENSE Version 3',
	ABSTRACT => 'Longest Common Prexif Array Computational Strategies',
	VERSION	=> '0.01',

	dist		=> { 'COMPRESS' => 'gzip' },
	PREREQ_PM => {
        # Require Test::More 
        "Test::More"   => 0,
    },
    META_ADD => {
        provides => {
            'LCP::Karkkainen' => {
               file => 'Karkkainen.pm',
               version => '0.01',
            },
            'LCP::Kasai' => {
               file => 'Kasai.pm',
               version => '0.01',
            },
            'LCP::Manzini' => {
               file => 'Manzini.pm',
               version => '0.01',
            },
            'LCP::Bakaric' => {
               file => 'Bakaric.pm',
               version => '0.01',
            },
            'SA::SuffixArray' => {
               file => 'SuffixArray.pm',
               version => '0.01',
            },
        },
    },
);
