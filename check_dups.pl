#!/usr/bin/env perl
# Check urls.opml file for duplicate urls.

use strict;
use warnings;
use diagnostics;
use autodie;

my %seen = ();

open my $fh, '<', 'urls.opml';
while (<$fh>) {
    next unless /\bhttps?:\/\/[^"'> ]+\b/;
    $seen{ $& }++;
}
close $fh;

for (keys %seen) {
    print "$_\n" if $seen{ $_ } > 1;
}

# End of file.
