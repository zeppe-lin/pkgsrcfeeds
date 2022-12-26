#!/usr/bin/env perl

use strict;
use warnings;
use diagnostics;
use autodie;
#use File::Basename;
use Term::ANSIColor qw(:constants);

my %obsolete_package = map { $_ => 1 } qw(
    autoconf-2.13
    fuse2
    hcxtools3
    ktsuss
    librsvg-compat
    libxcrypt2.4
    mdk3
    newsboat213
    pango-compat
    pm-utils
    py-cairo
    py-gobject-compact
    py-gobject-compat
    python
    shared-mime-info
    smtp-user-enum
    tnscmd10g
    picom
    gtk-engines
    transset-df
    );

my %internal_package = map { $_, 1 } qw(
    filesystem
    );

my %pkgsrc = map { chomp; $_, 1 } qx(pkgman printf "%n\n");

my %feed;

open my $fh, 'feeds.urls';
while (<$fh>) {
    next unless
        /^(?:.*?)\s+"~\[.*?\]\s+(?<title>.*?)"(?:\s+(?:.*?)\s+)?$/;

    $feed{ $_ }++ for (split /\/\s*/, $+{title});
}
close $fh;

print <<EOF;

The following packages have no RSS feeds
========================================

EOF

for (sort keys %pkgsrc) {
    next if exists $feed{ $_ };

    if ($obsolete_package{ $_ }) {
        print "[x] \e[9m$_\e[0m (obsolete)\n";
    } elsif ($internal_package{ $_ }) {
        print "[v] $_ (internal)\n";
    } else {
        print "[ ] $_\n";
    }
}

print <<EOF;

The following feeds are redundant
=================================

EOF

for (sort keys %feed) {
    print "$_\n" unless exists $pkgsrc{ $_ };
}

# vim:sw=4:ts=4:sts=4:et:cc=72:tw=70
# End of file.
