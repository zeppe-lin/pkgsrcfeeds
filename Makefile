all: help

check-non200:
	@echo "=======> Check feeds.urls for non-200 response codes:"
	@grep -Eiho "https?://[^\"\\'> ]+" ${CURDIR}/feeds.urls | \
		httpx -silent -fc 200 -sc

check-pkgsrc:
	@echo "=======> Check for feeds.urls to pkgsrc congruence:"
	@perl ${CURDIR}/lint

check: check-non200 check-pkgsrc

help:
	@echo "Usage: make [TARGET]"
	@echo ""
	@echo "check           perform the following targets"
	@echo "  check-non200  check feeds.urls for non-200 response codes"
	@echo "  check-pkgsrc  check for feeds.urls to pkgsrc congruence"
	@echo ""

.PHONY: all help
.PHONY: check
.PHONY: check-non200 check-pkgsrc

