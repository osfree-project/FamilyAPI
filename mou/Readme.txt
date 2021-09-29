Open source replacement of OS/2 Mouse Subsystem
===============================================

Hello. This is part of osFree project. It aims as a open source replacement of OS/2 Mouse Subsystem (MOU).
MOU relatively easy. It consist of Mou* functions which routed to Alternate Mouse Subsystem or Base Mouse
Subsystem.

This subproject includes replacement of original MOU subsystem and some enchancements. osFree OS/2 Mouse subsystem
provides much richer set of MOU APIs comparing to IBM Family API, HX DOS Family API or JdeBP's Family API.

As of Family API v.1.20 it is mainly focused on DOS part of Family API to provide, at first place, dual mode
osFree Command Line Tools.

As side effect osFree Family API provides MOUCALLS.DLL replacement for HX DOS Extender as well as BMSCALLS.DLL
replacement (BMS subproject). Moreover, EMXWRAP, CON3216 and OS2CHAR2 DLLs are provided.

Because of its nature, all MOU API are 16-bit in 1.20 version of package. 

Most probably first release of our Mou subsystem will be as part of osFree Family API 1.20 release.

Files (draft):


