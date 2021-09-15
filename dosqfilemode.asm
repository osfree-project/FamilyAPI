;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosQFileMode DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   @todo add dos version check
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSQFILEMODE
FILENAME		DD	?
CURRENTATTRIBUTE	DD	?
RESERVED		DD	?
		@START	DOSQFILEMODE

		CHANGE_MODE [DS:BP].ARGS.FILENAME, 0, 0

		LDS	SI,[DS:BP].ARGS.CURRENTATTRIBUTE		;PTR TO RETURN STATUS
		MOV	WORD PTR [SI],CX	;SHOVE IT IN THERE
		JC	@1F			;ERROR?
		XOR	AX,AX			;RC = 0
		JMP	@2F
@1F:
		GET_ERROR
@2F:
		@EPILOG	DOSQFILEMODE

_TEXT		ENDS

		END

