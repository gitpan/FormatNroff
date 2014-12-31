use strict;
use warnings;
use lib 't/lib';

use Test::More;
use HTML::FormatTableCellNroff;

my $table_cell = HTML::FormatTableCellNroff->new( colspan => 2, align => 'center' );

is $table_cell->colspan,   2,        "colspan ok";
is $table_cell->alignment, 'center', 'alignment ok';

$table_cell->add_text('abc');
$table_cell->add_text('def');

is $table_cell->text, 'abcdef', 'text ok';

my $expected = 'c s';
my $format   = $table_cell->format_str();
is $format, $expected;

done_testing;
