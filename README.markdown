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

## Guidelines for writing make targets

* parameterize everything you can, make as few assumptions about the
  code as you can get away with.
* use the `?=` operator to define variables in the `.mk` that can be
  overridden in the top-level `Makefile` or on the commandline
