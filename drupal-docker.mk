# VERSION=1.0.0

# CHANGES:
# 1.0.0 - 2019-04-29 - Initial setup

##########################################################################################
# How to use this Makefile for local development                                         # 
##########################################################################################
# - Create a new directory in the root of the project called: db-backup                  #
#   IE: ./db-backup                                                                      #
# - Pull down an up-to-date database and place it this folder. This may                  #
#   either be *.sql or *.sql.gz. This database is used to initialize the                 #
#   database container.                                                                  #
# - Pull down an up-to-date files folder, and place it in './sites/default',             #
#   like so: './sites/default/files'                                                     #
# - Copy './sites/default/local_settings.php.sample' to                                  #
#   './sites/default/local_settings.php'       											 #
# - Run 'make docker-compose'                                                            #
# - View the site at https://localhost:8080                                              #
##########################################################################################
# - What different commands do:                                                          #
#   drush-shell:  Drops you into a shell of a container with drush access to the code    #
#                 base. You can update Drupal core and modules from this shell.          #
#   mysql-shell:  Drops you into the shell for the mysql container. You can log in to    #
#                 mysql with the credentials in the docker-compose.yml                   # 
#   apache-shell: Drops you into shell of the Drupal web container, running Apache.      #
#   docker-clean: Stops any containers that may still be running, and deletes them. Use  #
#                 this if you need to refresh the database, as the mysql container will  #
#                 persist.                                                               #
##########################################################################################

export PROJECT DC_MYSQL_USER DC_MYSQL_PASSWORD

docker-test: check-env
	docker-compose config

docker-compose: check-env
	docker-compose up

drush-shell: check-env
	docker-compose run --entrypoint /bin/bash drush

mysql-shell: check-env
	docker exec -it $(PROJECT)-mysql /bin/bash

apache-shell: check-env
	docker exec -it $(PROJECT)-web /bin/bash

docker-clean:
	-docker stop $(PROJECT)-web
	-docker stop $(PROJECT)-mysql
	-docker stop $(PROJECT)-drush
	-docker rm $(PROJECT)-drush
	-docker rm $(PROJECT)-mysql
	-docker rm $(PROJECT)-web

.PHONY: check-env
check-env:
ifndef PROJECT
	$(error Error: PROJECT is undefined. Set PROJECT in Makefile)
endif
ifndef DC_MYSQL_USER
	$(error Error: DC_MYSQL_USER is undefined. Set DC_MYSQL_USER in Makefile)
endif
ifndef DC_MYSQL_PASSWORD
	$(error Error: DC_MYSQL_PASSWORD is undefined. Set DC_MYSQL_PASSWORD in Makefile)
endif
