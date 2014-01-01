#!/usr/local/bin/perl
use FindBin;
use lib "$FindBin::Bin/../lib";
use strict;
use warnings;
use utf8;

#地球どこでも Tacata 
#ユニバーサル言語 Tacata

use Tacata::CLI;

my $cli = Tacata::CLI->new;
$cli->run(@ARGV);

1;

=head1 NAME

Tacata - Download localization string data from Google Spreadsheets and output it in easily manipulatable json files.

=head1 SYNOPSIS

perl ./tacata.pl [options] command

=head2 commands

=item import_strings

import strings from google worksheets and output as json

=head2 options

=item --help

Display this help message

=cut

