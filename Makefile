# -*- tab-width: 4 -*- ;; Emacs
# vi: set noexpandtab  :: Vi/ViM
# vi: set syntax=make  ::
################################################################################
############################### GLOBAL VARIABLES ###############################
################################################################################

PKGCENTER = .

SUBDIRS = freebsd redhat

#
# Repository Specifics
#
DIRS = $$( ( $(FIND) freebsd -mindepth 4 -maxdepth 4 -name Makefile; \
             $(FIND) redhat  -mindepth 5 -maxdepth 5 -name Makefile; \
           ) | $(SED) -e 's:/Makefile$$::' )

#
# Standard utility pathnames
#
CAT  = cat
FIND = find
GIT  = git
SED  = sed

################################################################################
################################ BUILD  TARGETS ################################
################################################################################

#
# Generic Targets
#

.PHONY: all help targets usage

all help targets:
	@$(CAT) $(PKGCENTER)/Mk/HELP

usage:
	@$(CAT) $(PKGCENTER)/Mk/USAGE

#
# Recursive Targets
#

.PHONY: all_all stage_all forcestage_all clean_all distclean_all
.PHONY: pull_all commit_all tag_all forcetag_all

all_all stage_all forcestage_all clean_all distclean_all \
pull_all commit_all tag_all forcetag_all:
	@export CONTINUE=; \
	 ( set -- $(MFLAGS); \
	   while getopts k flag; do [ "$$flag" = "k" ] && exit; done; \
	   false; \
	 ) && export CONTINUE=1; \
	 for dir in $(DIRS); do \
	     target=$(@); target=$${target%_all}; \
	     echo "--> Making $$target in $$dir"; \
	     ( cd "$$dir" && \
	       $(MAKE) $${MAKELEVEL:+--no-print-directory} $(MFLAGS) $$target \
	     ) || [ "$$CONTINUE" ] || exit 1; \
	 done

#
# Maintenance Targets
#

.PHONY: update_all

update_all:
	@export CONTINUE=; \
	 ( set -- $(MFLAGS); \
	   while getopts k flag; do [ "$$flag" = "k" ] && exit; done; \
	   false; \
	 ) && export CONTINUE=1; \
	 for dir in $(SUBDIRS); do \
	     [ -d "$$dir" ] || continue; \
	     target=$(@); target=$${target%_all}; \
	     echo "--> Making $$target in $$dir"; \
	     ( cd "$$dir" && \
	       $(MAKE) $${MAKELEVEL:+--no-print-directory} $(MFLAGS) $$target \
	     ) || [ "$$CONTINUE" ] || exit 1; \
	 done

#
# Git Addition Targets
#

.PHONY: import commit pull

import:
	@$(PKGCENTER)/Mk/git_import

commit:
	@$(GIT) commit

pull:
	@$(GIT) pull

################################################################################
# END
################################################################################
#
# $Copyright: 1999-2019 Devin Teske. All rights reserved. $
# $FrauBSD: pkgcenter-newR/Makefile 2019-11-19 00:34:58 -0800 freebsdfrau $
#
################################################################################
