#!/usr/bin/env perl
my	$dir 	= './';
my	$tests	= 'Spreadsheet/Reader/';
my	$up		= '../';
for my $next ( <*> ){
	if( ($next eq 't') and -d $next ){
		$dir	= './t/';
		$up		= '';
		last;
	}
}

use	TAP::Formatter::Console;
my $formatter = TAP::Formatter::Console->new({
					jobs => 1,
					#~ verbosity => 1,
				});
my	$args ={
		lib =>[
			$up . 'lib',
			$up,
			#~ $up . '../Log-Shiras/lib',
		],
		test_args =>{
			load_test					=>[],
			pod_test					=>[],
			types_test					=>[],
			default_format_test			=>[],
			excel_format_string_test	=>[],
			format_interface_test		=>[],
		},
		formatter => $formatter,
	};
my	@tests =(
		[  $dir . '01-load.t', 'load_test' ],
		[  $dir . '02-pod.t', 'pod_test' ],
		[  $dir . $tests . 'Format/01-types.t', 'types_test' ],
		[  $dir . $tests . 'Format/02-fmt_default.t', 'default_format_test' ],
		[  $dir . $tests . 'Format/03-parse_excel_fmt_string.t', 'excel_format_string_test' ],
		[  $dir . $tests . '01-format_interface.t', 'format_interface_test' ],
	);
use	TAP::Harness;
use	TAP::Parser::Aggregator;
my	$harness	= TAP::Harness->new( $args );
my	$aggregator	= TAP::Parser::Aggregator->new;
	$aggregator->start();
	$harness->aggregate_tests( $aggregator, @tests );
	$aggregator->stop();
use Test::More;
explain $formatter->summary($aggregator);
pass( "Test Harness Testing complete" );
done_testing();