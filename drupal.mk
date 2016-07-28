# VERSION=1.0.0
# Assumes drush and phpcs are installed. Use composer for this.

DRUSH ?= drush
PHPCS ?= phpcs

runserver:
	$(DRUSH) runserver

migrate:
	$(DRUSH) updb

shell:
	$(DRUSH) core-cli

phpcs:
	$(PHPCS) --config-set default_standard PSR2
	$(PHPCS) ./sites/default/*.php
