TEMPLATE = subdirs

SUBDIRS += demo fluid imports

imports.depends = fluid
demo.depends = imports
