use inc::Module::Install;

name     'HTTP-Server-Simple-CGI-Simple';
all_from 'lib/HTTP/Server/Simple/CGI/Simple.pm';
readme_from 'lib/HTTP/Server/Simple/CGI/Simple.pm';
author   q{A. Sinan Unur <nanis@cpan.org>};
license  'perl';

requires       'HTTP::Server::Simple' => '0.38';
requires       'HTTP::Server::Simple::CGI::Environment';
requires       'CGI::Simple' => '1.107';
build_requires 'Test::More';

sign;

auto_install;

WriteAll;

