OVERVIEW
--------
This directory contains RSS/Atom feeds for the software used in
Zeppe-Lin pkgsrc collections.

The main purpose of these feeds is to help maintainer to watch for
updates.


USAGE
-----

Just copy `urls.opml` file to `~/.config/snownews/` directory, or
make a symbolic link.

- `lint.pl` performs various checks for `urls.opml` file.
  See `lint.pl --help` for more information.

- `check_urls.sh` checks `urls.opml` file for dead links.


LICENSE
-------
pkgsrcfeeds is licensed through WTFPLv2 License.
See LICENSE file for copyright and license details.
