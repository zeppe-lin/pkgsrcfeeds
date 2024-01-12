OVERVIEW
--------
This directory contains RSS/Atom feeds for the software used in
Zeppe-Lin pkgsrc collections.

The main purpose of these feeds is to help maintainer to watch for
software updates.


USAGE
-----

**Newsboat**:
- Import `newsboat.opml` or use `newsboat.urls` as `-u` argument.

**Snownews**:
- Copy `snownews.opml` file to `~/.config/snownews/urls.opml`.


MAINTAINING
-----------

**Scripts**:
- `check_dups.sh` checks `newsboat.urls` for duplicate urls.
- `check_urls.sh` checks `newsboat.urls` file for dead links.
- `gen_opmls.sh` generates opml files for newsboat and snownews.
- `lint.pl` performs various checks for `newsboat.urls` file.
   See `./lint.pl --help` for more information.


LICENSE
-------
pkgsrcfeeds is licensed through WTFPLv2 License.
See LICENSE file for copyright and license details.
