ALL: ..\lib\ioctl.lib

OBJS=dosdevioctl.obj

..\lib\ioctl.lib: $(OBJS)
  wlib -q -fo ..\lib\ioctl.lib $(OBJS)

.asm.obj:
	@jwasm.exe -q -I..\include $*.asm

