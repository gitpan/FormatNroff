package HTML::FormatTableCellNroff;

=head1 NAME

HTML::FormatTableCellNroff - Format HTML Table entry

=head1 SYNOPSIS

 require HTML::FormatTableCellNroff;
 $cell = new HTML::FormatTableCellNroff(%attr);

=head1 DESCRIPTION

The HTML::FormatTableCellNroff is used to record information
about a table entry and produce format information about the entry.
It is used by FormatTableNroff to process HTML tables.

=head1 METHODS

=cut

require 5.004;

require HTML::FormatTableCell;
@ISA=qw(HTML::FormatTableCell);

use strict;
use Carp;
	
my %_formats = (
    left => "l",
    center => "c",
    right => "r",
);

=head2 $nroff_cell->format_str($width);

Produce a tbl format specification for the current cell, consisting of
an alignment character, width (in inches), and any subsequent colspan 
specifications. An example is "cw(2i)".

=cut

sub format_str {
    my($self, $width) = @_;

    my $result = $_formats{ $self->{'align'} };
    if($width) { $result .= "w(" . $width . "i)"; }
    my $cnt = $self->{'colspan'};
    while($cnt > 1) {
	$result .= " s";	
	$cnt--;
    }
    return $result;
}

=head2 $nroff_cell->output($formatter);

 Output a table cell entry using the formatter defined by $formatter.
 The nroff 
 T{
 .ad 1
 .fi
     contents
 .nf
 }T 
 construct is used to format text inside a cell. Bold is used for a table
 header.

=cut

sub output {
    my($self, $formatter) = @_;

    $formatter->out("T{\n.ad l\n.fi\n");
    if($self->{'header'} eq 'header') {
	$formatter->font_start('B');
    }
    my $text = $self->{'text'};
    $text =~ s/ +/ /;
    $formatter->out($text);
    if($self->{'header'} eq 'header') {
	$formatter->font_end();
    }
    $formatter->out("\n.nf\nT}");
}

=head1 SEE ALSO

L<HTML::FormatNroff>,
L<HTML::FormatTableCell>,
L<HTML::FormatTableRow>,
L<HTML::FormatTableRowNroff>

=head1 COPYRIGHT

Copyright (c) 1997 Frederick Hirsch. All rights reserved.

This library is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 AUTHOR

Frederick Hirsch <f.hirsch@opengroup.org>

=cut 

1;

