#
# A main Makefile for FamilyApp project
# (c) osFree project.
#

# fapi is a library for static linking
# api is a library for dynamic linking
# They must come first because all tools here depends on them.

DIRS = kal kal mem bvs bms bks vio mou kbd fm nls ioctl dos mm loader fapi api

!include $(%ROOT)tools/mk/all.mk
