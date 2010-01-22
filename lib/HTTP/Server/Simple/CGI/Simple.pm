package HTTP::Server::Simple::CGI::Simple;

use 5.008_006;
use warnings;
use strict;

our $VERSION = '0.01';

use CGI::Simple qw( -nph );

use base qw(HTTP::Server::Simple HTTP::Server::Simple::CGI::Environment);

sub accept_hook {
    my $self = shift;
    $self->setup_environment(@_);
}

sub post_setup_hook {
    my $self = shift;
    $self->setup_server_url;
}

sub setup {
    my $self = shift;
    $self->setup_environment_from_metadata(@_);
}

sub handle_request {
    my $self = shift;
    my ($cgi) = @_;

    my $response = "Internal Server Error\n";

    print $cgi->header(
        -status => 500,
        -type => 'text/plain',
        -charset => 'UTF-8',
        -length => length $response,
    ), $response;
    die sprintf '%s::handle_request not implemented', ref $self;
    return;
}

sub handler {
    my $self = shift;
    my $cgi  = CGI::Simple->new;
    eval { $self->handle_request($cgi) };
    if (my $error = $@) {
        warn $error;
    }
    return;
}

"HTTP::Server::Simple::CGI::Simple"

__DATA__

=head1 NAME

HTTP::Server::Simple::CGI::Simple - use CGI::Simple instead of CGI.pm

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

HTTP::Server::Simple::CGI provides a CGI.pm object to the request handler.
CGI::Simple is a purely object oriented replacement for CGI.pm that does
away with a lot of historical baggage including HTML generation methods.

Use this module to provide a CGI::Simple object to the request handler.

    use HTTP::Server::Simple::CGI::Simple;

    my $foo = HTTP::Server::Simple::CGI::Simple->new();
    ...

=head1 METHODS

=head2 accept_hook

Sets up the environment (copied verbatim from C<HTTP::Server::Simple::CGI>).

=head2 handle_request

Subclasses must implement C<handle_request>. The default implementation
provided in this module C<die>s  and sends a
C<500 Internal Server Error> status.

=head2 handler

Creates a new C<CGI::Simple> object and invokes C<handle_request> in
an C<eval>.

=head2 post_setup_hook

This module removes the call to C<CGI::initialize_globals>.

=head2 setup

Sets up the environment from meta data (copied verbatim from C<HTTP::Server::Simple::CGI>).

=head1 SEE ALSO

L<HTTP::Server::Simple>, L<HTTP::Server::Simple::CGI>

=head1 AUTHOR

A. Sinan Unur, C<< <nanis at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-http-server-simple-cgi-simple at rt.cpan.org>, or through the web
interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=HTTP-Server-Simple-CGI-Simple>.
I will be notified, and then you'll automatically be notified of progress on
your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc HTTP::Server::Simple::CGI::Simple


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=HTTP-Server-Simple-CGI-Simple>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/HTTP-Server-Simple-CGI-Simple>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/HTTP-Server-Simple-CGI-Simple>

=item * Search CPAN

L<http://search.cpan.org/dist/HTTP-Server-Simple-CGI-Simple/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2010 A. Sinan Unur.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.

