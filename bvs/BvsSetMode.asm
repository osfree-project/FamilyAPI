;/*!
;   @file
;
;   @brief BvsSetMode DOS wrapper
;
;   (c) osFree Project 2021, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;* 0          NO_ERROR 
;* 355        ERROR_VIO_MODE 
;* 358        ERROR_VIO_ROW 
;* 359        ERROR_VIO_COL 
;* 436        ERROR_VIO_INVALID_HANDLE 
;* 465        ERROR_VIO_DETACHED
;
;*/

.8086
		; Helpers
		INCLUDE	HELPERS.INC
		INCLUDE DOS.INC
		INCLUDE BSEERR.INC

VIOMODEINFO struc
  viomi_cb             dw ? ;Length of the entire data structure
  viomi_fbType         db ? ;Bit mask of mode being set
  viomi_color          db ? ;Number of colors (power of 2)
  viomi_col            dw ? ;Number of text columns
  viomi_row            dw ? ;Number of text rows
  viomi_hres           dw ? ;Horizontal resolution
  viomi_vres           dw ? ;Vertical resolution
  viomi_fmt_ID         db ? ;Attribute format
  viomi_attrib         db ? ;Number of attributes
  viomi_buf_addr       dd ? ;
  viomi_buf_length     dd ? ;
  viomi_full_length    dd ? ;
  viomi_partial_length dd ? ;
  viomi_ext_data_addr  dd ? ;
VIOMODEINFO ends

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@BVSPROLOG	BVSSETMODE
VIOHANDLE	DW	?		;Video handle
MODEDATA	DD	?		;Vide mode info
		@BVSSTART	BVSSETMODE

		EXTERN	VIOCHECKHANDLE: PROC
		MOV     BX,[DS:BP].ARGS.VIOHANDLE	; GET HANDLE
		CALL	VIOCHECKHANDLE
		JNZ	EXIT

		MOV	AX, ERROR_VIO_MODE
EXIT:
		@BVSEPILOG BVSSETMODE
_TEXT		ENDS
		END

