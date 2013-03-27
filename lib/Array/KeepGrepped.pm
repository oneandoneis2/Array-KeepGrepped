package Array::KeepGrepped;
# ABSTRACT: Like grep, only keeps the stuff it filters out

require Exporter;
@ISA = qw/Exporter/;
@EXPORT_OK = qw/kgrep/;

sub kgrep (&@) {
    my $filter = shift;
    my $filtered = [];
    my @keep;
    local $_;
    for (@_) {
        if ( $filter->() ) {
            push @keep, $_;
            }
        else {
            push @$filtered, $_;
            }
        }
    return ($filtered, @keep);
    }

1;

=head1 SYNOPSIS

    use Array::KeepGrepped qw/kgrep/;

    my @numbers = 1..10;

    my ($even, @odd) = kgrep { $_ % 2 } @numbers;

    $, = ","; print @odd,@$even;    # prints "1,3,5,7,9,2,4,6,8,10"

=head1 DESCRIPTION

Works like the built-in Perl 'grep', but instead of just skipping over the
entries that don't match, puts them instead into a seperate array that's
returned (by reference) as the first item of the returned list.

Primary use for this is when you want to remove elements from an array
in-place, but still be able to use what you removed.

=head1 EXAMPLES

    my @good = qw/good bad good evil good wicked good/;

    my $bad;

    ($bad, @good) = kgrep { $_ =~ /good/ } @good;

    say "@$bad | @good";   # bad evil wicked | good good good good

=head1 SEE ALSO

grep

=cut
