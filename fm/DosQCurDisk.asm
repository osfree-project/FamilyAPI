;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosQCurDisk DOS wrapper
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

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSQCURDISK
DIRPATH		DD	?
DRIVENUMBER	DD	?
		@START	DOSQCURDISK

		CURRENT_DISK
		CBW
		INC	AX
		LDS	SI,[DS:BP].ARGS.DIRPATH
		MOV	[SI],AX
		XOR	AX,AX
EXIT:
		@EPILOG	DOSQCURDISK

_TEXT		ENDS

		END
