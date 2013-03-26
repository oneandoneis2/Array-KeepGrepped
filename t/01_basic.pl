use Test::More tests => 12;

use lib 'lib';
use Array::KeepGrepped qw/kgrep/;

NUMERIC: {
    my @numbers = 1..10;
    my ($odds, @evens) = kgrep { $_ % 2 } @numbers;
    for my $odd (1,3,5,7,9) {
        ok($odd == shift @$odds, 'Correct odd numbers');
        }
    for my $even (2,4,6,8,10) {
        ok($even == shift @evens, 'Correct even numbers');
        }
    }

IN_PLACE: {
    my @good = qw/good bad good evil good wicked good/;
    my $bad;
    ($bad, @good) = kgrep { $_ !~ /good/ } @good;
    is(@$bad, 3, 'Correct number of bad values');
    is(@good, 4, 'Correct number of good values');
    }

done_testing();
