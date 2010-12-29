## ----------------------------------------------------------------------------

package Date::Recur;
use Moose;
use Moose::Util::TypeConstraints;

use Carp;
use Date::Simple;

# all our rules (for the convenience functions)
use Date::Recur::Rule::OnDaysOfWeek;
use Date::Recur::Rule::OnDaysOfMonth;
use Date::Recur::Rule::OnMonthsOfYear;
use Date::Recur::Rule::MonthlyInterval;

our $VERSION = '0.1';

## ----------------------------------------------------------------------------

subtype 'Date::Recur::DateSimple' => as class_type('Date::Simple');

coerce 'Date::Recur::DateSimple'
    => from 'Str'
        => via { Date::Simple->new( $_ ) }
;

has start => (
    is         => 'rw',
    isa        => 'Date::Recur::DateSimple',
    clearer    => 'clear_start',
    predicate  => 'has_start',
    coerce     => 1,
);

has end => (
    is         => 'rw',
    isa        => 'Date::Recur::DateSimple',
    clearer    => 'clear_end',
    predicate  => 'has_end',
    coerce     => 1,
);

has rules => (
    is         => 'rw',
    isa        => 'ArrayRef',
    default    => sub { [] },
);

## ----------------------------------------------------------------------------
# constants

sub EXCLUSIVE { 0 }
sub INCLUSIVE { 1 }

# start the week on Sunday (which is zero)
sub SUNDAY { 0 }
sub MONDAY { 1 }
sub TUESDAY { 2 }
sub WEDNESDAY { 3 }
sub THURSDAY { 4 }
sub FRIDAY { 5 }
sub SATURDAY { 6 }

sub SUN { 0 }
sub MON { 1 }
sub TUE { 2 }
sub WED { 3 }
sub THU { 4 }
sub FRI { 5 }
sub SAT { 6 }

sub JANUARY { 1 }
sub FEBRUARY { 2 }
sub MARCH { 3 }
sub APRIL { 4 }
sub MAY { 5 }
sub JUNE { 6 }
sub JULY { 7 }
sub AUGUST { 8 }
sub SEPTEMBER { 9 }
sub OCTOBER { 10 }
sub NOVEMBER { 11 }
sub DECEMBER { 12 }

sub JAN { 1 }
sub FEB { 2 }
sub MAR { 3 }
sub APR { 4 }
# sub MAY { 5 } # already defined above
sub JUN { 6 }
sub JUL { 7 }
sub AUG { 8 }
sub SEP { 9 }
sub OCT { 10 }
sub NOV { 11 }
sub DEC { 12 }

## ----------------------------------------------------------------------------

sub include {
    my ($self, $rule) = @_;
    push @{ $self->rules }, { kind => INCLUSIVE, rule => $rule };
}

sub exclude {
    my ($self, $rule) = @_;
    push @{ $self->rules }, { kind => EXCLUSIVE, rule => $rule };
}

# Note: without any rules, a Date::Recur matches EVERY SINGLE date
sub matches {
    my ($self, $date) = @_;

    $date = Date::Simple->new( $date)
        unless ref $date eq 'Date::Simple';

    if ( $self->start ) {
        return 0 unless $date >= $self->start;
    }
    if ( $self->end ) {
        return 0 unless $date <= $self->end;
    }

    # loop through all the rules
    foreach my $rule ( @{ $self->rules } ) {
        if ( $rule->{kind} eq INCLUSIVE ) {
            # INCLUSIVE - if we match this, proceed to the next rule
            next if $rule->{rule}->matches( $date, $self );

            # didn't match this inclusive date, so return false
            return 0;
        }
        else {
            # EXCLUSIVE - if we match this, then we fail
            return 0 if $rule->{rule}->matches( $date, $self );

            # we didn't match the exclusion, so carry on to the next rule
            next;
        }
    }
    return 1;
}

## ----------------------------------------------------------------------------
# create some convenience methods

sub include_daily_interval {
    my ($self, $interval) = @_;
    $self->include(
        Date::Recur::Rule::DailyInterval->new( interval => $interval )
    );
}

sub exclude_daily_interval {
    my ($self, $interval) = @_;
    $self->exclude(
        Date::Recur::Rule::DailyInterval->new( interval => $interval )
    );
}

sub include_days_of_week {
    my ($self, @days) = @_;
    $self->include(
        Date::Recur::Rule::OnDaysOfWeek->new( days_of_week => \@days )
    );
}

sub exclude_days_of_week {
    my ($self, @days) = @_;
    $self->exclude(
        Date::Recur::Rule::OnDaysOfWeek->new( days_of_week => \@days )
    );
}

sub include_days_of_month {
    my ($self, @days) = @_;
    $self->include(
        Date::Recur::Rule::OnDaysOfMonth->new( days_of_month => \@days )
    );
}

sub exclude_days_of_month {
    my ($self, @days) = @_;
    $self->exclude(
        Date::Recur::Rule::OnDaysOfMonth->new( days_of_month => \@days )
    );
}

sub include_months_of_year {
    my ($self, @months) = @_;
    $self->include(
        Date::Recur::Rule::OnMonthsOfYear->new( months_of_year => \@months )
    );
}

sub exclude_months_of_year {
    my ($self, @months) = @_;
    $self->exclude(
        Date::Recur::Rule::OnMonthsOfYear->new( months_of_year => \@months )
    );
}

sub include_monthly_interval {
    my ($self, $interval) = @_;
    $self->include(
        Date::Recur::Rule::MonthlyInterval->new( interval => $interval )
    );
}

sub exclude_monthly_interval {
    my ($self, $interval) = @_;
    $self->exclude(
        Date::Recur::Rule::MonthlyInterval->new( interval => $interval )
    );
}

sub include_yearly_interval {
    my ($self, $interval) = @_;
    $self->include(
        Date::Recur::Rule::YearlyInterval->new( interval => $interval )
    );
}

sub exclude_yearly_interval {
    my ($self, $interval) = @_;
    $self->exclude(
        Date::Recur::Rule::YearlyInterval->new( interval => $interval )
    );
}

## ----------------------------------------------------------------------------
__PACKAGE__->meta->make_immutable();
1;
## ----------------------------------------------------------------------------
