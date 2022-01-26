;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouReadEventQue router
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:moureadeventque
;
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE MOU.INC

EXTERN	PreMouReadEventQue: PROC
EXTERN	PostMouReadEventQue: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUREADEVENTQUE
MOUHANDLE	DW	?		;MOUSE HANDLE
READTYPE	DD	?		;
BUFFER		DD	?		;
		@MOUSTART	MOUREADEVENTQUE
		CALL	PreMouReadEventQue
		@MOUROUTE	MOUREADEVENTQUE, 0
		CALL	PostMouReadEventQue
		@MOUEPILOG	MOUREADEVENTQUE

_TEXT		ENDS
		END
