# VERSION=1.0.0
# Assumes drush and phpcs are installed. Use composer for this.

PHP ?= php
DRUSH ?= drush
PHPCS ?= phpcs

runserver:
	$(PHP) -S 0.0.0.0:8000

migrate:
	$(DRUSH) updb

shell:
	$(DRUSH) core-cli

phpcs:
	$(PHPCS) --config-set default_standard PSR2
	$(PHPCS) ./sites/default/*.php
