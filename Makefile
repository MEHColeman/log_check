.PHONY: secure
secure:
	-bundle-audit check --update

.PHONY: quality
quality:
	-bundle exec rspec
	-rubycritic
	-open 'coverage/index.hmtl'

.PHONY: fast
fast:
	-fasterer

.PHONY: all
all: secure fast quality
