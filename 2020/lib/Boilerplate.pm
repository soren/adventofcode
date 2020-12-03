package Boilerplate;

use 5.028;
use strict;
use warnings;
use open qw(:std :utf8);
use feature qw(signatures);
no warnings qw(experimental::signatures);
no bareword::filehandles;
no multidimensional;
use utf8;

use Carp;
use Data::Dump qw(dump);
use Nice::Try;

use Import::Into;


sub import {
    my ($class) = @_;
    my $caller = caller;

    strict->import;
    warnings->import;
    warnings->unimport('experimental::signatures');
    bareword::filehandles->unimport;
    multidimensional->unimport;
    feature->import(qw/:5.28 signatures/);
    "open"->import(qw/:std :utf8/);
    utf8->import;
    Carp->import::into($caller);
    Data::Dump->import::into($caller, (qw/dump/));
    Nice::Try->import::into($caller);
}


sub unimport {
    strict->unimport;
    warnings->unimport;
    bareword::filehandles->import;
    multidimensional->import;
    feature->unimport;
    utf8->unimport;
    "open"->unimport;
    Carp->unimport;
    Data::Dump->unimport;
    Nice::Try->unimport;
}


1;
