ALL: ..\lib\ioctl.lib

OBJS=dosdevioctl.obj

..\lib\ioctl.lib: $(OBJS)
  wlib -q -fo ..\lib\ioctl.lib $(OBJS)

dosdevioctl.obj: dosdevioctl.asm Cat01.asm Cat02.asm Cat03.asm Cat04.asm Cat05.asm Cat06.asm Cat07.asm Cat08.asm Cat09.asm Cat10.asm Cat11.asm
	@jwasm.exe -q -I..\include $*.asm
