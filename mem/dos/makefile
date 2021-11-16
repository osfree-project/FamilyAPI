ALL: ..\..\lib\mem.lib

..\..\lib\mem.lib: 
  wlib -q -fo ..\..\lib\mem.lib ..\..\lib\mem16.lib

.asm.obj: .AUTODEPEND
	@jwasm.exe -q -I..\..\..\include $*.asm

