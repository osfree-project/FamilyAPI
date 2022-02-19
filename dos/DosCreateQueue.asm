;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosCreateQueue DOS wrapper
;
;   (c) osFree Project 2022, <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;   Documentation: http://osfree.org/doku/en:docs:fapi:doscreatequeue
;
;0 NO_ERROR
;332 ERROR_QUE_DUPLICATE
;334 ERROR_QUE_NO_MEMORY
;335 ERROR_QUE_INVALID_NAME
;336 ERROR_QUE_INVALID_PRIORITY
;337 ERROR_QUE_INVALID_HANDLE
;
;*/

.8086

		; Helpers
		INCLUDE	HELPERS.INC

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

		@PROLOG	DOSCREATEQUEUE
QueueName	DD	?
QueuePrty	DW	?
RWHandle	DD	?
		@START	DOSCREATEQUEUE

		XOR	AX, AX
EXIT:
		@EPILOG	DOSCREATEQUEUE

_TEXT		ENDS

		END
