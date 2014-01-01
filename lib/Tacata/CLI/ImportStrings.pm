package Tacata::CLI::ImportStrings;
use base 'Tacata::CLI::Base';

sub run {
  my $self = shift;

  my $spreadsheet = $self->google_spreadsheet;
  my @worksheets = $spreadsheet->worksheets;

  foreach my $worksheet (@worksheets) {
    my $strings = $self->parse([ $worksheet->rows ]);

    $self->write_strings($worksheet->title, $strings);
  }
}

1;
