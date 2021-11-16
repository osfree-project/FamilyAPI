ALL: ..\lib\fm.lib

OBJS=dosbufreset.obj doschdir.obj dosmkdir.obj dosclose.obj dosduphandle.obj dosfirst.obj dosfilelocks.obj dosmove.obj dosnewsize.obj dosopen.obj dosqcurdir.obj &
dosqcurdisk.obj dosqfileinfo.obj dosqfsinfo.obj dosrmdir.obj dosqverify.obj dosqfilemode.obj dosqhandtype.obj dosread.obj doschgfileptr.obj dossetfileinfo.obj &
dossetfilemode.obj dosselectdisk.obj dossetverify.obj doswrite.obj dosdelete.obj dossetmaxfh.obj

..\lib\fm.lib: $(OBJS)
  wlib -q -fo ..\lib\fm.lib $(OBJS)

.asm.obj: .AUTODEPEND
	@jwasm.exe -q -I..\include $*.asm

