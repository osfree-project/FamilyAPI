;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioGetCurPos DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:viogetcurpos
;
;* 0          NO_ERROR 
;* 355        ERROR_VIO_MODE 
;* 436        ERROR_VIO_INVALID_HANDLE 
;* 465        ERROR_VIO_DETACHED
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

@VIOPROC	VIOGETCURPOS, 1, 0, VIOHANDLE DW ?, COLUMN DD ?, ROW DD ?

_TEXT		ENDS
		END
