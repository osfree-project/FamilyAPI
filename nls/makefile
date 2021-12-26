#echo Building DOS subsystem
#echo DOS subsystem build finished

PROJ=nls

ALL: ../lib/$(PROJ).lib

OBJS=dosgetmessage.obj doscasemap.obj dossetctrycode.obj dosgetcp.obj dossetcp.obj dosputmessage.obj dosputmessage.obj dosinsmessage.obj dosgetctryinfo.obj dosgetdbcsev.obj 

../lib/$(PROJ).lib:  $(OBJS) 
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -Fl -q -I../include $*.asm

clean: .SYMBOLIC
	if exist *.obj del *.obj
	if exist *.err del *.err
	if exist *.lst del *.lst
	if exist *.map del *.map
