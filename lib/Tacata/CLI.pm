package Tacata::CLI;
use strict;
use warnings;
use Getopt::Long;
use Pod::Usage;
use String::CamelCase qw(camelize);

my @ARGS;

sub new {
  my $class = shift;
  bless @_ ? @_ > 1 ? {@_} : {%{$_[0]}} : {}, ref $class || $class;
}

sub run {
  my $self = shift;

  $self->parse_options(@_);

  # load cli modules
  for my $command (@ARGV) {
    my $cli_class = "Tacata::CLI::" . camelize($command);
    unless ($cli_class->can('new') || eval "require $cli_class; 1" ) {
      warn "Failed to load $cli_class:\n $!";
      $self->help;
    }
  }
    
  for my $command (@ARGV) {
    my $cli_class = "Tacata::CLI::" . camelize($command);
    my $cli = $cli_class->new();
    $cli->run;
  }

}

sub parse_options {
  my $self = shift;
  local @ARGV = @_;

  GetOptions(
    help => \&help,
  );
 
  $self->help if scalar(@ARGV) < 1;
}

sub help { 
  exit pod2usage( -output => ">&STDOUT", -verbose => 1 );
}

1;

