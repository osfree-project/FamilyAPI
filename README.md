# Family API

Shared API for DOS and OS/2 to produce binary dual mode applications which can be run without recompilation

[![Build status](https://github.com/prokushev/FamilyAPI/actions/workflows/build.yml/badge.svg)](https://github.com/prokushev/FamilyAPI/actions?query=workflow%3Abuild.yml)

At the present time we have:

- VIOCALLS at level of OS/2 1.0 (both real and protected mode DOS/OS2, except Register/Deregister)
- MOUCALLS at level of OS/2 1.0 (both real and protected mode DOS/OS2, except Register/Deregister)
- KBDCALLS at level of OS/2 1.0 (both real and protected mode DOS/OS2, except Register/Deregister)
- BVSCALLS at level of OS/2 1.0 (both real and protected mode DOS)
- BMSCALLS at level of OS/2 1.0 (both real and protected mode DOS)
- BKSCALLS at level of OS/2 1.0 (both real and protected mode DOS)
- DOSCALLS in progress

# Implementation design

osFree Family API consist of 2 levels:

KAL - is a Kernel Abstraction Layer which implements kernel specific functions.
OS/2 API layer - kernel independed part which is same as in DOS, OS/2 or other kernel.

At the current design only core DOSCALLS functions uses KAL functions.

# Kernel Abstration Layer functions list

(This is draft, still most functions not in KAL, but in corresponding DLLs)

KalDevIOCtl - is a most complex function. It is implements DosDevIOCtl background.
Most of I/O Subsystem functions (Kbd, Vio, Mou, Bms, Bvs, Bks) uses DosDevIOCtl to
provide implement corresponding functions. This way I/O Subsystems shares same code
in DOS and OS/2.

KalGetInfoSeg - provides access to Global Info Segment and Local Info Segment.
DOSCALLS functions uses GIS or LIS obtained via DosGetInfoSeg, if it possible, to
provide information.

KalQProcStatus - another generic interface which allow to access internal structures.
http://svn.netlabs.org/repos/fm2/tags/FM2-3_15_00/dll/procstat.h
http://www.edm2.com/index.php/DQPS.H
http://archive.retro.co.za/CDROMs/DrDobbs/CD%20Release%2012/articles/1994/9408/9408n/9408n.htm#00b2_0048

todo Kal* - file manager functions
todo Kal* - memory manager functions

http://osfree.org/doku/en:docs:fapi
