;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief Family API implementation
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



@KBDROUTE	MACRO	FUNC
			MOV	AX, @CATSTR(FC_, FUNC)
			PUSH	AX
			MOV	AX, _DATA
			MOV	ES, AX
			MOV	AX, WORD PTR ES:KBDFUNCTIONMASK
			AND	AX, LOWWORD @CATSTR(KR_, FUNC)
			CMP	AX, LOWWORD @CATSTR(KR_, FUNC)
			CALL    KBDROUTE
			ENDM

@KBDPROC	MACRO	NAME, ARGS: VARARG

		@KBDPROLOG	NAME
		FOR ARG, <ARGS>
			ARG
		ENDM
		@KBDSTART	NAME
		CALL	@CATSTR(Pre, NAME)
		@KBDROUTE	NAME
		CALL	@CATSTR(Post, NAME)
		@KBDEPILOG	NAME

			ENDM

