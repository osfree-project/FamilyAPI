#
# A Makefile for BIND
# (c) osFree project,
# author, date
#

PROJ = loader
TRGT = $(PROJ).lib
DESC = Binded Familty API loader
#defines object file names in format $(p)objname$(e)
srcfiles = $(p)loader$(e) $(p)ginterf$(e) $(p)file$(e) $(p)strings$(e) 
# defines additional options for C compiler
ADD_COPT = -i=$(%WATCOM)$(SEP)h$(SEP)os21x #-p


!include $(%ROOT)tools/mk/libsdos.mk

$(TARGETS): $(OBJS) $(LIBS)
 @$(MAKE) $(MAKEOPT) library=$(TARGETS) library
