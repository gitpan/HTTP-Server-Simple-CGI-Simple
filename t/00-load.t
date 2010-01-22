#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'HTTP::Server::Simple::CGI::Simple' ) || print "Bail out!
";
}

diag( "Testing HTTP::Server::Simple::CGI::Simple $HTTP::Server::Simple::CGI::Simple::VERSION, Perl $], $^X" );
