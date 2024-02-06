#!/usr/bin/env perl
# Various checks for urls.opml file.

use strict;
use warnings;
use diagnostics;
use autodie;
use File::Basename;
use Term::ANSIColor qw(:constants);
use Getopt::Long qw(:config gnu_compat no_ignore_case bundling);

my $PROGRAM = basename $0;
my $VERSION = '0.1';

######################################################################

my @obsolete_packages = qw(
    autoconf-2.13
    fuse2
    gtk-engines
    gtk-engine-hc
    gtk-engine-redmond95
    hcxtools3
    ktsuss
    librsvg-compat
    libxcrypt2.4
    mdk3
    newsboat213
    pango-compat
    pm-utils
    py-cairo
    py-gobject-compat
    python
    shared-mime-info
    smtp-user-enum
    tnscmd10g
    xorg-libxfont
    xorg-xf86-input-keyboard
    );
my @internal_packages = qw(
    filesystem
    );

######################################################################

my %feed;
my %internal = map { $_ => 1 } @internal_packages;
my %obsolete = map { $_ => 1 } @obsolete_packages;
my %repo     = map { chomp; $_ => 1 } qx(pkgman printf "%n\n");

######################################################################

sub load_feeds {
    open my $fh, 'urls.opml';
    while (<$fh>) {
        next unless m{
            \s*
            <outline\s+
                text="(?<title>.*?)\s+@.*?"\s+
                xmlUrl=".*"\s+
                category="(?:core|system|xorg|desktop|stuff)"/>
        }xsm;
        for my $pkg (split /\//, $+{title}) {
            $feed{ $pkg }++;
        }
    }
    close $fh;
}

sub print_missing {
    print <<EOF;

The following repo packages have no RSS/Atom feeds:
===================================================

EOF
    for (sort keys %repo) {
        next if exists $feed{ $_ };

        my $pkgsrcpath = qx(pkgman path $_);
        chomp $pkgsrcpath;

        if ($obsolete{ $_ }) {
            print "[x] \e[9m$pkgsrcpath\e[0m \e[3m(obsolete)\e[0m\n";
        } elsif ($internal{ $_ }) {
            print "[v] \e[9m$pkgsrcpath\e[0m \e[3m(internal)\e[0m\n";
        } else {
            print "[ ] $pkgsrcpath\n";
        }
    }
}

sub print_redundant {
    print <<EOF;

The following RSS/Atom feeds in urls.opml are redundant:
========================================================

EOF
    for (sort keys %feed) {
        print "$_\n" unless exists $repo{ $_ };
    }
}

# ====================================================================

sub print_version {
    print "$PROGRAM $VERSION\n";
}

sub print_help {
    print <<EOF;
Usage: $PROGRAM [OPTION...]
Lint RSS/Atom feeds.

  -m, --missing    check for packages that have no feeds in urls.opml
  -r, --redundant  check for redundant feeds in urls.opml
  -v, --version    print version and exit
  -h, --help       print help and exit
EOF
}

# ====================================================================

sub main {
    GetOptions(
        "m|missing"   => \my $opt_missing,
        "r|redundant" => \my $opt_redundant,
        "v|version"   => \my $opt_version,
        "h|help"      => \my $opt_help,
    ) or die "Try '$PROGRAM --help' for more information.\n";

    print_version() and exit if $opt_version;
    print_help()    and exit if $opt_help;

    load_feeds();

    print_missing()   if $opt_missing;
    print_redundant() if $opt_redundant;
}

main() if not caller();
1;

# vim: sw=4 ts=4 sts=4 et cc=72 tw=70
# End of file.
