;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief MouSynch
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS and OS/2
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC

EXTERN	PreMOUSYNCH: PROC
EXTERN	PostMOUSYNCH: PROC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		PUBLIC	MOUSYNCH
MOUSYNCH	PROC FAR
ARGS	STRUC
FLWAIT	DW	?
ARGS	ENDS
		CALL	PreMouSynch
; code here
		CALL	PostMouSynch
		XOR		AX, AX
		RETF	2
MOUSYNCH	ENDP

_TEXT		ENDS
		END
