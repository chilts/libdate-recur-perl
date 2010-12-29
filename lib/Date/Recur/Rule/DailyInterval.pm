## ----------------------------------------------------------------------------
package Date::Recur::Rule::DailyInterval;

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

    # we want the interval to fully divide into the original
    my $difference_in_days = $date - $r->start;

    # if this interval is fully divisible, then we're sweet
    if ( $difference_in_days % $self->interval == 0 ) {
        return 1;
    }

    return 0;
}

## ----------------------------------------------------------------------------
__PACKAGE__->meta->make_immutable();
1;
## ----------------------------------------------------------------------------
