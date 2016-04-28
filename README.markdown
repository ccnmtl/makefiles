CTL standard makefiles

Collects them all in one place.

To use, copy the relevant files into your project and add a master
`Makefile` that looks something like:


    APP=myapp
    
    JS_FILES=media/js/src/ media/js/tests
    MAX_COMPLEXITY=7
    
    all: jenkins
    
    include *.mk

The key aspects being:

* define whatever required and optional global variables are
  expected.
* explicitly set the `all` target. Otherwise it will default to the
  first target it finds, which will depend on the order of the file
  includes which is not ideal.
* include all the `.mk` files
* if you want to override any targets from those makefiles, define
  those new targets after the include line
* if you want to add new targets that are project specific, consider
  making a new `.mk` file for them
* makefiles are explicitly versioned so we can keep track of them and
  automatically update them across projects
* if you've included the `make.mk` file, you can do `make
  update_makefiles` and it will update every `.mk` file in your app to
  the version that is current in this repo.

## Guidelines for writing make targets

* parameterize everything you can, make as few assumptions about the
  code as you can get away with.
* use the `?=` operator to define variables in the `.mk` that can be
  overridden in the top-level `Makefile` or on the commandline
* if you change something, bump the `VERSION` in the comment on the
  first line as appropriate (semver rules)
  * update this README with documentation of variables required below

## Expected variables

### django.mk

Required:

* `APP` to specify you django app

Optional:

* `VE`, virtualenv directory, defaults to `./ve`
* `MANAGE`, manage.py command, defaults to `./manage.py`
* `FLAKE8`, flake8 command, default `$(VE)/bin/flake8`
* `REQUIREMENTS`, location of requirements.txt file, `requirements.txt`
* `SYS_PYTHON`, system python, default `python`
* `PIP`, pip command, default `$(VE)/bin/pip`
* `PY_SENTINAL`, python sentinal location, default `$(VE)/sentinal`
* `PYPI_URL`, pypi mirror url, default `https://pypi.ccnmtl.columbia.edu/`
* `WHEEL_VERSION`, version of python wheel library to install, default `0.24.0`
* `VIRTUALENV`, location of embedded virtualenv.py, default `virtualenv.py`
* `SUPPORT_DIR`, directory with support librarires, default `requirements/virtualenv_support/`
* `MAX_COMPLEXITY`, flake8 max complexity, default 10
* `INTERFACE`, runserver interface, default `localhost`
* `RUNSERVER_PORT`, runserver port, default `8000`
* `PY_DIRS`, directories with python code (to flake8), default `$(APP)`

### docker.mk

Required:

* `APP` to specify you django app. same as with `django.mk`

Optional:

* `WHEELHOUSE`, directory to stash `.whl` files, default `wheelhouse`
* `ORG`, docker hub organization, default `ccnmtl`
* `BUILDER_IMAGE`, django builder image to use, default `ccnmtl/django.build`

### hugo.mk

Optional:

* `HUGO`, path to hugo binary, default `/usr/local/bin/hugo`
* `S3CMD`, s3cmd, default `s3cmd`
* `PUBLIC`, location of hugo's publish directory, default `public`
* `DRAFT_FLAGS`, commandline flags for draft building mode, default `--buildDrafts --verboseLog=true -v`
* `PROD_FLAGS`, hugo flags to use for production publish step, default `-s .`
* `S3_FLAGS`, flags to use for s3cmd publish step, default `--acl-public --delete-removed --no-progress --no-mime-magic --guess-mime-type`
* `INTERMEDIATE_STEPS`, commands to run between hugo publish and s3
  publish steps (eg, json/lunr.js tweaks), default `echo nothing`

### js.mk

Optional:

* `JS_FILES`, where to look for jscs/jshint, defaults to `media/js`
* `NODE_MODULES`, node_modules dir, default `./node_modules`
* `JS_SENTINAL`, location of the js sentinal file, default `$(NODE_MODULES)/sentinal`
* `JSHINT`, jshint command, default `$(NODE_MODULES)/jshint/bin/jshint`
* `JSCS`, jscs command, default `$(NODE_MODULES)/jscs/bin/jscs`

### make.mk

Optional:

* `GITHUB_BASE`, where to look for new versions, default https://raw.githubusercontent.com/ccnmtl/makefiles/master/
* `WGET`, wget binary, default `wget`
* `WGET_FLAGS`, flags for wget command, default `-O`
