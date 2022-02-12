;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosDevIOCtl2 DOS wrapper
;
;   (c) osFree Project 2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:dosdevioctl2
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE	BSEERR.INC
		INCLUDE	BSEDOS.INC


_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSDEVIOCTL2
DevHandle	DW	?
Category	DW	?
Function	DW	?
ParmListLength	DW	?
ParmList	DD	?
DataLength	DW	?
Data		DD	?
		@START	DOSDEVIOCTL2

		@DosDevIOCtl	[DS:BP].ARGS.DATA, [DS:BP].ARGS.PARMLIST, [DS:BP].ARGS.FUNCTION, [DS:BP].ARGS.CATEGORY, [DS:BP].ARGS.DEVHANDLE

		@EPILOG	DOSDEVIOCTL2

_TEXT		ENDS

		END
