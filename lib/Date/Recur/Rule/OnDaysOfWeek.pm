## ----------------------------------------------------------------------------
package Date::Recur::Rule::OnDaysOfWeek;

use Moose;
with 'Date::Recur::Rule::Role';

has 'days_of_week' => (
    is         => 'rw',
    isa        => 'ArrayRef',
    default    => sub { [] },
);

sub matches {
    my ($self, $date) = @_;
    foreach my $day ( @{ $self->days_of_week } ) {
        return 1 if $day eq $date->day_of_week;
    }
    return 0;
}

## ----------------------------------------------------------------------------
__PACKAGE__->meta->make_immutable();
1;
## ----------------------------------------------------------------------------
