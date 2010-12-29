## ----------------------------------------------------------------------------
package Date::Recur::Rule::WeeklyInterval;

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

    # get the start of the week (Monday)
    my $start_of_week = $r->start;
    until ( $start_of_week->day == 1 ) {
        $start_of_week--;
    }

    # get the difference in days from the start of the original week, to now
    my $difference_in_days = $date - $start_of_week;

    # see how many weeks this has been
    my $weeks = int($difference_in_days / 7);

    # if this interval is fully divisible, then we're sweet
    if ( $weeks % $self->interval == 0 ) {
        return 1;
    }

    return 0;
}

## ----------------------------------------------------------------------------
__PACKAGE__->meta->make_immutable();
1;
## ----------------------------------------------------------------------------
