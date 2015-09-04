use ExtUtils::MakeMaker;
system("mkdir lib");
system ("cp -r src/lib/LCP ./lib/"); 

WriteMakefile(
	NAME		=> 'LCP',
	VERSION_FROM	=> 'src/lib/LCP/Kasai.pm',
#	TO_INST_PM => 'src/lib',
	dist		=> { 'COMPRESS' => 'gzip' },
	PREREQ_PM => {
        # Require Getopt::Long at least 2.42
        "Getopt::Long" => 0,
        # Require any version of File::Slurp
        "File::Slurp" => 0,
    }
);


