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
		INCLUDE MOU.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@MOUPROLOG	MOUSYNCH
FLWAIT	DW	?
		@MOUSTART	MOUSYNCH
; code here
		@MOUEPILOG	MOUSYNCH

_TEXT		ENDS
		END
