Open source replacement of OS/2 Video Subsystem
===============================================

Hello. This is part of osFree project. It aims as a open source replacement of OS/2 Video Subsystem (VIO).
VIO relatively easy. It consist of Vio* functions which routed to Alternate Video Subsystem or Base Video
Subsystem and late to Global Video Subsystem using VioRoute internal function.

This subproject includes replacement of original VIO subsystem and some enchancements. osFree OS/2 Video subsystem
provides much richer set of VIO APIs comparing to IBM Family API, HX DOS Family API or JdeBP's Family API.

As of Family API v.1.20 it is mainly focused on DOS part of Family API to provide, at first place, dual mode
osFree Command Line Tools.

As side effect osFree Family API provides VIOCALLS.DLL replacement for HX DOS Extender as well as BVSCALLS.DLL
replacement (BVS subproject). Moreover, EMXWRAP, CON3216 and OS2CHAR2 DLLs are provided. Also VFOSSIL driver
is here just for fun, because it is was easy to implement from our codebase with minimal effort.

Because of its nature, all VIO API are 16-bit in 1.20 version of package. 

Also BVHINIT.DLL replacement produced for original OS/2. Because it is hard to replace functions in DOSCALLS.DLL
(in modern OS/2 systems VIO and BVS lives in DOSCALLS.DLL) we provide only replacement versions for old OS/2 systems
like OS/2 1.0 and, may be, more, in future. Just for fun and because it is relatively easy. May be we will provide
path for DOSCALLS.DLL to integrate newer Vio subsystem for OS/2 and related.

For now we don't provide Advanced VIO for PM until FreePM subproject will be started. Most probably first release
of our Vio subsystem will be as part of osFree Family API 1.20 release.

Files (draft):

VIO.LIB	- 16-bit 8086 small memory model library which routes all Vio* calls to VioRoute function.
It imports DosLoadModule and DosQProcAddr. Developer needs to provide its implementations for full functionality.

VIOCALLS.DLL - 16-bit 8086 NE library which can be used as under OS/2 as under HX DOS extender. Requires BVSCALLS.DLL and DOSCALLS.DLL
VIOCALLS.LIB - export library for VIOCALLS.DLL
EMXWRAP.LIB - 32-bit 80386 library. Wrapper around 16-bit Vio and some other functions. Imports Vio*, Kbd*, Mou*, DosMon*.
EMXWRAP.DLL - 32-bit 80386 LX library. Requires VIOCALLS.DLL, MOUCALLS.DLL, KBDCALLS.DLL, MONCALLS.DLL
OS2CHAR2.DLL - wrapper arount EMXWRAP.DLL
CON1632 - wrapper arount EMXWRAP.DLL
BSESUB.H - extended header. By default it uses standard 16-bit library. With extra defines can select EMXWRAP, OS2CHAR2 or CON1632API.
AVSSTUB.C - stub for AVS
AVSDOS.C - DOS version of DosLoadModule and DosQProcAddr stubs for AVS
BVH32.DLL - NE DLL 16-bit to 32-bit BVH wrapper

-------------------------------------------------------------------------------------------------------------------------

Мысли...

Тут возникает раздел. С BVS все ок, его можно просто статически прилинковать и все. А для AVS надо наличие
загрузки DLL. Пробовать поддержку real-mode NE DLL? Тербовать линковать DosLoadModule и подобное? Причем, тут не
обязательно именно NE DLL. Можно и другое. Или предлагать юзеру функии-заглушки и пусть сам решает? Тогда
не очень гибко. С DLL можно видеоподситему грузить через конфиги и прочее. Наверное, давать заглушки и пусть сам решает,
будет AVS жестким перехватчиком или грузить что-то внешнее.

VIOOS2.LIB	- VioRegister/VioDeregister for original OS/2, FAPI 1.20(?) and HX DOS Extender.

Planned
BVSCALLS.LIB - тут думаем, спуститься до BVH или не стоит дальше падать. Или уж сформурировать BVH, а уж ниже делать уже под
каждую систему свое.

Planned BVH - видимо - это последний уровень возможной абстракции для 16-битной части. Один из вариантов, сделать BVHROUTER, который
уже форварит в 32-разрядную версию. Идеальный вариант, ИМХО. Параллельно выстраиваем 32-битный вариант VIO, где от BVH до VIO
32-битная тема. Внешний базовый интерфейс - EMXWRAP. OS2CHAR уже обертка вокруг (для фана и совместимости), возможно и обертка над
EMXWRAP 32-API от Jde. Думаю - да. Нормальное решение.


Обертки
=======

Есть несколько 32-разрядных API. Основной, получивший распространение - это EMXWRAP. Он и взят как базовый для osFree.
Есть еще OS2CHAR2.DLL от IBM и con1632.dll от JdeBP. Мы их тоже сделаем, как обертку поверх EMXWRAP. Это 32-битные версии.
EMXWRAP будет так же предоставляять BVS32 и AVS32. BVS32 будет юзать BVH32.

ДУмаю, что BVH32.DLL будет 16-битным враппером поверх BVH32. Т.е. 16-битны API поддерживаем до уровня BVH, а уж последний BVH будет
оберткой повер 32-битной версии. Это на osFree. Под OS/2 и DOS BVH будут 16-битными. Как и оригинал.
