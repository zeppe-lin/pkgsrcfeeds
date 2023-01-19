NEWSBOAT_FEEDS = ${CURDIR}/feeds.urls
OPML           = ${CURDIR}/feeds.opml
LINTER         = ${CURDIR}/lint

define USAGE
Usage: make [TARGET]

TARGETS:

  check              perform the following targets
    check-urls       check feeds' urls for response code
    check-missing    check feeds for missing urls
    check-redundant  check for redundant feeds

  opml               convert newsboat urls file to opml
endef

all: help
help:
	@echo $(info ${USAGE})

check: check-urls check-missing check-redundant

check-urls:
	@echo "=======> Check feeds.urls for response code"
	@grep -Eiho "https?://[^\"\\'> ]+" ${NEWSBOAT_FEEDS} | xargs -P10 -I{} \
		curl -o /dev/null -sw "[%{http_code}] %{url}\n" '{}'

check-missing:
	@echo "=======> Check feeds.urls for missing feeds"
	@perl ${LINTER} --missing

check-redundant:
	@echo "=======> Check feeds.urls for redundant feeds"
	@perl ${LINTER} --redundant

opml:
	newsboat -u ${NEWSBOAT_FEEDS} -e > ${OPML}

.PHONY: all help check check-urls check-missing check-redundant opml

# vim:cc=72
# End of file.
