;/*!
;   @file
;
;   @ingroup fapi
;
;   @brief DosSearchPath DOS wrapper
;
;   (c) osFree Project 2022, 2024 <http://www.osFree.org>
;   for licence see licence.txt in root directory, or project website
;
;   This is Family API implementation for DOS, used with BIND tools
;   to link required API
;
;   @author Yuri Prokushev (yuri.prokushev@gmail.com)
;
;
;
;*/

.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	bseerr.inc

_TEXT		SEGMENT BYTE PUBLIC 'CODE' USE16

SEARCH_CUR_DIRECTORY	EQU 1
SEARCH_ENVIRONMENT		EQU	2

		; External functions
EXTERN		Pascal DosScanEnv: FAR
EXTERN		Pascal DosFindFirst: FAR

		@PROLOG	DOSSEARCHPATH
; Arguments
RESULTBUFFERLEN	DW	?	; 0ah Search result buffer length
RESULTBUFFER	DD	?	; 0ch Search result buffer (returned)
FILENAME		DD	?	; 10h File name string
PATHREF			DD	?	; 14h Search path reference string
CONTROL         DW	?	; 18h Function control vector
; Local variables
@LOCALW			SEARCHCOUNT	; -2h
@LOCALW			HANDLE		; -4h
@LOCALD			ENVSTR		; -8h
BUFSIZE			EQU 256
@LOCALA			BUF, BUFSIZE	; -108h
		@START	DOSSEARCHPATH

		; @todo Check arguments

		MOV		BX, WORD PTR [DS:BP].ARGS.PATHREF
		MOV		AX, WORD PTR [DS:BP].ARGS.PATHREF+2

		MOV		WORD PTR ENVSTR,BX 
		MOV		WORD PTR ENVSTR+2,AX 

		; Is need to search environment?
		TEST	BYTE PTR [DS:BP].ARGS.CONTROL, SEARCH_ENVIRONMENT
		JZ		USEPATHREF
		
		; Search environment variable
		PUSH	AX
		PUSH    BX
		MOV     BX, ENVSTR+2
		PUSH    BX
		MOV     BX, ENVSTR
		PUSH    BX
		CALL    DosScanEnv
		OR		AX, AX
		JNZ		EXIT

USEPATHREF:
		TEST    BYTE PTR [DS:BP].ARGS.CONTROL, SEARCH_CUR_DIRECTORY
		JZ      NOCURDIRSEARCH

		; construct '.\'+FILENAME
		MOV     SI, WORD PTR [DS:BP].ARGS.FILENAME
		MOV     CX, WORD PTR [DS:BP].ARGS.FILENAME+2
		MOV     BYTE PTR [BUF], '.'
		MOV     DX, DS 
		LEA     BX, BUF
		INC     BX 
		MOV     BYTE PTR [BX], '\'

COPYFN:
		INC     BX
		LEA     AX, BUF+BUFSIZE
		CMP     BX, AX
		JAE     EXITCOPYFN
		MOV     ES, CX
		MOV     AL, BYTE PTR ES:[SI]
		TEST    AL, AL
		JE      EXITCOPYFN
		MOV     ES, DX
		MOV     BYTE PTR ES:[BX], AL
		INC     SI
		JMP     COPYFN

EXITCOPYFN:
		MOV     ES,DX
		MOV     BYTE PTR ES:[BX],0H		; End of line

		; Search file
		LEA     BX, BUF 		; fnamebuffer
		PUSH    DS 
		PUSH    BX 
		LEA     BX, HANDLE
		PUSH    DS 
		PUSH    BX 
		MOV     AX, 00016H		; FILE_ | ....
		PUSH    AX 
		LEA     BX, [BP-0220H]  			; Filefindbuf
		PUSH    DS 
		PUSH    BX 
		MOV     AX, 00118H  			; size of Filefindbuf
		PUSH    AX 
		LEA     BX, SEARCHCOUNT
		PUSH    DS 
		PUSH    BX 
		XOR     AX, AX 
		PUSH    AX 
		PUSH    AX 
		CALL    DosFindFirst
		TEST    AX, AX 
		JNE     NOCURDIRSEARCH
		JMP		COPYRESULT

NOCURDIRSEARCH:
		les     bx, dword ptr [BUF+BUFSIZE] 
		cmp     byte ptr es:[bx], 0
		je      NOTFOUND
		mov     si, word ptr [ds:bp].ARGS.FILENAME
		mov     cx, word ptr [ds:bp].ARGS.FILENAME+2
		mov     dx, ds 
		lea     bx, BUF 		; fnamebuffer
L$11:
		lea     di, BUF+BUFSIZE
		cmp     bx, di
		jae     L$13 
		les     di,dword ptr [bp-08h] 
		mov     al,byte ptr es:[di] 
		test    al,al 
		je      L$13 
		cmp     al,';'
		je      L$13 
		inc     word ptr [bp-08h] 
		mov     al,byte ptr es:[di] 
		mov     es,dx 
		mov     byte ptr es:[bx],al 
		inc     bx 
		jmp     L$11

L$13:
		lea     ax,BUF 		; fnamebuffer
		cmp     bx,ax 
		jbe     L$15 
		lea     ax,[bp-08h] 
		cmp     bx,ax 
		jae     L$15 
		mov     es,dx 
		mov     al,byte ptr es:[bx-01h] 
		cmp     al,'\' 
		je      L$15 
		cmp     al,'/'
		je      L$15 
		mov     byte ptr es:[bx],'\' 
L$14:
		inc     bx 
L$15:
		lea     di,[bp-08h] 
		cmp     bx,di 
		jae     L$16 
		mov     es,cx 
		mov     al,byte ptr es:[si] 
		test    al,al 
		je      L$16 
		mov     es,dx 
		mov     byte ptr es:[bx],al 
		inc     si 
		jmp     L$14 

L$16:
		MOV     ES,DX 
		MOV     BYTE PTR ES:[BX],0H 			; End of line

		; Search file
		LEA     AX, BUF 		  		; Fnamebuffer
		PUSH    DS 
		PUSH    AX 
		LEA     BX, HANDLE
		PUSH    DS 
		PUSH    BX
		MOV     AX, 0016H 
		PUSH    AX 
		LEA     AX, [BP-0220H]  		;  Filefindbuf
		PUSH    DS 
		PUSH    AX 
		MOV     AX, 00118H 			; size of Filefindbuf
		PUSH    AX 
		LEA     AX, SEARCHCOUNT
		PUSH    DS 
		PUSH    AX 
		XOR     AX, AX 
		PUSH    AX 
		PUSH    AX 
		CALL    DOSFINDFIRST 
		TEST    AX, AX 
		JNE     L$20 

COPYRESULT:
		MOV     DX, DS
		LEA     BX, BUF 		; fnamebuffer
COPYLOOP:
		DEC     WORD PTR [DS:BP].ARGS.RESULTBUFFERLEN
		CMP     WORD PTR [DS:BP].ARGS.RESULTBUFFERLEN, 0FFFFH 
		JE      EXITCOPYLOOP 
		MOV     ES, DX 
		MOV     AL, BYTE PTR ES:[BX] 
		LES     SI, DWORD PTR [DS:BP].ARGS.RESULTBUFFER
		MOV     BYTE PTR ES:[SI], AL 
		TEST    AL, AL 
		JE      EXITCOPYLOOP 
		INC     WORD PTR [DS:BP].ARGS.RESULTBUFFER
		INC     BX 
		JMP     COPYLOOP 


L$20:
		mov     es,word ptr ENVSTR+2
L$21:
		mov     bx,word ptr ENVSTR
		mov     al,byte ptr es:[bx] 
		test    al,al 
		je      L$22 
		cmp     al,';' 
		je      L$22 
		inc     word ptr [ENVSTR] 
		jmp     L$21 

L$22:
		LES     BX, DWORD PTR [ENVSTR] 
		CMP     BYTE PTR ES:[BX], ';'
		JNE     NOCURDIRSEARCH
		INC     WORD PTR [ENVSTR] 
		JMP     NOCURDIRSEARCH

EXITCOPYLOOP:
		MOV     ES, DX 
		MOV     AL, BYTE PTR ES:[BX] 
		TEST    AL, AL 
		JE      RETAL 
		MOV     AX, ERROR_BUFFER_OVERFLOW 
		JMP     EXIT

NOTFOUND:
		MOV     AL, ERROR_FILE_NOT_FOUND
RETAL:
		XOR     AH, AH 
EXIT:
		@EPILOG	DOSSEARCHPATH

_TEXT		ENDS

		END
