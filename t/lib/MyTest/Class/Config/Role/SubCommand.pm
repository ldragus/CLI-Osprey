package MyTest::Class::Config::Role::SubCommand;

use Moo::Role;
use CLI::Osprey;

with 'CLI::Osprey::Config';

# this percolates up to the top level to retrieve the global message
# option
has 'parent' => (
    is       => 'ro',
    init_arg => undef,
    default  => sub { $_[0]->_meta->parent },
    handles  => ['message'],
);

option 'config' => (
    is     => 'ro',
    format => 's',
    short  => 'f',
    doc    => 'config file',
);

1;

