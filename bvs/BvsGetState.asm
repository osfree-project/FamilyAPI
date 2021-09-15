;/*!
;   @file
;
;   @brief BvsGetState DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;
; @todo add params checks
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE BSEERR.INC


_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

VIOPALSTATE struc
  viopal_cb               dw ? ;Length of this structure in bytes
  viopal_type             dw ? ;Request type=0 get palette registers
  viopal_iFirst           dw ? ;First palette register to return
  viopal_acolor  dw 1  dup (?) ;Color value palette register
VIOPALSTATE ends

VIOOVERSCAN struc
  vioos_cb                dw ? ;Length of this structure
  vioos_type              dw ? ;Request type=1 get overscan (border) color
  vioos_color             dw ? ;Color value
VIOOVERSCAN ends

VIOINTENSITY struc
  vioint_cb               dw ? ;Length of this structure
  vioint_type             dw ? ;Request type=2 get blink/background
                              ; intensity switch
  vioint_fs               dw ? ;Value of blink/background switch
VIOINTENSITY ends

VIOCOLORREG struc
  viocreg_cb              dw ? ;
  viocreg_type            dw ? ;
  viocreg_firstcolorreg   dw ? ;
  viocreg_numcolorregs    dw ? ;
  viocreg_colorregaddr    dd ? ;
VIOCOLORREG ends

VIOSETULINELOC struc
  viouline_cb             dw ? ;
  viouline_type           dw ? ;
  viouline_scanline       dw ? ;
VIOSETULINELOC ends

VIOSETTARGET struc
  viosett_cb               dw ? ;
  viosett_type             dw ? ;
  viosett_defaultalgorithm dw ? ;
VIOSETTARGET    ends

		@BVSPROLOG	BVSGETSTATE
VIOHANDLE	DW	?		;VIDEO HANDLE
RequestBlock	DD	?		;
		@BVSSTART	BVSGETSTATE

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		XOR	AX,AX
EXIT:
		@BVSEPILOG	BVSGETSTATE

_TEXT		ends
		end
