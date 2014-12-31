use strict;
use warnings;
use lib 't/lib';

use Test::More;
require HTML::FormatTableRowNroff;

my $table_row = HTML::FormatTableRowNroff->new(align => 'center');

my $str1 = 'ghi';
my $str2 = 'jkl';

$table_row->add_element();
$table_row->add_text($str1);
$table_row->add_text($str2);

$table_row->end_element();

my $whole_str = $str1 . $str2;

is $table_row->text, $whole_str;

done_testing;
