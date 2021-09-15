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

�����...

��� ��������� ������. � BVS ��� ��, ��� ����� ������ ���������� ������������ � ���. � ��� AVS ���� �������
�������� DLL. ��������� ��������� real-mode NE DLL? ��������� ��������� DosLoadModule � ��������? ������, ��� ��
����������� ������ NE DLL. ����� � ������. ��� ���������� ����� ������-�������� � ����� ��� ������? �����
�� ����� �����. � DLL ����� �������������� ������� ����� ������� � ������. ��������, ������ �������� � ����� ��� ������,
����� AVS ������� ������������� ��� ������� ���-�� �������.

VIOOS2.LIB	- VioRegister/VioDeregister for original OS/2, FAPI 1.20(?) and HX DOS Extender.

Planned
BVSCALLS.LIB - ��� ������, ���������� �� BVH ��� �� ����� ������ ������. ��� �� �������������� BVH, � �� ���� ������ ��� ���
������ ������� ����.

Planned BVH - ������ - ��� ��������� ������� ��������� ���������� ��� 16-������ �����. ���� �� ���������, ������� BVHROUTER, �������
��� �������� � 32-��������� ������. ��������� �������, ����. ����������� ����������� 32-������ ������� VIO, ��� �� BVH �� VIO
32-������ ����. ������� ������� ��������� - EMXWRAP. OS2CHAR ��� ������� ������ (��� ���� � �������������), �������� � ������� ���
EMXWRAP 32-API �� Jde. ����� - ��. ���������� �������.


�������
=======

���� ��������� 32-��������� API. ��������, ���������� ��������������� - ��� EMXWRAP. �� � ���� ��� ������� ��� osFree.
���� ��� OS2CHAR2.DLL �� IBM � con1632.dll �� JdeBP. �� �� ���� �������, ��� ������� ������ EMXWRAP. ��� 32-������ ������.
EMXWRAP ����� ��� �� �������������� BVS32 � AVS32. BVS32 ����� ����� BVH32.

�����, ��� BVH32.DLL ����� 16-������ ��������� ������ BVH32. �.�. 16-����� API ������������ �� ������ BVH, � �� ��������� BVH �����
�������� ����� 32-������ ������. ��� �� osFree. ��� OS/2 � DOS BVH ����� 16-�������. ��� � ��������.
