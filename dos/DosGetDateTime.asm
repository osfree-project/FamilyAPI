;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosGetDateTime DOS wrapper
;
;   (c) osFree Project 2018, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   @todo Use DATETIMES structure instead of offset usage
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

DATETIMES struct
bHour		db ?	;+0
bMinute		db ?
bSeconds	db ?
bcSecs		db ?
bDay		db ?	;+4
bMonth		db ?
wYear		dw ?
wZone		dw ?	;+8 time zone (minutes GMT, -1 == undefined)
bDayOfWeek  db ?	;+10
DATETIMES ends

		@PROLOG	DOSGETDATETIME
DATETIME	DD	?
		@START	DOSGETDATETIME
		LDS	SI,[DS:BP].ARGS.DATETIME
		GET_TIME
		MOV	[SI+0],CH
		MOV	[SI+1],CL
		MOV	[SI+2],DH
		MOV	[SI+3],DL
		GET_DATE
		MOV	[SI+4],DL
		MOV	[SI+5],DH
		MOV	[SI+6],CX
		MOV	WORD PTR [SI+8],-1	;NO TIME ZONE SET
		MOV	[SI+0AH],AL
		XOR	AX,AX
		@EPILOG	DOSGETDATETIME

_TEXT		ENDS

		END
