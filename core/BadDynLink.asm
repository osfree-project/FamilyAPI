;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief BadDynLink
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;*/

.8086

		INCLUDE DOS.INC
		INCLUDE	BSEERR.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

BADDYNLINK	PROC	FAR
		END_PROCESS ERROR_BAD_DYNALINK
BADDYNLINK	ENDP

_TEXT		ENDS

		END
