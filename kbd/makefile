#echo Building Keyboard Subsystem
#echo Keyboard Subsystem build finished

PROJ=kbd

OBJS=kbdroute.obj debug.obj

EXPORT=  KBDSETCUSTXT.1 RESIDENT,     &
#           KBDINIT.2 RESIDENT,   &
           KBDGETCP.3 RESIDENT,         &
           KBDCHARIN.4 RESIDENT,        &
           KBDSETCP.5 RESIDENT,         &
#           KBDLOADINSTANCE.6 RESIDENT,  &
#           KBDSYNCH.7 RESIDENT,         &
#          KBDREGISTER.8 RESIDENT,      &
           KBDSTRINGIN.9 RESIDENT,      &
           KBDGETSTATUS.10 RESIDENT,    &
           KBDSETSTATUS.11 RESIDENT,    &
           KBDGETFOCUS.12 RESIDENT,     &
           KBDFLUSHBUFFER.13 RESIDENT,  &
           KBDXLATE.14 RESIDENT,        &
#           KBDSWITCHFGND.15 RESIDENT,   &
#           KBDSHELLINIT.16 RESIDENT,    &
           KBDCLOSE.17 RESIDENT,        &
           KBDFREEFOCUS.18 RESIDENT,    &
#           KBDFREE.19 RESIDENT,         &
#           KBDDEREGISTER.20 RESIDENT,   &
#           KBDSETFGND.21 RESIDENT,      &
           KBDPEEK.22 RESIDENT,         &
           KBDOPEN.23 RESIDENT,         &
           KBDGETHWID.24 RESIDENT
#           KBDSETHWID.25 RESIDENT

IMPORT=bkscalls.lib import VIOWRTTTY VIOCALLS.19

!include <..\dll.mk>

