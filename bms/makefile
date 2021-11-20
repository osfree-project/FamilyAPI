ALL: ..\lib\bms.lib

OBJS=bmsmain.obj bmsgetnumbuttons.obj bmsgetnummickeys.obj bmsgetdevstatus.obj bmsgetnumqueel.obj bmsreadeventque.obj bmsgetscalefact.obj &
bmsgeteventmask.obj bmssetscalefact.obj bmsseteventmask.obj bmsgethotkey.obj bmssethotkey.obj bmsopen.obj bmsclose.obj bmsgetptrshape.obj &
bmssetptrshape.obj bmsdrawptr.obj bmsremoveptr.obj bmsgetptrpos.obj bmssetptrpos.obj bmsinitreal.obj bmsflushque.obj bmssetdevstatus.obj

..\lib\bms.lib: $(OBJS)
	@echo LIB $@
	@wlib -q -fo $@ $(OBJS)

.asm.obj: .AUTODEPEND
	@echo ASM $<
	@jwasm.exe -q -I..\include $*.asm

