all: help

check-non200:
	@echo "=======> Check feeds.urls for non-200 response codes:"
	@grep -Eiho "https?://[^\"\\'> ]+" ${CURDIR}/feeds.urls | \
		httpx -silent -fc 200 -sc

check-pkgsrc:
	@echo "=======> Check for feeds.urls to pkgsrc congruence:"
	@perl ${CURDIR}/lint

check: check-non200 check-pkgsrc

opml:
	newsboat -u ${CURDIR}/feeds.urls -e > ${CURDIR}/feeds.opml

help:
	@echo "Usage: make [TARGET]"
	@echo ""
	@echo "TARGETS:"
	@echo "  check           perform the following targets"
	@echo "    check-non200  check feeds.urls for non-200 response code"
	@echo "    check-pkgsrc  check for feeds.urls to pkgsrc congruence"
	@echo "  opml            convert newsboat urls file to opml"
	@echo ""

.PHONY: all help
.PHONY: check
.PHONY: check-non200 check-pkgsrc

