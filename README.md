OVERVIEW
--------
This directory contains RSS/Atom feeds for the software used in
Zeppe-Lin pkgsrc collections.

The main purpose of these feeds is to help maintainer to watch for
software updates.


USAGE
-----
Import `urls.opml` into any feed reader you like.
In case of **snownews** just copy this file to
`~/.config/snownews/` directory.


MAINTAINING
-----------

**Scripts**:
- `check_dups.sh` checks `urls.opml` for duplicate urls.
- `check_urls.sh` checks `urls.opml` file for dead links.
- `lint.pl` performs various checks for `urls.opml` file.
   Try `./lint.pl --help` for more information.


LICENSE
-------
pkgsrcfeeds is licensed through WTFPLv2 License.
See LICENSE file for copyright and license details.
