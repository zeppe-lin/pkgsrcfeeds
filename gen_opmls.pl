#!/usr/bin/env perl
# Generate opml files for newsboat and snownews.

use strict;
use warnings;
use diagnostics;
use autodie;

open my $newsboat_urls, '<', 'newsboat.urls';
open my $newsboat_opml, '>', 'newsboat.opml';
open my $snownews_opml, '>', 'snownews.opml';

print $newsboat_opml <<EOF;
<?xml version="1.0"?>
<opml version="1.0">
  <head>
    <title>newsboat - Exported Feeds</title>
  </head>
  <body>
EOF

print $snownews_opml <<EOF;
<?xml version="1.0"?>
<opml version="2.0">
  <head>
    <title>zeppe-Lin pkgsrc feeds for snownews</title>
  </head>
  <body>
EOF

while (<$newsboat_urls>) {
    next unless m/^(?<url>https?:\/\/.*?)\s+"(?<text>.*?)"\s+(?<category>(?:core|system|xorg|desktop|stuff|dev))$/;

    print $newsboat_opml <<EOF;
    <outline type="rss" xmlUrl="$+{url}" htmlUrl="" title="$+{text}" category="$+{category}"/>
EOF

    print $snownews_opml <<EOF;
    <outline text="$+{text}" xmlUrl="$+{url}" category="$+{category}"/>
EOF
}

print $newsboat_opml <<EOF;
  </body>
</opml>
EOF

print $snownews_opml <<EOF;
    <outline text="(New headlines)" xmlUrl="smartfeed:/newitems"/>
  </body>
</opml>
EOF

close $newsboat_urls;
close $newsboat_opml;
close $snownews_opml;

# End of file.
