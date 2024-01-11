#!/usr/bin/env perl
# Check feeds for duplicate urls.

use strict;
use warnings;
use diagnostics;
use autodie;

my %seen = ();

open my $fh, '<', 'feeds.urls';
while (<$fh>) {
    next unless /^https?:\/\//;

    my $url = (split / /)[0];
    $seen{ "$url" }++;
}
close $fh;

for (keys %seen) {
    print "$_\n" if $seen{ "$_" } > 1;
}

# End of file.
