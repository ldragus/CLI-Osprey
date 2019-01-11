package MyCmd::Role::SubCommand;

use Moo::Role;

with 'MyCmd::Role::Config';

# this percolates up to the top level to retrieve the global message
# option
has 'parent' => (
    is       => 'ro',
    init_arg => undef,
    default  => sub { $_[0]->_meta->parent },
    handles  => ['message'],
);

around new_with_options => sub {
    my ( $orig, $class, %params ) = @_;

    my $meta = $params{_meta};

    my $_config = $params{_config} = $meta->parent->_config->{ $meta->command }
      // {};
    $class->_extract_config_params( $_config, \%params );
    return $class->$orig( %params );
};

1;

