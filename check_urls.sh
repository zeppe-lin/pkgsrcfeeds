#!/bin/sh
# Check urls.opml file for dead links.

grep -Eiho "https?://[^\"\\'> ]+" urls.opml | xargs -r -P10 -I{} \
	curl -I -o /dev/null -sw "[%{http_code}] %{url}\n" '{}'  |
	grep -v '^\[200\]' | sort -u

# End of file.
