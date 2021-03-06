# -*- tab-width: 4 -*- ;; Emacs
# vi: set noexpandtab  :: Vi/ViM
# vi: set syntax=make  ::
################################################################################
############################### GLOBAL VARIABLES ###############################
################################################################################

PKGCENTER = ..

#
# Repository Specifics
#
DIRS = $$( $(FIND) . -mindepth 4 -maxdepth 4 -name Makefile \
               | $(SED) -e 's:/Makefile$$::' )

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
	@$(CAT) $(PKGCENTER)/freebsd/Mk/HELP_FREEBSD

usage:
	@$(CAT) $(PKGCENTER)/freebsd/Mk/USAGE_FREEBSD

#
# Recursive Targets
#

.PHONY: all_freebsd stage_freebsd forcestage_freebsd
.PHONY: clean_freebsd distclean_freebsd
.PHONY: pull_freebsd commit_freebsd
.PHONY: tag_freebsd forcetag_freebsd taglist_freebsd

all_freebsd stage_freebsd forcestage_freebsd clean_freebsd \
distclean_freebsd pull_freebsd commit_freebsd tag_freebsd forcetag_freebsd \
taglist_freebsd:
	@export CONTINUE=; \
	 ( set -- $(MFLAGS); \
	   while getopts k flag; do [ "$$flag" = "k" ] && exit; done; \
	   false; \
	 ) && export CONTINUE=1; \
	 for dir in $(DIRS); do \
	     target=$(@); target=$${target%_freebsd}; \
	     echo "--> Making $$target in $$dir"; \
	     ( cd "$$dir" && \
	       $(MAKE) $${MAKELEVEL:+--no-print-directory} $(MFLAGS) $$target \
	     ) || [ "$$CONTINUE" ] || exit 1; \
	 done

#
# Maintenance Targets
#

.PHONY: update

update:
	@: update not implemented for FreeBSD

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
# $Copyright: 1999-2017 Devin Teske. All rights reserved. $
# $FrauBSD: pkgcenter-newR/freebsd/Makefile 2019-11-19 00:43:57 -0800 freebsdfrau $
#
################################################################################
