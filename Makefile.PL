use ExtUtils::MakeMaker;

system("cp -r src/lib .");

WriteMakefile(
	NAME		=> 'LCP',
	VERSION	=> '1.00',
#	PMLIBDIRS =>  [ 'src/lib', '$(BASEEXT)' ] ,
#	TO_INST_PM => 'src/lib',
	dist		=> { 'COMPRESS' => 'gzip' },
	PREREQ_PM => {
        # Require Getopt::Long at least 0
        "Getopt::Long" => 0,
        # Require any version of File::Slurp
        "File::Slurp" => 0,
    }
);


