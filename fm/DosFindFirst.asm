
		.8086

		; Helpers
		INCLUDE	helpers.inc
		INCLUDE	dos.inc
		INCLUDE	bseerr.inc
		INCLUDE	GlobalVars.inc

		EXTERN	DOSFINDFIRST2: PROC

_TEXT	segment byte public 'CODE' USE16


;--------------------------------------------------------------
;/*!
;   @brief      Поиск первого файла, соответствующего маске
;   @details    Ищет первый файл, соответствующий указанной маске и атрибутам,
;               и инициализирует поисковый handle
;
;   @param[in]  FileAttribute   Атрибуты файла для поиска
;   @param[in]  pFileName       Указатель на строку с маской поиска
;   @param[out] pSearchBuf      Указатель на буфер для результатов поиска
;   @param[in]  cbSearchBuf     Размер буфера результатов
;   @param[out] pulSearchHandle Указатель на handle поиска
;   @param[in]  ulReserved      Указатель на флаг типа буфера
; (0-системный, 1-пользовательский)
;
;   @return     AX = 0 при успехе, код ошибки при сбое
;   @retval     NO_ERROR                 Успешное выполнение
;   @retval     ERROR_INVALID_PARAMETER  Неверный handle
;   @retval     ERROR_OUT_OF_MEMORY      Недостаточно памяти для буфера
;   @retval     ERROR_FILE_NOT_FOUND     Файл не найден
;
;   @remark     Для поиска используется DTA (Disk Transfer Area)
;*/
	@PROLOG DOSFINDFIRST
RESERVED	DD  ?   ; [bp+6]
SearchCount	DD	?	; [bp+10]
cbSearchBuf     DW  ?   ; [bp+14]
pSearchBuf      DD  ?   ; [bp+16]
FileAttribute   DW  ?   ; [bp+20]
pulSearchHandle DD  ?   ; [bp+22]
pFileName       DD  ?   ; [bp+26]
@LOCALW         TmpBP
@LOCALW		TmpCS
@LOCALW		TmpIP
		@START	DOSFINDFIRST

		;---------------------------------------------------------------
		; Parameter validation
		;---------------------------------------------------------------
		MOV	AX,ERROR_INVALID_PARAMETER    ; Default error code
    
		; Check reserved parameter == 0
		MOV	BX, WORD PTR [BP].ARGS.RESERVED
		OR	BX, WORD PTR [BP].ARGS.RESERVED+2
		JNZ	EXIT                    ; Jump if not zero

		POP	TmpBP                  ; Pop from stack frame
		POP	TmpCS
		POP	TmpIP
		PUSH	BX			; Add Reserved=0. EA=0 becase DOSMKDIR is NULL
		PUSH	BX
		CALL	FAR PTR DOSFINDFIRST2       ; Call DosFindFirst2

		PUSH	TmpIP                  ; Restore stack frame
		PUSH	TmpCS
		MOV	BP,TmpBP

EXIT:
		@EPILOG	DOSFINDFIRST                 ; Function epilogue

     
_TEXT	ends

	end
