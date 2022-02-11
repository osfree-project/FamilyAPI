;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief Family API implementation
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


@VIOROUTE	MACRO	FUNC, MASK, OFF
			MOV	AX, @CATSTR(FC_, FUNC)
			PUSH	AX
			MOV		AX, _DATA
			MOV		ES, AX
			MOV	AX, WORD PTR ES:@CATSTR(VIOFUNCTIONMASK, MASK)+OFF
			IF	OFF EQ 0
			AND	AX, LOWWORD @CATSTR(VR_, FUNC)
			CMP	AX, LOWWORD @CATSTR(VR_, FUNC)
			ELSE
			AND	AX, HIGHWORD @CATSTR(VR_, FUNC)
			CMP	AX, HIGHWORD @CATSTR(VR_, FUNC)
			ENDIF
			CALL    VIOROUTE
			ENDM

@VIOPROC	MACRO	NAME, MASK, OFF, ARGS: VARARG

		@VIOPROLOG	NAME
		FOR ARG, <ARGS>
			ARG
		ENDM
		@VIOSTART	NAME
		@VIOROUTE	NAME, MASK, OFF
		@VIOEPILOG	NAME

			ENDM
