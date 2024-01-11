#!/usr/bin/env perl
# Generate snownews.opml file from newsboat.urls.

use strict;
use warnings;
use diagnostics;
use autodie;

open my $fh1, '>', 'snownews.opml';
print $fh1 <<EOF;
<?xml version="1.0"?>
<opml version="2.0">
  <head>
    <title>zeppe-Lin pkgsrc feeds for snownews</title>
  </head>
  <body>
EOF

open my $fh0, '<', 'newsboat.urls';
while (<$fh0>) {
    next unless m/^(?<url>https?:\/\/.*?)\s+"(?<text>.*?)"\s+(?<category>(?:core|system|xorg|desktop|stuff|dev))$/;

    print $fh1 <<EOF;
    <outline text="$+{text}" xmlUrl="$+{url}" category="$+{category}"/>
EOF
}
close $fh0;

print $fh1 <<EOF;
    <outline text="(New headlines)" xmlUrl="smartfeed:/newitems"/>
  </body>
</opml>
EOF
close $fh1;

# End of file.
