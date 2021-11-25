#echo Building Mouse subsystem
#echo Mouse subsystem build finished

PROJ=mou

OBJS=mouroute.obj mougetnumbuttons.obj mougetnummickeys.obj mougetdevstatus.obj mougetnumqueel.obj moureadeventque.obj mougetscalefact.obj mougeteventmask.obj &
mousetscalefact.obj mouseteventmask.obj mougethotkey.obj mousethotkey.obj mouopen.obj mouclose.obj mougetptrshape.obj mousetptrshape.obj &
moudrawptr.obj mouremoveptr.obj mougetptrpos.obj mousetptrpos.obj mouinitreal.obj mouflushque.obj mousetdevstatus.obj

EXPORT=MOUGETPTRSHAPE.1 RESIDENT,    &
          MOUSETPTRSHAPE.2 RESIDENT,    &
          MOUGETNUMMICKEYS.3 RESIDENT,  &
          MOUGETHOTKEY.4 RESIDENT,      &
#          MOUSHELLINIT.5 RESIDENT,      &
          MOUGETSCALEFACT.6 RESIDENT,   &
          MOUFLUSHQUE.7 RESIDENT,       &
          MOUGETNUMBUTTONS.8 RESIDENT,  &
          MOUCLOSE.9 RESIDENT,          &
          MOUSETHOTKEY.10 RESIDENT,     &
          MOUSETSCALEFACT.11 RESIDENT,  &
          MOUGETNUMQUEEL.13 RESIDENT,   &
#         MOUDEREGISTER.14 RESIDENT,    &
          MOUGETEVENTMASK.15 RESIDENT,  &
          MOUSETEVENTMASK.16 RESIDENT,  &
          MOUOPEN.17 RESIDENT,          &
          MOUREMOVEPTR.18 RESIDENT,     &
          MOUGETPTRPOS.19 RESIDENT,     &
          MOUREADEVENTQUE.20 RESIDENT,  &
          MOUSETPTRPOS.21 RESIDENT,     &
          MOUGETDEVSTATUS.22 RESIDENT,  &
          MOUSETDEVSTATUS.25 RESIDENT,  &
          MOUDRAWPTR.26 RESIDENT,       &
          MOUINITREAL.27 RESIDENT

#          MOUSYNCH.23 RESIDENT,         &
#          MOUREGISTER.24 RESIDENT,      &
#          MOUGETTHRESHOLD.29 RESIDENT,  &
#          MOUSETTHRESHOLD.30 RESIDENT

IMPORT=bmscalls.lib 

!include <..\dll.mk>

