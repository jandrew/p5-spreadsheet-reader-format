package Spreadsheet::Reader::Format;
use version  0.77; our $VERSION = version->declare('v0.6.5');
###LogSD	warn "You uncovered internal logging statements for Spreadsheet::Reader::Format-$VERSION";

use 5.010;
use Moose::Role;
requires qw(
		get_excel_region				has_target_encoding
		get_target_encoding			set_target_encoding
		change_output_encoding	set_defined_excel_formats
		get_defined_conversion	parse_excel_format_string
		set_cache_behavior			set_date_behavior
		set_european_first			set_workbook_inst
	);

#########1 Dispatch Tables & Package Variables    5#########6#########7#########8#########9



#########1 Public Attributes  3#########4#########5#########6#########7#########8#########9



#########1 Public Methods     3#########4#########5#########6#########7#########8#########9

###LogSD	sub get_class_space{ 'ExcelFormatInterface' }

#########1 Private Attributes 3#########4#########5#########6#########7#########8#########9



#########1 Private Methods    3#########4#########5#########6#########7#########8#########9



#########1 Phinish            3#########4#########5#########6#########7#########8#########9

no Moose::Role;

1;

#########1 Documentation      3#########4#########5#########6#########7#########8#########9
__END__

=head1 NAME

Spreadsheet::Reader::Format - Formatting for various spreadsheet readers

=begin html

<a href="https://www.perl.org">
	<img src="https://img.shields.io/badge/perl-5.10+-brightgreen.svg" alt="perl version">
</a>

<a href="https://travis-ci.org/jandrew/p5-spreadsheet-reader-format">
	<img alt="Build Status" src="https://travis-ci.org/jandrew/p5-spreadsheet-reader-format.png?branch=master" alt='Travis Build'/>
</a>

<a href='https://coveralls.io/github/jandrew/p5-spreadsheet-reader-format?branch=master'>
	<img src='https://coveralls.io/repos/github/jandrew/p5-spreadsheet-reader-format/badge.svg?branch=master' alt='Coverage Status' />
</a>

<a href='https://github.com/jandrew/p5-spreadsheet-reader-format'>
	<img src="https://img.shields.io/github/tag/jandrew/p5-spreadsheet-reader-format.svg?label=github version" alt="github version"/>
</a>

<a href="https://metacpan.org/pod/Spreadsheet::Reader::Format">
	<img src="https://badge.fury.io/pl/Spreadsheet-Reader-Format.svg?label=cpan version" alt="CPAN version" height="20">
</a>

<a href='http://cpants.cpanauthors.org/dist/Spreadsheet-Reader-Format'>
	<img src='http://cpants.cpanauthors.org/dist/Spreadsheet-Reader-Format.png' alt='kwalitee' height="20"/>
</a>

=end html

=head1 SYNOPSYS

	#!/usr/bin/env perl
	use MooseX::ShortCut::BuildInstance 'build_instance';
	use Spreadsheet::Reader::Format;
	use Spreadsheet::Reader::Format::FmtDefault;
	use Spreadsheet::Reader::Format::ParseExcelFormatStrings;
	use Spreadsheet::Reader::ExcelXML;
	my $formatter = build_instance(
		package => 'FormatInstance',
		# The base United State localization settings - Inject your customized format class here
		superclasses => [ 'Spreadsheet::Reader::Format::FmtDefault' ],
		# ParseExcelFormatStrings => The Excel string parser generation engine
		# Format => The top level interface defining minimum compatability requirements
		add_roles_in_sequence =>[qw(
			Spreadsheet::Reader::Format::ParseExcelFormatStrings
			Spreadsheet::Reader::Format
		)],
		target_encoding => 'latin1',# Adjust the string output encoding here
		datetime_dates	=> 1,
	);

	# Use in a standalone manner
	my	$date_string = 'yyyy-mm-dd';
	my	$time		= 55.0000102311;
	# Build a coercion with excel format string: $date_string
	my	$coercion	= $formatter->parse_excel_format_string( $date_string );
	# Checking that a DateTime object was returned
	print ref( $coercion->assert_coerce( $time ) ) . "\n";
	# Checking that the date and time are presented correctly: 1904-02-25T00:00:01
	print $coercion->assert_coerce( $time ) . "\n";

	# Set specific default custom formats here (for use in an excel parser)
	$formatter->set_defined_excel_formats( 0x2C => 'MyCoolFormatHere' );

	# Use the formatter like Spreadsheet::ParseExcel
	my $parser	= Spreadsheet::Reader::ExcelXML->new;
	my $workbook = $parser->parse( '../t/test_files/TestBook.xlsx', $formatter );


=head1 DESCRIPTION

In general a completly built formatter class as shown in the SYNOPSYS is already used
by the package L<Spreadsheet::Reader::ExcelXML> to turn unformatted data into formatted
data.  The purpose is to allow the Excel equivalent of localization of the output.  The
general localization options are mostly found at the workbook level.  Individual cells
also contain information about how that cell data should be formatted.

It is possible to insert alternate roles in the Formatter build or use methods
to customize the defaults used by the formatter for use in the Spreadsheet reader.  It
is also possible to use the formatter to output custom format code for post processing
output..

=head2 Module Description

This module is written to be an L<Interface
|http://www.codeproject.com/Articles/22769/Introduction-to-Object-Oriented-Programming-Concep#Interface>
for the Formatter class used in L<Spreadsheet::Reader::ExcelXML> so that the core
L<parsing engine|Spreadsheet::Reader::Format::ParseExcelFormatStrings> and the
L<regional formatting settings|Spreadsheet::Reader::Format::FmtDefault> for the
parser can easily be swapped.  This interface really only defines method requirements for
the undlerlying instance since the engine it uses was custom-built for
L<Spreadsheet::Reader::ExcelXML>.  However, adding a shim to this package so it can
be used by L<Spreadsheet::ParseExcel> (for example) should be easier because of the
abstraction.

This module does not provide unique methods.  It just requires methods and provides a
uniform interface for the workbook package.  Additional attributes and methods provided
by the sub modules may be available to the instance but are not in the strictest sence
required.

=head2 Methods

These are the methods required by this interface.  Links to the default implementation
of each method are provided but any customization of the formatter instance for Spreadsheet
parsing will as a minimum require these methods.

=head3 parse_excel_format_string( $string, $name )

=over

B<Definition:> This is the method to convert Excel format strings to code that will
translate raw data from the file to formatted output in the form defined by the string.
It is possible to pass a format name that will be incorperated so that the method
$coercion->display_name returns $name.

B<Default source:> L<Spreadsheet::Reader::Format::ParseExcelFormatStrings/parse_excel_format_string( $string, $name )>

=back

=head3 get_defined_conversion( $position )

=over

B<Definition:> This method returns the code for string conversion for a pre-defined
conversion by position.

B<Default source:> L<Spreadsheet::Reader::Format::ParseExcelFormatStrings/get_defined_conversion( $position )>

=back

=head3 set_target_encoding( $encoding )

=over

B<Definition:> This sets the output $encoding for strings.

B<Default source:> L<Spreadsheet::Reader::Format::FmtDefault/set_target_encoding( $encoding )>

=back

=head3 get_target_encoding

=over

B<Definition:> This returns the output encoding definition for strings.

B<Default source:> L<Spreadsheet::Reader::Format::FmtDefault/get_target_encoding>

=back

=head3 has_target_encoding

=over

B<Definition:> It is possible to not set a target encoding in which case any call to decode
data acts like a pass through.  This returns true if the target encoding is set.

B<Default source:> L<Spreadsheet::Reader::Format::FmtDefault/has_target_encoding>

=back

=head3 change_output_encoding( $string )

=over

B<Definition:> This is the method call that implements the output encoding change for $string.

B<Default source:> L<Spreadsheet::Reader::Format::FmtDefault/change_output_encoding( $string )>

=back

=head3 get_excel_region

=over

B<Definition:> It may be useful for this instance to self identify it's target output.
This method returns that value

B<Default source:> L<Spreadsheet::Reader::Format::FmtDefault/get_excel_region>

=back

=head3 set_defined_excel_formats( %args )

=over

B<Definition:> This allows for adjustment and or addition to the output format lookup table.
The default implementation allows for multiple ways to do this so please review that documentation
for details.

B<Default source:> L<Spreadsheet::Reader::Format::FmtDefault/set_defined_excel_formats( %args )>

=back

=head3 set_cache_behavior( $bool )

=over

B<Definition:> This sets the flag that turns on caching of built format conversion code sets

B<Default source:> L<Spreadsheet::Reader::Format::ParseExcelFormatStrings/set_cache_behavior( $bool )>

=back

=head3 set_date_behavior( $bool )

=over

B<Definition:> This sets the flag that interrupts the date formatting to return a datetime object rather
than a date string

B<Default source:> L<Spreadsheet::Reader::Format::ParseExcelFormatStrings/set_date_behavior( $bool )>

=back

=head3 set_european_first( $bool )

=over

B<Definition:> This also sets a flag dealing with dates.  The date behavior that is affected here
involves parsing date strings (not excel date numbers) and checks the DD-MM-YY form before it
checkes the MM-DD-YY form when attempting to parse date strings.

B<Default source:> L<Spreadsheet::Reader::Format::ParseExcelFormatStrings/set_european_first( $bool )>

=back

=head3 set_workbook_inst( $instance )

=over

B<Definition:> This sets the workbook instance in the Formatter instance.
L<Spreadsheet::Reader::ExcelXML> should do this automatically and will overwrite this attribute
if the end-user sets it.  The purpose of this instance is for the formatter to see some of the
workbook level methods;

B<Delegates:>

=over

L<Spreadsheet::Reader::ExcelXML/set_error>

L<Spreadsheet::Reader::ExcelXML/get_epoch_year>

=back

B<Default source:> L<Spreadsheet::Reader::Format::ParseExcelFormatStrings/set_workbook_inst( $instance )>

=back

=head1 SUPPORT

=over

L<github Spreadsheet::Reader::Format/issues
|https://github.com/jandrew/p5-spreadsheet-reader-format/issues>

=back

=head1 TODO

=over

B<1.> Nothing yet

=back

=head1 AUTHOR

=over

=item Jed Lund

=item jandrew@cpan.org

=back

=head1 COPYRIGHT

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.

This software is copyrighted (c) 2016, 2017 by Jed Lund

=head1 DEPENDENCIES

=over

L<version> -  0.77

L<perl 5.010|perl/5.10.0>

L<Encode> - decode

L<Moose> 2.1213

L<Carp> - confess

L<Type::Tiny> - 1.000

L<DateTimeX::Format::Excel> - 0.012

L<DateTime::Format::Flexible>

L<Clone> - clone

=back

=head1 SEE ALSO

=over

L<Spreadsheet::ParseExcel> - Excel 2003 and earlier

L<Spreadsheet::XLSX> - 2007+

L<Spreadsheet::ParseXLSX> - 2007+

L<Log::Shiras|https://github.com/jandrew/Log-Shiras>

=over

All lines in this package that use Log::Shiras are commented out

=back

=back

=begin html

<a href="http://www.perlmonks.org/?node_id=706986">
	<img src="http://www.perlmonksflair.com/jandrew.jpg" alt="perl monks">
</a>

=end html

=cut

#########1#########2 main pod documentation end   5#########6#########7#########8#########9
