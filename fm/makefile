#cho Building file manager subsystem
#echo File manager sybsystem build finished

ALL: ..\lib\fm.lib

OBJS=dosbufreset.obj doschdir.obj dosmkdir.obj dosclose.obj dosduphandle.obj dosfirst.obj dosfilelocks.obj dosmove.obj dosnewsize.obj dosopen.obj dosqcurdir.obj &
dosqcurdisk.obj dosqfileinfo.obj dosqfsinfo.obj dosrmdir.obj dosqverify.obj dosqfilemode.obj dosqhandtype.obj dosread.obj doschgfileptr.obj dossetfileinfo.obj &
dossetfilemode.obj dosselectdisk.obj dossetverify.obj doswrite.obj dosdelete.obj dossetmaxfh.obj

..\lib\fm.lib: $(OBJS)
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\include $*.asm

clean: .SYMBOLIC
	if exist *.obj del *.obj
	if exist *.err del *.err
	if exist *.lst del *.lst
	if exist *.map del *.map
