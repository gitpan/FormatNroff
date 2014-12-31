# NAME

HTML::FormatNroff - Format HTML as nroff man page

# SYNOPSIS

```perl
use HTML::FormatNroff;
my $html = parse_htmlfile("test.html");
my $formatter = HTML::FormatNroff->new(name => 'trial', project => 'MyProject');
print $formatter->format($html);
```

# DESCRIPTION

The HTML::FormatNroff is a formatter that outputs nroff source
for the nroff text processor, using man macros, and tbl commands for table
processing.

The result of using the formatter must be processed as follows, when directing
output to the screen (assume output is in the file "text.nroff"):

```
tbl -TX text.nroff | nroff -man | col
```

If the output is to be printed, on an laser printer for example, a command
similar to the following must be used:

```
tbl -TX text.nroff | nroff -man -Tlj | lpr
```

Meta tags may be placed in the HTML so that portions of the HTML
will be ignored and not processed. Content between the tags

```
<META NAME="nroff-control" CONTENT="ignore_start">
<META NAME="nroff-control" CONTENT="ignore_end">
```

will be ignored. In the BODY META is not supported, but DIV may be used
as follows:

```
<DIV TYPE="NROFF_IGNORE">
</DIV>
```

In both the META and DIV uses, case is ignored.

# METHODS

## $format\_nroff->dt\_start();

Start a definition term `<DT>`,
using a temporary indent and vertical space.

## $format\_nroff->dd\_start();

Start a data definition, `<DD>`, using a temporary indent.

## $format\_nroff->configure($arg);

Configure the nroff formatter, setting the attributes passed in the
$arg attribute (hash reference)

## $format\_nroff->begin();

Begin HTML formatting.

## $format\_nroff->end();

End HTML formatting.

## $format\_nroff->html\_start();

Process `<HTML>` start tag. Create the man page header based
on saved attributes, unless the attribute
$format\_nroff->{'man\_header'} is not set. This generates the following header:

```
.TH "name" section "date" "project"
```

## $format\_nroff->font\_start($font);

Start the font specified by the $font character (e.g. B, or I).
The font is remembered so nested fonts are handled correctly.

## $format\_nroff->font\_end();

End the current font, returning to the previous one.

## $format\_nroff->i\_start();

Process `<I>` tag.

## $format\_nroff->i\_end();

Process `</I>` tag.

## $format\_nroff->b\_start();

Process `<B>` tag.

## $format\_nroff->b\_end();

Process `</B>` tag.

## $format\_nroff->table\_start($node);

Process `<TABLE>`, start table processing. $node
is the current html\_parser node.

```
Pass on the $format_nroff->{'page_width'} to FormatTableNroff
```

## $format\_nroff->tr\_start($node);

Process `<TR>`, add table row.

## $format\_nroff->tr\_end();

End the table row `</TR>`

## $format\_nroff->a\_start();

`<A>` is ignored.

## $format\_nroff->a\_end();

`</A>` is ignored.

## $format\_nroff->td\_start($node);

Process `<TD>`, add table cell

## $format\_nroff->td\_end();

Process `</TD>`, end table cell

## $format\_nroff->th\_start($node);

Process `<TH>`, add table header cell

## $format\_nroff->th\_end();

Process `</TH>`, end table header cell

## $format\_nroff->table\_end();

Process `</TABLE>`. Actually output entire table.

## $format\_nroff->p\_start();

Process `<P>`.

## $format\_nroff->p\_end();

Process `</P>` by doing nothing.

## $format\_nroff->goto\_lm()

goto\_lm does nothing.

## $format\_nroff->br\_start();

Process `<BR>`.

## $format\_nroff->hr\_start();

Process `<HR>`

## $format\_nroff->header\_start();

Process `<H?>` simply using .SH

## $format\_nroff->header\_end();

Process `</H?>` simply outputing newline

## $format\_nroff->out($text);

Output text.

## $format\_nroff->pre\_out($pre);

Output `<PRE>` text.

## $format\_nroff->nl($cnt);

Output newline.

## $format\_nroff->adjust\_lm($indent);

adjust indent (left margin)

## $format\_nroff->adjust\_rm();

not used.

## $format\_nroff->bullet($tag);

output the bullet, using a temporary indent and the $tag

## $format\_nroff->textflow($node);

Output text or add it to table if currently inside a table
If centered add .ce unless inside a table, if underlined add .ul,
if the left margin is adjusted use a .ti for every new line.

## $format\_nroff->blockquote\_start($node);

Start `<BLOCKQUOTE>`, by making a new paragraph, and indenting.

## $format\_nroff->blockquote\_end($node);

`</BLOCKQUOTE>`, by ending indent, and making a new paragraph

## $format\_nroff->div\_start($node);

Process DIV

```perl
<DIV TYPE="NROFF_IGNORE">
    is used to ignore all subsequent content until the next
</DIV>
```

This allows HTML to be used which is not to be converted to HTML
(such as navigation controls). Case is ignored in the type.

In the header you probably should use

```perl
<META NAME="nroff-control" CONTENT="ignore_start">
    is used to ignore all subsequent content until the next
<META NAME="nroff-control" CONTENT="ignore_end">
```

## $format\_nroff->meta\_start($node);

Process `<META>` tag.

```perl
<META NAME="nroff-control" CONTENT="ignore_start">
    is used to ignore all subsequent content until the next
<META NAME="nroff-control" CONTENT="ignore_end">
```

This allows HTML to be used which is not to be converted to HTML
(such as navigation controls). Case is ignored.

Strictly speaking META is only allowed in the HTML HEAD, so this
META. In the body, you should use:

```
<DIV TYPE="NROFF_IGNORE">
</DIV>
```

# SEE ALSO

[HTML::Formatter](https://metacpan.org/pod/HTML::Formatter),
[HTML::FormatTableCell](https://metacpan.org/pod/HTML::FormatTableCell),
[HTML::FormatTableCellNroff](https://metacpan.org/pod/HTML::FormatTableCellNroff),
[HTML::FormatTableNroff](https://metacpan.org/pod/HTML::FormatTableNroff),
[HTML::FormatTableRow](https://metacpan.org/pod/HTML::FormatTableRow),
[HTML::FormatTableRowNroff](https://metacpan.org/pod/HTML::FormatTableRowNroff)

# COPYRIGHT

Copyright (c) 1997 Frederick Hirsch. All rights reserved.

This library is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

# AUTHORS

Frederick Hirsch <f.hirsch@opengroup.org>

Stefan G. <minimal@cpan.org>
