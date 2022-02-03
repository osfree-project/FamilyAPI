#echo Building Base Mouse Subsystem
#echo Base Mouse Subsystem build finished

PROJ=bms

OBJS=bmsmain.obj bmsgetnumbuttons.obj bmsgetnummickeys.obj bmsgetdevstatus.obj bmsgetnumqueel.obj bmsreadeventque.obj bmsgetscalefact.obj &
bmsgeteventmask.obj bmssetscalefact.obj bmsseteventmask.obj bmsgethotkey.obj bmssethotkey.obj bmsopen.obj bmsclose.obj bmsgetptrshape.obj &
bmssetptrshape.obj bmsdrawptr.obj bmsremoveptr.obj bmsgetptrpos.obj bmssetptrpos.obj bmsinitreal.obj bmsflushque.obj bmssetdevstatus.obj

EXPORT=BMSMAIN.1 RESIDENT


!include <..\dll.mk>

