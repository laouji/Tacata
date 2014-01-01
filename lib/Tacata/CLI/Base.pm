package Tacata::CLI::Base;
use strict;
use warnings;
use Tacata::Config;
use JSON::XS;
use Net::Google::Spreadsheets;;

sub new {
  my $class = shift;
  bless @_ ? @_ > 1 ? {@_} : {%{$_[0]}} : {}, ref $class || $class;
}

sub config { return Tacata::Config->new }

sub google_spreadsheet {
  my $self = shift;

  warn "authenticating with google spreadsheets";
  my $service = Net::Google::Spreadsheets->new(
        username => $self->config->get('google_username'),
        password => $self->config->get('google_password'),
  );
  
  warn "\ngetting spreadsheet data";
  my $spreadsheet = $service->spreadsheet({ key => $self->config->get('spreadsheet_key') });
  unless ($spreadsheet) {
      die "failed to get spreadsheet: check permissions";
  }

  return $spreadsheet;
}

sub output_path {  
    return sprintf( 
        "%s/%s/", 
        $ENV{HOME}, 
        shift->config->get("output_dir"), 
    );
}

sub parse {
    my ($self, $rows) = @_;

    my $data;
    for my $row (@$rows) {
        my $content = $row->{content};
        
        my $section = delete $content->{section};
        my $field = delete $content->{field};

        foreach my $key (keys %$content) {
            my $lang = substr($key, 0, 2) . "_" . uc(substr($key, 2, 3));
            $data->{$section}->{$field}->{$lang} = $content->{$key};
        }
    }
    return $data;
}


sub write_strings {
  my ($self, $filename, $data) = @_;

  my $json = JSON::XS->new->pretty(1)->utf8(0)->canonical(1);
  my $output = $json->encode($data);

  my $path = sprintf("%s/%s.json", $self->output_path, $filename);
  open(my $fh, ">:utf8", $path) || die "Couldn't open $path: $!\n";
  print $fh $output;
  close $fh;

  return 1;
}

1;
