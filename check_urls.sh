#!/bin/sh
# Check newsboat.urls file for dead links.

grep -Eiho "https?://[^\"\\'> ]+" newsboat.urls | xargs -r -P10 -I{} \
	curl -I -o /dev/null -sw "[%{http_code}] %{url}\n" '{}'  |
	grep -v '^\[200\]' | sort -u

# End of file.
