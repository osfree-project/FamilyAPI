;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosGetPID DOS wrapper
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
		INCLUDE	GLOBALVARS.INC

EXTERN		DOSGETINFOSEG: PROC

PIDINFO struc
  pidi_pid       dw  ? ;current process' process ID
  pidi_tid       dw  ? ;current process' thread ID
  pidi_pidParent dw  ? ;process ID of the parent
PIDINFO ends

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSGETPID
PPID		DD	?
@LOCALW		GLOBALSEG
@LOCALW		LOCALSEG
		@START	DOSGETPID
		PUSH	SS
		LEA	AX, GLOBALSEG
		PUSH	AX
		PUSH	SS
		LEA	AX, LOCALSEG
		PUSH	AX
		CALL	DOSGETINFOSEG
		MOV	AX, LOCALSEG
		MOV	DS, AX
		LES	BX,[DS:BP].ARGS.PPID
		MOV	AX, [DS:lis_pidCurrent]
		MOV	[ES:BX].PIDINFO.pidi_pid, AX
		MOV	AX, [DS:lis_tidCurrent]
		MOV	[ES:BX].PIDINFO.pidi_tid, AX
		MOV	AX, [DS:lis_pidParent]
		MOV	[ES:BX].PIDINFO.pidi_pidParent, AX
		@EPILOG	DOSGETPID
_TEXT	ends

	end
