## ----------------------------------------------------------------------------
package Date::Recur::Rule::MonthlyInterval;

use Moose;
with 'Date::Recur::Rule::Role';

use Carp;

# ToDo: somehow bork if this rule is added to something without a start date

has 'interval' => (
    is         => 'rw',
    isa        => 'Int',
    default    => 1,
);

sub matches {
    my ($self, $date, $r) = @_;

    carp "Unable to check if this date matches since we have no start date (required)"
        unless $r->start;

    # just fail if this date is before the start date
    return 0 if $date < $r->start();

    # get the original year and month
    my $initial_year = $r->start->month();
    my $initial_month = $r->start->month();

    # get this year and month
    my $date_year = $date->month();
    my $date_month = $date->month();

    # we want the interval to fully divide into the original
    my $difference_in_months = ( $date_year - $initial_year ) * 12
        + ( $date_month - $initial_month );

    # if this interval is fully divisible, then we're sweet
    if ( $difference_in_months % $self->interval == 0 ) {
        return 1;
    }

    return 0;
}

## ----------------------------------------------------------------------------
__PACKAGE__->meta->make_immutable();
1;
## ----------------------------------------------------------------------------
