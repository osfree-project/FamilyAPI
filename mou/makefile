ALL: ..\lib\mou.lib

OBJS=mouroute.obj mougetnumbuttons.obj mougetnummickeys.obj mougetdevstatus.obj mougetnumqueel.obj moureadeventque.obj mougetscalefact.obj mougeteventmask.obj &
mousetscalefact.obj mouseteventmask.obj mougethotkey.obj mousethotkey.obj mouopen.obj mouclose.obj mougetptrshape.obj mousetptrshape.obj &
moudrawptr.obj mouremoveptr.obj mougetptrpos.obj mousetptrpos.obj mouinitreal.obj mouflushque.obj mousetdevstatus.obj

..\lib\mou.lib: $(OBJS)
  wlib -q -fo ..\lib\mou.lib $(OBJS)

.asm.obj: .AUTODEPEND
	@jwasm.exe -q -I..\include $*.asm

