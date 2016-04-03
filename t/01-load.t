#!/usr/bin/env perl
### Test that the module(s) load!(s)
use	Test::More;
BEGIN{ use_ok( Test::Pod, qw( 1.48 ) ) };
BEGIN{ use_ok( TAP::Formatter::Console ) };
BEGIN{ use_ok( TAP::Harness ) };
BEGIN{ use_ok( TAP::Parser::Aggregator ) };
BEGIN{ use_ok( version ) };
BEGIN{ use_ok( Test::Moose ) };
BEGIN{ use_ok( Data::Dumper ) };
BEGIN{ use_ok( Capture::Tiny, qw( capture_stderr capture_stdout ) ) };
BEGIN{ use_ok( Carp, qw( cluck ) ) };
BEGIN{ use_ok( Clone, qw( clone ) ) };
BEGIN{ use_ok( Type::Tiny, 1.000 ) };
BEGIN{ use_ok( Moose ) };
BEGIN{ use_ok( MooseX::StrictConstructor ) };
BEGIN{ use_ok( MooseX::HasDefaults::RO ) };
BEGIN{ use_ok( Archive::Zip ) };
BEGIN{ use_ok( File::Temp ) };
BEGIN{ use_ok( DateTimeX::Format::Excel, 0.012 ) };
BEGIN{ use_ok( MooseX::ShortCut::BuildInstance, 1.026 ) };
BEGIN{ use_ok( MooseX::ShortCut::BuildInstance, qw( build_instance ) ) };
BEGIN{ use_ok( DateTime::Format::Flexible ) };
use	lib '../lib', 'lib';
BEGIN{ use_ok( Spreadsheet::Reader::Format, 0.002 ) };
BEGIN{ use_ok( Spreadsheet::Reader::Format::Types, 0.002 ) };
BEGIN{ use_ok( Spreadsheet::Reader::Format::FmtDefault, 0.002 ) };
BEGIN{ use_ok( Spreadsheet::Reader::Format::ParseExcelFormatStrings, 0.002 ) };
done_testing();