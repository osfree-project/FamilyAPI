;/*!
;   @file
;
;   @brief BvsGetPhysBuf DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*/

.8086
		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16


		@BVSPROLOG	BVSGETBUF
VIOHANDLE	DW	?		;
SLength		DD	?		;
LVBPtr		DD	?		;
		@BVSSTART	BVSGETBUF

		XOR     AX,AX                    ; ALL IS OK

EXIT:
		@BVSEPILOG	BVSGETBUF
_TEXT		ENDS
		END

