## ----------------------------------------------------------------------------
package Date::Recur::Rule::Role;

use Moose::Role;
requires 'matches';

sub doesnt_match {
    my ($self, $date) = @_;
    return not $self->matches($date);
}

## ----------------------------------------------------------------------------
no Moose::Role;
1;
## ----------------------------------------------------------------------------
