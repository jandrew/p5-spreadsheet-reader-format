#!/usr/bin/env perl
### Test that the pod files run
use Test::More;
use Test::Pod 1.48;
my	$up		= '../';
for my $next ( <*> ){
	if( ($next eq 't') and -d $next ){
		### <where> - found the t directory - must be using prove ...
		$up	= '';
		last;
	}
}
pod_file_ok( $up . 	'lib/Spreadsheet/Reader/Format/Types.pm',
						"The Spreadsheet::Reader::Format::Types file has good POD" );
pod_file_ok( $up . 	'lib/Spreadsheet/Reader/Format/FmtDefault.pm',
						"The Spreadsheet::Reader::Format::FmtDefault file has good POD" );
pod_file_ok( $up . 	'lib/Spreadsheet/Reader/Format/ParseExcelFormatStrings.pm',
						"The Spreadsheet::Reader::Format::ParseExcelFormatStrings file has good POD" );
pod_file_ok( $up . 	'lib/Spreadsheet/Reader/Format.pm',
						"The Spreadsheet::Reader::Format file has good POD" );
done_testing();