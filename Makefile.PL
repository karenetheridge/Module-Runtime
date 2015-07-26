use strict;
use warnings;
use 5.006;
use ExtUtils::MakeMaker;

ExtUtils::MakeMaker->VERSION(6.98) if -f '.gitignore';

my %WriteMakefileArgs = (
    NAME                => 'Module::Runtime',
    VERSION_FROM        => 'lib/Module/Runtime.pm',
    ABSTRACT_FROM       => 'lib/Module/Runtime.pm',
    AUTHOR              => 'Andrew Main (Zefram) <zefram@fysh.org>',
    LICENSE             => 'perl_5',
    MIN_PERL_VERSION    => '5.006',

    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => '0',
    },
    PREREQ_PM => {
    },
    TEST_REQUIRES => {
        'Test::More' => '0',
    },

    META_MERGE => {
        'meta-spec' => { version => 2 },
        dynamic_config => 0,
        resources => {
            repository => {
                url => 'git://git.fysh.org/zefram/Module-Runtime.git',
                type => 'git',
            },
            bugtracker => {
                mailto => 'bug-Module-Runtime@rt.cpan.org',
                web => 'https://rt.cpan.org/Public/Dist/Display.html?Name=Module-Runtime',
            },
        },
    },
);

# degrade gracefully for older EUMM/older perls

if (!eval { ExtUtils::MakeMaker->VERSION('6.6303') }) {
    $WriteMakefileArgs{BUILD_REQUIRES} = $WriteMakefileArgs{TEST_REQUIRES};
    delete $WriteMakefileArgs{TEST_REQUIRES};
}

if (!eval { ExtUtils::MakeMaker->VERSION('6.5501') }) {
    @{$WriteMakefileArgs{PREREQ_PM}}{ keys %{$WriteMakefileArgs{BUILD_REQUIRES}} } =
        @{$WriteMakefileArgs{BUILD_REQUIRES}}{ keys %{$WriteMakefileArgs{BUILD_REQUIRES}} };

    delete $WriteMakefileArgs{BUILD_REQUIRES};
}

WriteMakefile(%WriteMakefileArgs);
