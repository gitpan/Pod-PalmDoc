package Pod::PalmDoc;

use strict;
use vars qw($text $doc $doc_text @ISA $VERSION @EXPORT);

require Exporter;

use Pod::Parser;
use Palm::PalmDoc;
@ISA = qw(Exporter Pod::Parser);

@EXPORT = qw();

$VERSION = '0.0.1';

$doc = Palm::PalmDoc->new();

sub command {
    my ($parser, $command, $paragraph, $line_num) = @_;
    $paragraph .= "\n" unless substr($paragraph, -1) eq "\n";
    $paragraph .= "\n" unless substr($paragraph, -2) eq "\n\n";
    $text .= $paragraph;
}

sub verbatim {
    my ($parser, $paragraph, $line_num) = @_;
    $text .= $paragraph;
}

sub textblock {
    my ($parser, $paragraph, $line_num) = @_;
    $text .= $paragraph;
}

sub interior_sequence {
    my ($parser, $seq_command, $seq_argument) = @_;
    return "$seq_command<$seq_argument>";
}

sub outfile {
    my $self = shift;
    if (@_)
    { $doc->outfile(shift); }
}

sub title {
    my $self = shift;
    if (@_)
    { $doc->title(shift); }
}

sub compress {
    my $self = shift;
    if (@_)
    { $doc->compression(shift); }
}

sub end_input {
    $doc_text = $doc->body($text);
    $doc->write_text; #if $doc->outfile;
}

#sub get_text { return $text; }

1;
__END__

=head1 NAME

Pod::PalmDoc - Convert POD Data to PalmDoc

=head1 SYNOPSIS

  use Pod::PalmDoc;

  my $parser = Pod::PalmDoc->new();
  $parser->outfile("foo.pdb");
  $parser->compress(1);
  $parser->title("POD Foo");
  $parser->parse_from_file($ARGV[0]);

=head1 DESCRIPTION

This module converts POD (Plain Old Documentation) to PalmDoc format.
It uses Palm::PalmDoc and inherits most of its methods from Pod::Parser.

=head1 TODO

Loads! This is a VERY quick. Future releases probably will inherit from
Pod::Select instead of Pod::Parser. The filehandle passing should be added.
Examples will be added and POD should be completed.

=head1 DISCLAIMER

This code is released under GPL (GNU Public License). More information can be 
found on http://www.gnu.org/copyleft/gpl.html

=head1 VERSION

This is Pod::PalmDoc 0.0.1.

=head1 AUTHOR

Hendrik Van Belleghem (beatnik@quickndirty.org)

=head1 SEE ALSO

GNU & GPL - http://www.gnu.org/copyleft/gpl.html

=cut