## ----------------------------------------------------------------------------
package Date::Recur::Rule::OnDaysOfMonth;

use Moose;
with 'Date::Recur::Rule::Role';

has 'days_of_month' => (
    is         => 'rw',
    isa        => 'ArrayRef',
    default    => sub { [] },
);

sub matches {
    my ($self, $date) = @_;
    foreach my $day ( @{ $self->days_of_month } ) {
        return 1 if $day eq $date->day;
    }
    return 0;
}

## ----------------------------------------------------------------------------
__PACKAGE__->meta->make_immutable();
1;
## ----------------------------------------------------------------------------
