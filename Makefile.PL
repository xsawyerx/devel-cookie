use 5.008009;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME           => 'Devel::Cookie',
    VERSION_FROM   => 'lib/Devel/Cookie.pm',
    ABSTRACT_FROM  => 'lib/Devel/Cookie.pm',
    LICENSE        => 'mit',
    MIN_PERL_VERSION => 5.008009,
    PREREQ_PM      => {
        'XSLoader'    => 0,
    },
    TEST_REQUIRES  => {
        'Test::More'            => 0,
        'Data::Dumper'          => 0,
    },
    AUTHOR         => [
        'Gonzalo Diethelm (gonzus@cpan.org)',
    ],
    LIBS           => [''],
#    DEFINE         => '-DGMEM_CHECK',
    INC            => '-I.',
    OBJECT         => '$(O_FILES)',
    META_MERGE     => {
        'meta-spec' => { version => 2 },
        resources   => {
            repository => {
                type => 'git',
                url  => 'git@github.com:gonzus/devel-cookie',
                web  => 'https://github.com/gonzus/devel-cookie',
            },
        },
    },
);

# Add options CCFLAGS without overwriting the defaults
package MY;
sub cflags {
    my $self   = shift;
    my $cflags = $self->SUPER::cflags(@_);
    my @cflags = split /\n/, $cflags;

    $self->{CCFLAGS} .= ' -Wall';                # Flag all warnings
    $self->{CCFLAGS} .= ' -std=c89';             # Compile according to C89 standard
    $self->{CCFLAGS} .= ' -D_XOPEN_SOURCE=700';  # Needed for localtime_r()

    foreach (@cflags) {
        $_ = "CCFLAGS = $self->{CCFLAGS}" if /^CCFLAGS/;
    }
    return $self->{CFLAGS} = join("\n", @cflags) . "\n";
}
