package Tacata::Config;;
use strict;
use warnings;
use feature "state";
use FindBin;

my $home;
BEGIN {
    $home = "$FindBin::Bin/../";
};

sub new {
    my $class = shift;
    state $instance;
    if (!defined($instance)) {
        $instance = bless {}, $class;
        $instance->initialize;
    }
    return $instance;
}

sub initialize {
  my $self = shift;

  my $config = $self->load;
  $self->{__data} = $config;
}

sub load {
  my ($self, $filename) = @_;

  my $path = $home . 'config/config_' . $self->current_user . '.pl';
  $path = $home . 'config/config.pl' unless -f $path;
  unless ( -f $path ) {
    warn "not found: $path";
    return;
  }
  my $config = do($path);
  if ($@) {
    warn $@;
  }
  return $config;
}

sub get {
    my $self = shift;
    if (@_ == 1) {
        return $self->{__data}->{$_[0]};
    }
    return $self->as_hashref;
}

sub as_hashref { shift->{__data} }

sub current_user {
    my @parts = split(/\//, $ENV{HOME});
    return pop @parts;
}

1;

