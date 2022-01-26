;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief VioScrUnLock DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:vioscrunlock
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE VIO.INC
		INCLUDE	ROUTE.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@VIOPROLOG	VIOSCRUNLOCK
VIOHANDLE	DW	?
		@VIOSTART	VIOSCRUNLOCK
		@VIOROUTE	VIOSCRUNLOCK, 1, 2
		@VIOEPILOG	VIOSCRUNLOCK

_TEXT		ENDS

		END
