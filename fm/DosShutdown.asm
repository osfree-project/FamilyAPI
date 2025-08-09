;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosShutdown DOS wrapper
;
;   (c) osFree Project 2025, <http://www.osFree.org>
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

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

;USHORT APIENTRY DosShutdown(ULONG);

		@PROLOG	DOSSHUTDOWN
		@START	DOSSHUTDOWN
		XOR	AX,AX
EXIT:
		@EPILOG	DOSSHUTDOWN

_TEXT		ENDS

		END
