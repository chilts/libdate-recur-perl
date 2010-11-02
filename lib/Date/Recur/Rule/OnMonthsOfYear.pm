## ----------------------------------------------------------------------------
package Date::Recur::Rule::OnMonthsOfYear;

use Moose;
with 'Date::Recur::Rule::Role';

has 'months_of_year' => (
    is         => 'rw',
    isa        => 'ArrayRef',
    default    => sub { [] },
);

sub matches {
    my ($self, $date) = @_;
    foreach my $month ( @{ $self->months_of_year } ) {
        return 1 if $month eq $date->month;
    }
    return 0;
}

## ----------------------------------------------------------------------------
__PACKAGE__->meta->make_immutable();
1;
## ----------------------------------------------------------------------------
